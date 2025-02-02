%rng(352); % random number generator seed for BLER test
k = 3;    % number of input bits
M = 2^k;  % number of possible input symbols
n = 2;    % number of channel uses
EbNo = 7; % Eb/No in dB
SNR = 30;

Pmax = 1; % Maximum tx signal power

KFactor = 3;                  % In dB
KFactorLin = 10.^(KFactor/10); % Linear units

c = 1;    % No of antenna selection bits
d = k-c;  % No of data bits
M_d = 2^d;% number of possible input symbols
Nt = 2^c; % number of transmit antennas

bits_transmitted = k; % number of bits modulated and transmitted through the transmit signal
R = bits_transmitted/n; 

% Convert Eb/No to channel Eb/No values using the code rate
EbNoChannel = EbNo + 10*log10(R);

InputLayer = featureInputLayer(M+Nt+2*Nt,"Name","input","Normalization","none"); % Input is one hot encoding of data symbols and control symbols
DataL = DataLayer(Nt, M,'DataLayer');
ControlL = ControlLayer(Nt, 'ControlLayer');
pathGainL = pathGainLayer(2*Nt, 'pathGainLayer');

encoder = [
    fullyConnectedLayer(64,"Name","fc_1")
    reluLayer("Name","relu_1")
    
    fullyConnectedLayer(n,"Name","fc_2")
    
    helperAEWNormalizationLayer("Method", "Average power", "Pmax",Pmax, "Name", "wnorm")
    ];

SML = SMLayer(Nt,'SMLayer');
MIMOL = Matlab_MIMOLayer(Nt,'MIMOLayer');


awgnL = helperAEWAWGNLayer("Name","awgn",...
    "NoiseMethod","EbNo",...
    "EbNo",EbNoChannel,...
    "BitsPerSymbol",2,...
    "SignalPower",0); % power in dB

concat = concatenationLayer(1,2,'Name','concat'); % concatenate op of awgnL and pathGainL along each column

decoder = [
    fullyConnectedLayer(64,"Name","fc_3")
    reluLayer("Name","relu_2")
    fullyConnectedLayer(64,"Name","fc_5")
    reluLayer("Name","relu_5")
    fullyConnectedLayer(M,"Name","fc_4")
    softmaxLayer("Name","softmax")
    classificationLayer("Name","classoutput")
    ];

lgraph = layerGraph();
lgraph = addLayers(lgraph, InputLayer);
lgraph = addLayers(lgraph, DataL);
lgraph = addLayers(lgraph, ControlL);
lgraph = addLayers(lgraph, pathGainL);
lgraph = addLayers(lgraph, encoder);
lgraph = addLayers(lgraph, SML);
lgraph = addLayers(lgraph, MIMOL);
lgraph = addLayers(lgraph, awgnL);
lgraph = addLayers(lgraph, concat);
lgraph = addLayers(lgraph, decoder);

lgraph = connectLayers(lgraph, 'input', 'DataLayer');
lgraph = connectLayers(lgraph, 'input', 'ControlLayer');
lgraph = connectLayers(lgraph, 'input', 'pathGainLayer');
lgraph = connectLayers(lgraph, 'DataLayer', 'fc_1');
lgraph = connectLayers(lgraph, 'wnorm', 'SMLayer/in1');
lgraph = connectLayers(lgraph, 'ControlLayer', 'SMLayer/in2');
lgraph = connectLayers(lgraph, 'SMLayer', 'MIMOLayer/in1');
lgraph = connectLayers(lgraph, 'pathGainLayer', 'MIMOLayer/in2');
lgraph = connectLayers(lgraph, 'MIMOLayer', 'awgn');
lgraph = connectLayers(lgraph, 'awgn', 'concat/in1');
lgraph = connectLayers(lgraph, 'pathGainLayer', 'concat/in2');
lgraph = connectLayers(lgraph, 'concat', 'fc_3');


%plot(lgraph);

%analyzeNetwork(lgraph);

trainNow = true; %#ok<*NASGU>

normalization = "Average power";   % Normalization "Energy" | "Average power"

if trainNow
  [txNet22e,rxNet22e,info22e,wirelessAutoEncoder22e] = ...
    TrainNetwork_power_constraint(n,k,c,SNR,Pmax,normalization,EbNo,KFactorLin); %#ok<*UNRCH>
end

%analyzeNetwork(wirelessAutoEncoder22e)

 figure
% helperAEWPlotTrainingPerformance(info22e)

% subplot(1,2,1)
 helperAEWPlotConstellation(txNet22e,'wnorm')
title("Control bit Encoded AE with Power norm for Rician Factor = " + KFactor + ", c = "+ c +" d = " + d)
% subplot(1,2,2)
% helperAEWPlotReceivedConstellation(wirelessAutoEncoder22e)
% title('Received Constellation')
% sgtitle(["No. of Tx Antennas: " + Nt, "With normalization Layer", "Modulation order: " + d, "SM MIMO (Rician Fading, 3)","SNR = " + SNR + " dB"])

% Simulate the block error rate (BLER) performance
simParams.EbNoVec = 0:0.5:40;
simParams.MinNumErrors = 10;
simParams.MaxNumFrames = 300;
simParams.NumSymbolsPerFrame = 10000;
simParams.SignalPower = 1;

EbNoVec = simParams.EbNoVec;
R = bits_transmitted/n;

frame_length = 1000;
num_frames = 10;

test_data = readmatrix('datasets\c1d2_rician3\test_data.csv'); %[data pathGains]
numTestSymbols = size(test_data,1);

d = real(test_data(:,1));
pathGains = test_data(:,2:3);

M = 2^k;
BLER = zeros(size(EbNoVec));
for EbNoIdx = 1:length(EbNoVec)
  EbNo = EbNoVec(EbNoIdx) + 10*log10(R);
  mimochan = Matlab_MIMOLayer(Nt,'MIMOLayer');
  awgnchan = comm.AWGNChannel("BitsPerSymbol",2, ...
    "EbNo", EbNo, "SamplesPerSymbol", 1, "SignalPower", 1);

  numBlockErrors = 0;
  frameCnt = 0;

    x = helperAEWEncode(d, pathGains, k,c,txNet22e);                      % Encoder
    x = [real(x) imag(x)].';                              % Change format to input of MIMO layer
    ymimochan = mimochan.predict(x,[real(pathGains) imag(pathGains)].');                          % Pass through MIMO layer
    ymimo = complex(ymimochan(1,:), ymimochan(2,:)).';            % Convert op of MIMO layer to complex numbersw
    y = awgn(ymimo, EbNoVec(EbNoIdx) + 10*log10(bits_transmitted), 'measured');
    dHat = helperAEWDecode(y, pathGains, rxNet22e);                   % Decoder

    numBlockErrors = numBlockErrors + sum(d ~= dHat);
    frameCnt = frameCnt + 1;
%   end
  BLER(EbNoIdx) = numBlockErrors / (num_frames*frame_length);
end
%save('Results/Energy_rician50_c1d2.mat','BLER');
%save('Results/Power1_rician20_c1d3_EbNo15_batch128_encoder1.mat','BLER');
%save('Models/Power1_rician20_c1d3_EbNo15_batch128_encoder1','wirelessAutoEncoder22e');

% BLER of baselines
BLER_psk_frame = zeros([num_frames,size(EbNoVec,2)]);
BLER_qam_frame = zeros([num_frames,size(EbNoVec,2)]);
for i = 1:num_frames
    BLER_psk_frame(i,:) = bler_sm_psk_mld_new(k,c,d((i-1)*frame_length + 1:i*frame_length,:),EbNoVec,pathGains((i-1)*frame_length + 1,:));
    BLER_qam_frame(i,:) = bler_sm_qam_mld_new(k,c,d((i-1)*frame_length + 1:i*frame_length,:),EbNoVec,pathGains((i-1)*frame_length + 1,:));

end

BLER_psk = zeros(size(EbNoVec));
BLER_psk = sum(BLER_psk_frame)./num_frames;
BLER_qam = zeros(size(EbNoVec));
BLER_qam = sum(BLER_qam_frame)./num_frames;

figure
y_min = 10^(-6);
BLER(BLER==0)=y_min/10;
BLER_psk(BLER_psk==0)=y_min/10;
BLER_qam(BLER_qam==0)=y_min/10;
semilogy(simParams.EbNoVec,BLER,'-*')
hold on
semilogy(EbNoVec,BLER_psk,'-*');
semilogy(EbNoVec,BLER_qam,'-*');
hold off
grid on

databits = k-c;
hold off
ylim([y_min 1])
grid on
xlabel('E_b/N_o (dB)')
ylabel('BLER')
legend("Control bit encoded Autoencoder","PSK SM with MLD","QAM SM with MLD")

%inputSymbols = repmat(eye(2^k),2,1)
%y = activations(wirelessAutoEncoder22e, inputSymbols, 'wnorm')

%inputSymbols = [1;2;3;4;5];
%y = activations(trainedNet, inputSymbols, 'input')
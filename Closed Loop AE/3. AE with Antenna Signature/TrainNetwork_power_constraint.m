function [txNet,rxNet,info,trainedNet] = ...
  TrainNetwork_power_constraint(n,k,c,SNR,Pmax,normalization,EbNo,varargin)

% Derived parameters
M = 2^k;
d = k-c;  % No of data bits
M_d = 2^d;% number of possible input symbols
Nt = 2^c; % number of transmit antennas

bits_transmitted = k; % number of bits modulated and transmitted through the transmit signal
R = bits_transmitted/n; 

  trainParams.MaxEpochs = 15;
  trainParams.MiniBatchSize = 1024;
  trainParams.InitialLearnRate = 0.01;
  trainParams.LearnRateSchedule = 'piecewise';
  trainParams.LearnRateDropPeriod = 10;
  trainParams.LearnRateDropFactor = 0.1;
  trainParams.Plots = 'none';
  trainParams.Verbose = true;
  trainParams.L2Regularization = 0.0005;
%end

% Convert Eb/No to channel Eb/No values using the code rate
EbNoChannel = EbNo + 10*log10(R);


frame_length = 1000;
numTrainSymbols = frame_length * 80; % 80 frames % 2500 * M
numValidationSymbols = frame_length * 10; % 10 frames % 100 * M
numTestSymbols = frame_length * 10; % 10 frames % 100 * M;

InputLayer = featureInputLayer(M_d+Nt+2*Nt,"Name","input","Normalization","none"); % Input is one hot encoding of data symbols and control symbols
DataL = DataLayer(M_d, Nt, M_d+2,'DataLayer');
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
    "SignalPower",0);

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

train_data = readmatrix('datasets\c1d2_rician3\train_data.csv'); %[data pathGains]
validation_data = readmatrix('datasets\c1d2_rician3\validation_data.csv'); %[data pathGains]
numTrainSymbols = size(train_data,1);
numValidationSymbols = size(validation_data,1);

d = [real(train_data(:,1)); real(validation_data(:,1))];
pathGains = [train_data(:,2:3); validation_data(:,2:3)];

Bin = de2bi(d,k,'left-msb'); % Converting decimal symbols to binary
ControlBin = Bin(:,1:c); % First c bits are control bits
DataBin = Bin(:,c+1:k); % Last d bits are data bits
ControlIn = bi2de(ControlBin,'left-msb'); % Antenna ID in integer
DataIn = bi2de(DataBin,'left-msb'); % Data symbol in integer

%One-hot encoding of data symbols
DataSymbols = zeros(numTrainSymbols+numValidationSymbols,M_d);
DataSymbols(sub2ind([numTrainSymbols+numValidationSymbols, M_d],...
    (1:numTrainSymbols+numValidationSymbols)',DataIn+1)) = 1;

%One-hot encoding of control symbols
ControlSymbols = zeros(numTrainSymbols+numValidationSymbols,Nt);
ControlSymbols(sub2ind([numTrainSymbols+numValidationSymbols, Nt],...
    (1:numTrainSymbols+numValidationSymbols)',ControlIn+1)) = 1;

Symbols = [ControlSymbols DataSymbols real(pathGains) imag(pathGains)];
Labels = categorical(d);

% First numTrainSymbols are training samples
trainSymbols = Symbols(1:numTrainSymbols,:);
trainLabels = Labels(1:numTrainSymbols,:);

% Next numValidationSymbols are validation samples 
validationSymbols = Symbols(numTrainSymbols+1:numTrainSymbols+numValidationSymbols,:);
validationLabels = Labels(numTrainSymbols+1:numTrainSymbols+numValidationSymbols,:);

% Set training options
options = trainingOptions('adam', ...
  'InitialLearnRate',trainParams.InitialLearnRate, ...
  'MaxEpochs',trainParams.MaxEpochs, ...
  'MiniBatchSize',trainParams.MiniBatchSize, ...
  'Shuffle','every-epoch', ...
  'ValidationData',{validationSymbols,validationLabels}, ...
  'LearnRateSchedule', trainParams.LearnRateSchedule, ...
  'LearnRateDropPeriod', trainParams.LearnRateDropPeriod, ...
  'LearnRateDropFactor', trainParams.LearnRateDropFactor, ...
  'Plots', trainParams.Plots, ...
  'Verbose', trainParams.Verbose);

% Train the autoencoder network
[trainedNet,info] = trainNetwork(trainSymbols,trainLabels,lgraph,options);


%Separate the network into encoder and decoder parts. Encoder starts with
%the input layer and ends after the normalization layer.
lgraph_1 = layerGraph();
for idxNorm = 1:length(trainedNet.Layers)
  if convertCharsToStrings(trainedNet.Layers(idxNorm).Name) ~= 'pathGainLayer'
    lgraph_1 = addLayers(lgraph_1, trainedNet.Layers(idxNorm));
  end
  if convertCharsToStrings(trainedNet.Layers(idxNorm).Name) == 'SMLayer'
    break
  end
end
lgraph_1 = addLayers(lgraph_1, regressionLayer('Name', 'txout'));
lgraph_1 = connectLayers(lgraph_1, 'input', 'DataLayer');
lgraph_1 = connectLayers(lgraph_1, 'input', 'ControlLayer');
lgraph_1 = connectLayers(lgraph_1, 'DataLayer', 'fc_1');
lgraph_1 = connectLayers(lgraph_1, 'fc_1', 'relu_1');
lgraph_1 = connectLayers(lgraph_1, 'relu_1', 'fc_2');
lgraph_1 = connectLayers(lgraph_1, 'fc_2', 'wnorm');
lgraph_1 = connectLayers(lgraph_1, 'wnorm', 'SMLayer/in1');
lgraph_1 = connectLayers(lgraph_1, 'ControlLayer', 'SMLayer/in2');
lgraph_1 = connectLayers(lgraph_1,'SMLayer','txout');
txNet = assembleNetwork(lgraph_1);

% Decoder starts after the channel layer and ends with the classification
% layer. Add a feature input layer at the beginning. 
for idxChan = idxNorm:length(trainedNet.Layers)
  if isa(trainedNet.Layers(idxChan), 'helperAEWAWGNLayer')
    break
  end
end
firstLayerName = trainedNet.Layers(idxChan+2).Name;
n = trainedNet.Layers(idxChan+2).InputSize;
lgraph_1 = addLayers(layerGraph(featureInputLayer(n,'Name','rxin')), ...
  trainedNet.Layers(idxChan+2:end));
lgraph_1 = connectLayers(lgraph_1,'rxin',firstLayerName);
rxNet = assembleNetwork(lgraph_1);

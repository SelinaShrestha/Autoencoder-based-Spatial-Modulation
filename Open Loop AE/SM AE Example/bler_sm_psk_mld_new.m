function BLER = bler_sm_psk_mld_new(k,c,d,EbNoVec,pathGains)
%rng(352);
samples = size(d,1);
%k = 3;
%c = 1;
n =2;

M = 2^k;
M_d = 2^(k-c);
Nt = 2^c;

bits_transmitted = k-c; % number of bits modulated and transmitted through the transmit signal
R = bits_transmitted/n;

%EbNoVec = 0:0.5:20;
BLER = zeros(size(EbNoVec));

for EbNoIdx = 1:length(EbNoVec)
EbNo = EbNoVec(EbNoIdx) + 10*log10(R);
% Generate random  data symbols
%d = randi([0 M-1],samples,1);

Bin = de2bi(d,k,'left-msb'); % Converting decimal symbols to binary
ControlBin = Bin(:,1:c); % First c bits are control bits
DataBin = Bin(:,c+1:k); % Last d bits are data bits
ControlIn = bi2de(ControlBin,'left-msb'); % Antenna ID in integer
DataIn = bi2de(DataBin,'left-msb'); % Data symbol in integer

% QAM modulation of data symbols
dataMod = pskmod(DataIn,M_d);

% Spatial Modulation
txSig = zeros(samples, Nt);
for i = 1:samples
    txSig(i,ControlIn(i)+1) = dataMod(i);
end

rxSig = txSig*pathGains.'; % MIMO channel
% awgn channel
awgnchan = comm.AWGNChannel("BitsPerSymbol",2, ...
    "EbNo", EbNo, "SamplesPerSymbol", 1, "SignalPower", 1);
%rxSig = awgnchan(rxSig);
rxSig = awgn(rxSig, EbNoVec(EbNoIdx) + 10*log10(bits_transmitted), 'measured');

% MLD receiver
lut = pskmod([0:M_d-1],M_d); % look up table for qammod
lut_mimo = zeros(M_d, Nt); % M_d x Nt Rx signal for each qammod symbol and Tx antenna
error = zeros(samples, Nt, M_d); % Diff betn Rx sig and lut_mimo for each data symbol
sq_error = zeros(samples, Nt, M_d);
for i = 1:M_d
    lut_mimo(i,:) = pathGains*lut(i); % M_d x Nt Rx signal for each qammod symbol and Tx antenna
    error(:,:,i) = repmat(rxSig,1,Nt)-lut_mimo(i,:); % samples x Nt x M_d
    sq_error(:,:,i) = abs(error(:,:,i)).^2; 
end
predicted_DataIn = zeros(samples,1);
predicted_ControlIn = zeros(samples,1);
new_sq_error = permute(sq_error,[3,2,1]); % switch 1st and 3rd dim, size = M_d x Nt x samples
for i = 1:samples
    sq_error_i = new_sq_error(:,:,i);
    minValue = min(sq_error_i(:));
    [row, col] = find(sq_error_i == minValue);
    predicted_DataIn(i) = row - 1;
    predicted_ControlIn(i) = col -1;
end

predicted_DataBin = de2bi(predicted_DataIn,k-c,'left-msb');
predicted_ControlBin = de2bi(predicted_ControlIn,c,'left-msb');
predicted_Bin = [predicted_ControlBin predicted_DataBin];
predicted_d = bi2de(predicted_Bin,'left-msb');

numBlockErrors = sum(d ~= predicted_d);
BLER(EbNoIdx) = numBlockErrors/ samples;
end
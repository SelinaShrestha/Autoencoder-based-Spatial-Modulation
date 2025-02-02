function xComplex = helperAEWEncode(d, pathGains, k,c,txNet)
%helperAEWEncode Autoencoder encoder network
%   X = helperAEWEncode(D,TX) encodes the data symbols, D, using the
%   encoder network, TX, and returns complex symbols, X. D must be and
%   integer between 0 and M-1, where M = 2^k and k is the number of input
%   bits per block for the encoder.
%
%   See also AutoencoderForWirelessCommunicationsExample, 
%   helperAEWDecode, helperAEWTrainWirelessAutoencoder.

%   Copyright 2020 The MathWorks, Inc.

%M = txNet.Layers(1).InputSize;
M = 2^k;
numSymbolsPerFrame = length(d);
M_d = 2^(k-c);% number of possible input symbols
Nt = 2^c; % number of transmit antennas
% inputSymbols = zeros(numSymbolsPerFrame,M);
% inputSymbols(sub2ind([numSymbolsPerFrame, M],...
%   (1:numSymbolsPerFrame)',d+1)) = 1;

Bin = de2bi(d,k,'left-msb'); % Converting decimal symbols to binary
ControlBin = Bin(:,1:c); % First c bits are control bits
DataBin = Bin(:,c+1:k); % Last d bits are data bits
ControlIn = bi2de(ControlBin,'left-msb'); % Antenna ID in integer
DataIn = bi2de(DataBin,'left-msb'); % Data symbol in integer

%One-hot encoding of data symbols
DataSymbols = zeros(numSymbolsPerFrame,M);
DataSymbols(sub2ind([numSymbolsPerFrame, M],...
    (1:numSymbolsPerFrame)',d+1)) = 1;

%One-hot encoding of control symbols
ControlSymbols = zeros(numSymbolsPerFrame,Nt);
ControlSymbols(sub2ind([numSymbolsPerFrame, Nt],...
    (1:numSymbolsPerFrame)',ControlIn+1)) = 1;

inputSymbols = [ControlSymbols DataSymbols real(pathGains) imag(pathGains)];

x = predict(txNet, inputSymbols);
Re_txSig = x(:,1:Nt); % First Nt cols are real parts of SM tx signal
Im_txSig = x(:,Nt+1:2*Nt); % Next Nt cols are imag parts of SM tx signal
xComplex = complex(Re_txSig,Im_txSig);
end
function helperAEWPlotReceivedConstellation(trainedNet)
%helperAEWPlotReceivedConstellation Plot received constellation
%   helperAEWPlotReceivedConstellation(NET) plots the autoencoder received
%   constellation interpreting the decoder input as an interleaved complex
%   number sequence. Simulate 10000 symbols. Map the real samples to
%   complex samples by using odd samples as real part (in-phase) and even
%   samples as imaginary part (quadrature).
%
%   See also AutoencoderForWirelessCommunicationsExample, helperAEWEncode,
%   helperAEWDecode, helperAEWAWGNLayer, tsne.

%   Copyright 2020 The MathWorks, Inc.

M = trainedNet.Layers(1).InputSize;
numSymbolsPerFrame = 10000;
d = randi([0 M-1],numSymbolsPerFrame,1);
inputSymbols = zeros(numSymbolsPerFrame,M);
for p = 1:numSymbolsPerFrame
  inputSymbols(p,d(p)+1) = 1;
end
y = activations(trainedNet, inputSymbols, 'awgn');
y = y(1,:) + 1i* y(2,:);
plot(y,'*','Tag','aew_rvcd_constellation')
grid on
axis equal
%axis([-1.5 1.5 -1.5 1.5])
xlabel('In phase')
ylabel('Quadrature')
function dHat = helperAEWDecode(y, pathGains, rxNet)
%helperAEWDecode Autoencoder decoder network
%   D = helperAEWDecode(Y,RX) decodes the received complex symbols, Y,
%   using the decoder network, RX, and returns received symbol estimates,
%   D. D is an integer between 0 and M-1, where M = 2^k and k is the
%   number of input bits per block for the encoder.
%
%   See also AutoencoderForWirelessCommunicationsExample, 
%   helperAEWEncode, helperAEWTrainWirelessAutoencoder.

%   Copyright 2020 The MathWorks, Inc.

n = rxNet.Layers(1).InputSize;
yNet = [real(y) imag(y) real(pathGains) imag(pathGains)];

xHatSoft = predict(rxNet,yNet);
[~,dHat] = max(xHatSoft,[],2);
dHat = dHat - 1;
end
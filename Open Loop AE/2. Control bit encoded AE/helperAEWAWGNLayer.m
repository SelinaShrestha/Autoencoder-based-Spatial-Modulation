classdef helperAEWAWGNLayer < nnet.layer.Layer
%helperAEWAWGNLayer AWGN layer
%   layer = helperAEWAWGNLayer creates an AWGN layer. 
%
%   layer = helperAEWAWGNLayer('PARAM1', VAL1, 'PARAM2', VAL2, ...)
%   specifies optional parameter name/value pairs for creating the layer:
%
%       'Name'          - A name for the layer. The default is ''.
%       'NoiseMethod'   - Noise method as one of 'EbNo', 'EsNo' and 'SNR'. 
%                         The default is 'EsNo'.
%       'EbNo'          - Eb/No in dB. The default is 10.
%       'EsNo'          - Es/No in dB. The default is 10.
%       'SNR'           - SNR in dB. The default is 10.
%       'BitsPerSymbol' - Number of bits per symbol. The default is 1.
%       'SignalPower'   - Signal power. The default is 1.
%
%   See also AutoencoderForWirelessCommunicationsExample, helperAEWEncode,
%   helperAEWDecode, helperAEWNormalizationLayer.

%   Copyright 2020 The MathWorks, Inc.
  
  properties
    NoiseMethod {mustBeMember(NoiseMethod,{'EbNo','EsNo','SNR'})} = 'EsNo' 
    EbNo = 10
    EsNo = 10
    SNR = 10
    BitsPerSymbol = 1
    SignalPower = 1
  end
  
  properties (SetAccess=private,GetAccess=private)
    LocalEsNo
    LocalSNR
  end
  
  methods
    function layer = helperAEWAWGNLayer(varargin)
      p = inputParser;
      addParameter(p,'NoiseMethod','EbNo')
      addParameter(p,'EbNo',10)
      addParameter(p,'EsNo',10)
      addParameter(p,'SNR',10)
      addParameter(p,'BitsPerSymbol',1)
      addParameter(p,'SignalPower',1)
      addParameter(p,'Name','awgn')
      addParameter(p,'Description','')
      
      parse(p,varargin{:})
      layer.NoiseMethod = p.Results.NoiseMethod;
      layer.EbNo = p.Results.EbNo;
      layer.EsNo = p.Results.EsNo;
      layer.SNR = p.Results.SNR;
      layer.BitsPerSymbol = p.Results.BitsPerSymbol;
      layer.SignalPower = p.Results.SignalPower;
      layer.Name = p.Results.Name;
      if isempty(p.Results.Description)
        switch p.Results.NoiseMethod
          case 'EbNo'
            value = layer.EbNo;
          case 'EsNo'
            value = layer.EsNo;
          case 'SNR'
            value = layer.SNR;
        end
        layer.Description = "AWGN channel with " + p.Results.NoiseMethod ...
          + " = " + num2str(value);
      else
        layer.Description = p.Results.Description;
      end
      layer.Type = 'AWGN Channel';

      samplesPerSymbol = 1;
      if strcmp(layer.NoiseMethod, 'EbNo')
        EsNo = layer.EbNo + 10*log10(layer.BitsPerSymbol);
        layer.LocalSNR = EsNo - 10*log10(samplesPerSymbol);
      elseif strcmp(layer.NoiseMethod, 'EsNo')
        EsNo = layer.EsNo;
        layer.LocalSNR = EsNo - 10*log10(samplesPerSymbol);
      else
        layer.LocalSNR = layer.SNR;
      end
    end
    
    function z = predict(layer, x)
      % Forward input data through the layer at prediction time and
      % output the result.
      %
      % Inputs:
      %         layer  - Layer to forward propagate through
      %         X      - Input samples
      % Outputs:
      %         Z      - AWGN impaired symbols
      
      % In case the input has odd number of elements, we need to append the
      % input to get full I/Q symbols. This should never happen during
      % training if minibatch size is even.
      numElem = numel(x);
      if mod(numElem,2)
        append = true;
        x = [x; zeros(1,size(x,2))];
      else
        append = false;
      end
      
      x2 = reshape(x, 2, []);
      % AWGN adds half the noise power to I and half to the Q component, if
      % the input is complex. Since X is always "real", where real and
      % imaginary parts are serialized, we need to reduce the signal power
      % by half to get awgn do the right value.
      %z2 = awgn(x2,layer.LocalSNR,(layer.SignalPower)-10*log10(2));
      z2 = awgn(x2,layer.LocalSNR + 10*log10(2),'measured');
      z = reshape(z2,size(x));

      if append
        z = z(1:end-1,1);
      end
    end
    
    function dLdX = ...
        backward(layer, X, Z, dLdZ,memory)
      % (Optional) Backward propagate the derivative of the loss
      % function through the layer.
      %
      % Inputs:
      %         layer             - Layer to backward propagate through
      %         X1, ..., Xn       - Input data
      %         Z1, ..., Zm       - Outputs of layer forward function
      %         dLdZ1, ..., dLdZm - Gradients propagated from the next layers
      %         memory            - Memory value from forward function
      % Outputs:
      %         dLdX1, ..., dLdXn - Derivatives of the loss with respect to the
      %                             inputs
      %         dLdW1, ..., dLdWk - Derivatives of the loss with respect to each
      %                             learnable parameter
      
      dLdX = dLdZ;
    end
    
    function sl = saveobj(layer)
      sl.NoiseMethod = layer.NoiseMethod;
      sl.EbNo = layer.EbNo;
      sl.EsNo = layer.EsNo;
      sl.SNR = layer.SNR;
      sl.BitsPerSymbol = layer.BitsPerSymbol;
      sl.SignalPower = layer.SignalPower;
      sl.LocalEsNo = layer.LocalEsNo;
      sl.LocalSNR = layer.LocalSNR;
    end
    
    function layer = reload(layer,sl)
      layer.NoiseMethod = sl.NoiseMethod;
      layer.EbNo = sl.EbNo;
      layer.EsNo = sl.EsNo;
      layer.SNR = sl.SNR;
      layer.BitsPerSymbol = sl.BitsPerSymbol;
      layer.SignalPower = sl.SignalPower;
      layer.LocalEsNo = sl.LocalEsNo;
      layer.LocalSNR = sl.LocalSNR;
    end
  end
  
  methods (Static)
    function layer = loadobj(sl)
      if isstruct(sl)
        layer = helperAEWAWGNLayer;
      else
        layer = sl;
      end
      layer = reload(layer,sl);
    end
  end
end
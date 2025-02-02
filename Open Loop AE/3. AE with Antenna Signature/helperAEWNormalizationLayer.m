
classdef helperAEWNormalizationLayer < nnet.layer.Layer
%helperAEWNormalizationLayer Wireless symbol normalization layer
%   layer = helperAEWNormalizationLayer creates a wireless symbol
%   normalization layer. 
%
%   layer = helperAEWNormalizationLayer('PARAM1', VAL1, 'PARAM2', VAL2, ...)
%   specifies optional parameter name/value pairs for creating the layer:
%
%       'Name'   - A name for the layer. The default is ''.
%       'Method' - Normalization method as one of 'Energy' and 
%                  'Average power'. The default is 'Energy'.
%
%   Example:
%       % Create a normalization layer for energy normalization.
%
%       layer = helperAEWNormalizationLayer('Method','Energy');
%
%   See also AutoencoderForWirelessCommunicationsExample, helperAEWEncode,
%   helperAEWDecode, helperAEWAWGNLayer.

%   Copyright 2020 The MathWorks, Inc.

  properties
    Method {mustBeMember(Method,{'Energy','Average power'})} = 'Energy'
    Pmax = 1
  end
  
  methods
    function layer = helperAEWNormalizationLayer(varargin)
      p = inputParser;
      addParameter(p,'Method','Energy')
      addParameter(p,'Pmax',1) % default avg power = 1
      addParameter(p,'Name','wnorm')
      addParameter(p,'Description','')
      
      parse(p,varargin{:})
      
      layer.Method = p.Results.Method;
      layer.Pmax = p.Results.Pmax;
      layer.Name = p.Results.Name;
      if isempty(p.Results.Description)
        layer.Description = p.Results.Method + " normalization layer";
      else
        layer.Description = p.Results.Description;
      end
      
      layer.Type = 'Wireless Normalization';
    end
    
    function z = predict(layer, x)
      % Forward input data through the layer at prediction time and
      % output the result.
      %
      % Inputs:
      %         layer  - Layer to forward propagate through
      %         X      - Input samples
      % Outputs:
      %         Z      - Normalized samples
      
      n = size(x,1);
      if strcmp(layer.Method, 'Energy')
        z = x ./ sqrt(sum(x.^2)/(n/2)); %abs(signal) <= 1
      elseif strcmp(layer.Method, 'Average power')
        z = (x.*layer.Pmax) ./ sqrt(mean(x.^2,'all')*2); % Avg power <= Pmax
      end
    end
  end
end
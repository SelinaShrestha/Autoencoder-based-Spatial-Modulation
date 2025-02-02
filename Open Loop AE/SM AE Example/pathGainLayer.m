classdef pathGainLayer < nnet.layer.Layer %& nnet.layer.Formattable %(Optional) 
    
    properties
        numOutputs;
        Nt;
    end
    
    methods
        function layer = pathGainLayer(numOutputs, name)
            % (Optional) Create a myLayer.
            % This function must have the same name as the class.

            % Layer constructor function goes here.
            %layer.Nt = Nt; % num of control symbols
            layer.numOutputs = numOutputs; % no of data symbols

            % Set layer name.
            layer.Name = name;
        end
        
        function Z = predict(layer, X)
            % Forward input data through the layer at prediction time and
            % output the result.
            %
            % Inputs:
            %         layer       - Layer to forward propagate through
            %         X1, ..., Xn - Input data
            % Outputs:
            %         Z1, ..., Zm - Outputs of layer forward function
            
            % Layer forward function for prediction goes here.
            Z = X(size(X,1)-layer.numOutputs + 1:size(X,1),:); % last numOutputs rows are real and imag parts of pathGains
            %Z = X(layer.Nt + 1: layer.Nt + layer.numOutputs,:);
        end
        
%          function dLdX = backward(layer, X, Z, dLdZ,memory)
%              dLdX = zeros(size(X), 'like', dLdZ);
%              dLdX(size(X,1)-layer.numOutputs + 1:size(X,1),:) = dLdZ;
%          end
        
        
        
    end
end
classdef ControlLayer < nnet.layer.Layer %& nnet.layer.Formattable %(Optional) 
    
    properties
        numOutputs;
    end
    
    methods
        function layer = ControlLayer(numOutputs, name)
            % (Optional) Create a myLayer.
            % This function must have the same name as the class.

            % Layer constructor function goes here.
            layer.numOutputs = numOutputs; % no of control symbols

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
            %Z = X(1:layer.numOutputs,:); % first numOutputs rows are one hot encoding of control symbols
            %One hot encoded values to decimal
            Z = X(1:layer.numOutputs,:);
            %[~, Z] = max(X(1:layer.numOutputs,:)',[],2);
            %Z = cast(Z' - 1, 'like', X);
        end
        
%          function dLdX = backward(layer, X, Z, dLdZ,memory)
%              dLdX = zeros(size(X), 'like', dLdZ); % Gradient 0 because no need to propagate to i/p layer
%              %dLdX(1:layer.numOutputs, :) = dLdZ;
%              %dLdX = dlgradient(dlarray(Z),dlarray(X));
%          end
        
        
        
    end
end
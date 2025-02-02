classdef AWGNLayer < nnet.layer.Layer %& nnet.layer.Formattable %(Optional) 
    
    properties
        SNR;
    end
    
    methods
        function layer = AWGNLayer(SNR, name)
            % (Optional) Create a myLayer.
            % This function must have the same name as the class.

            % Layer constructor function goes here.
            layer.SNR = SNR; % no of data symbols

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
            Z = awgn(X,layer.SNR);
        end
        
         function dLdX = backward(layer, X, Z, dLdZ,memory)
             dLdX = dLdZ;
         end
        
        
        
    end
end
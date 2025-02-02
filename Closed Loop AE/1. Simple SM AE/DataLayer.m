classdef DataLayer < nnet.layer.Layer %& nnet.layer.Formattable %(Optional) 
    
    properties
        numOutputs;
        M_d;
        Nt;
    end
    
    methods
        function layer = DataLayer(M_d, Nt,numOutputs, name)
            % (Optional) Create a myLayer.
            % This function must have the same name as the class.

            % Layer constructor function goes here.
            layer.M_d = M_d; % num of control symbols
            layer.Nt = Nt; % num of control symbols
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
            %Z = X(size(X,1)-layer.numOutputs + 1:size(X,1),:); % last numOutputs rows are one hot encoding of data symbols
            %Z = X(layer.Nt + 1: layer.Nt + layer.numOutputs,:);
            Z = X(layer.Nt + 1: layer.Nt + layer.M_d,:); %data symbols
            
            antenna_sel = X(1:layer.Nt,:); % control symbol
            
            % Extract real and imaginary parts of selected pathgain
            Re_pathGain = sum((X(size(X,1)- 2*layer.Nt + 1:size(X,1)- layer.Nt,:)).*antenna_sel, 1);
            Im_pathGain = sum((X(size(X,1)- layer.Nt + 1:size(X,1),:)).*antenna_sel, 1);
            
            Z = [Z; Re_pathGain; Im_pathGain];
        end
        
%          function dLdX = backward(layer, X, Z, dLdZ,memory)
%              dLdX = zeros(size(X), 'like', dLdZ);
%              dLdX(size(X,1)-layer.numOutputs + 1:size(X,1),:) = dLdZ;
%          end
        
        
        
    end
end
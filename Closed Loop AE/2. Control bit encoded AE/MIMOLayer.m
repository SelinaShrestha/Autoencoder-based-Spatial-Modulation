classdef MIMOLayer < nnet.layer.Layer %& nnet.layer.Formattable %(Optional) 
    
    properties
        c;
        pathGains;
    end
    
    methods
        function layer = MIMOLayer(c, name)
            % (Optional) Create a myLayer.
            % This function must have the same name as the class.

            % Layer constructor function goes here.
            rng(200);
            %layer.NumInputs = 2; % First input: tx signal, Second input: one hot encoded control symbols for antenna selection
            layer.c = c; % no of control bits
            layer.pathGains = complex(randn(1,1),randn(1,1))/sqrt(2); % Nr x Nt

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
            
            rng(200);
            M_c = 2^layer.c; % Number of tx antennas
            samples = size(X,2);
            Z = zeros(size(X),'like',X);
            
            txSig = complex(extractdata(X(1,:)),extractdata(X(2,:))); % Complex modulated signal from encoder (1 x samples)
            
            %pathGains = complex(randn(1,M_c),randn(1,M_c))/sqrt(2); % Nr x Nt
            rxSig = txSig.*layer.pathGains; % txSig(samples x Nt), pathGains (Nr x Nt)
            
            Re_rxSig = X(1,:)*real(layer.pathGains) - X(2,:)*imag(layer.pathGains); %Re_txSIg*Re_pathGains - Im_txSig*Im_pathGains
            Im_rxSig = X(1,:)*imag(layer.pathGains) + X(2,:)*real(layer.pathGains); %Re_txSIg*Im_pathGains + Im_txSig*Re_pathGains
            
            %rxSig = awgn(rxSig,10); %SNR = 10
            
            Z = [Re_rxSig; Im_rxSig];
            %Z = dlarray(awgn(extractdata(Z),10)); %SNR = 10
        end
        
%         function [Z,memory] = forward(layer,X)
%             % (Optional) Forward input data through the layer at training
%             % time and output the result, updated state, and a memory
%             % value.
%             %
%             % Inputs:
%             %         layer - Layer to forward propagate through 
%             %         X     - Layer input data
%             % Outputs:
%             %         Z      - Output of layer forward function 
%             %         state  - (Optional) Updated layer state 
%             %         memory - (Optional) Memory value for custom backward
%             %                  function
%             %
%             %  - For layers with multiple inputs, replace X with X1,...,XN, 
%             %    where N is the number of inputs.
%             %  - For layers with multiple outputs, replace Z with 
%             %    Z1,...,ZM, where M is the number of outputs.
%             %  - For layers with multiple state parameters, replace state 
%             %    with state1,...,stateK, where K is the number of state 
%             %    parameters.
% 
%             % Define layer forward function here.
%             rng(200);
%             M_c = 2^layer.c; % Number of tx antennas
%             samples = size(X,2);
%             Z = zeros(size(X),'like',X);
%             
%             txSig = complex(X(1,:),X(2,:)); % Complex modulated signal from encoder (1 x samples)
%             
%             %pathGains = complex(randn(1,M_c),randn(1,M_c))/sqrt(2); % Nr x Nt
%             rxSig = txSig.*layer.pathGains; % txSig(samples x Nt), pathGains (Nr x Nt)
%             rxSig = awgn(rxSig,10); %SNR = 10
%             
%             Z = [real(rxSig); imag(rxSig)];
%             memory = layer.pathGains;
%         end
        
%          function dLdX = backward(layer, X, Z, dLdZ,memory)
%              %dLdX1 = dLdZ;
%              %memory(isnan(memory)) = 0; % replace NaN with 0
%              %sum_pathGains = sum(memory); % sum along column
%              
%              dZ1dX1 = real(memory);
%              dZ2dX1  = imag(memory);
%              dZ1dX2 = -imag(memory);
%              dZ2dX2 = real(memory);
%              dLdX_1 = dZ1dX1.*dLdZ(1,:) + dZ2dX1.*dLdZ(2,:);
%              dLdX_2 = dZ1dX2.*dLdZ(1,:) + dZ2dX2.*dLdZ(2,:);
%              dLdX = [dLdX_1; dLdX_2];
%              
%              %dLdX2 = zeros(size(X2),'like',X2);
%              %dLdX2 = dLdZ;
%              %dLdX2 = cast(zeros(size(X2)) + 2.062604735157289e-12,'like', dLdZ);
%              %dLdX2 = sum(dLdZ);
%              
%          end
        
    end
end
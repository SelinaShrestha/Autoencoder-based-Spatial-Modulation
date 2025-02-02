classdef SMLayer < nnet.layer.Layer %& nnet.layer.Formattable %(Optional) 
    
    properties
        Nt;
        antennaMod;
    end
    
    methods
        function layer = SMLayer(Nt, name)
            % Layer constructor function goes here.
            layer.NumInputs = 2; % First input: tx signal, Second input: one hot encoded control symbols for antenna selection
            layer.Nt = Nt; % no of control symbols
            layer.antennaMod = [real(pskmod(0:layer.Nt-1,layer.Nt)); imag(pskmod(0:layer.Nt-1,layer.Nt))];
            % Set layer name.
            layer.Name = name;
        end
        
        function Z = predict(layer, X1, X2)
            txSig = X1; % real and imag parts of transmit symbols for data bits
            antennaSel = X2; % one hot vectors of antenna selection for control bits
            % One hot encoding to integer conversion of antenna selection
            %[argvalue, argmax] = max(antennaSel,[],1);
            %antennaNum = argmax;
            %antennaSig = [real(pskmod(antennaNum,layer.Nt)); imag(pskmod(antennaNum,layer.Nt))];
            antennaSign = 0.2 * layer.antennaMod * antennaSel; % Antenna Signature
            txSigMod = txSig + antennaSign;
            real_Z = txSigMod(1,:).*antennaSel;
            imag_Z  = txSigMod(2,:).*antennaSel;
            Z = [real_Z; imag_Z]; % send transmit symbol to selected antenna and send 0 to other antennas
        end

        
        
    end
end
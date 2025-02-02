classdef SMLayer < nnet.layer.Layer %& nnet.layer.Formattable %(Optional) 
    
    properties
        Nt;
    end
    
    methods
        function layer = SMLayer(Nt, name)
            % Layer constructor function goes here.
            layer.NumInputs = 2; % First input: tx signal, Second input: one hot encoded control symbols for antenna selection
            layer.Nt = Nt; % no of control symbols

            % Set layer name.
            layer.Name = name;
        end
        
        function Z = predict(layer, X1, X2)
            txSig = X1; % real and imag parts of transmit symbols for data bits
            antennaSel = X2; % one hot vectors of antenna selection for control bits
            real_Z = txSig(1,:).*antennaSel;
            imag_Z  = txSig(2,:).*antennaSel;
            Z = [real_Z; imag_Z]; % send transmit symbol to selected antenna and send 0 to other antennas
        end

        
        
    end
end
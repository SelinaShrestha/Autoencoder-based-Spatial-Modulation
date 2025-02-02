classdef Matlab_MIMOLayer < nnet.layer.Layer %& nnet.layer.Formattable %(Optional) 
    
    properties
        Nt;
        pathGains;
        mimochannel;
    end
    
    methods
        function layer = Matlab_MIMOLayer(Nt, name)
            % Layer constructor function goes here.
            %rng(200);
            layer.NumInputs = 2; % First input: tx signal, Second input: pathgains of rician channel
            layer.Nt = Nt; % no of control bits
            %layer.pathGains = complex(randn(1,1),randn(1,1))/sqrt(2) % Nr x Nt
            %layer.pathGains = 0.9677 - 0.3449i
            %layer.pathGains = -0.2009 + 0.6694i
            %layer.pathGains = zeros(1,Nt);
            %layer.pathGains = pathGains;
            %layer.pathGains = 0.1138 - 0.4350i;
            %layer.pathGains = 0.1483 - 0.1690i;
            
            % Set layer name.
            layer.Name = name;
        end
        
        function Z = predict(layer, X1, X2)            
            rng(200);
            samples = size(X1,2);
            Z = zeros(size(X1),'like',X1);
            %layer.pathGains = 0.9677 - 0.3449i;
            %Re_txSig = zeros(samples,M_c) + X(1,:).'; % Sending real part to both tx
            %Im_txSig = zeros(samples,M_c) + X(2,:).'; % Sending imag part to both tx
            
            Re_txSig = X1(1:layer.Nt,:).'; % First Nt rows of X1 are real parts of SM tx signal
            Im_txSig = X1(layer.Nt+1:2*layer.Nt,:).'; % Next Nt rows of X1 are imag parts of SM tx signal
            
            Re_pathGains = X2(1:layer.Nt,:).'; % First Nt rows of X2 are real parts of pathgains
            Im_pathGains = X2(layer.Nt+1:2*layer.Nt,:).'; % Next Nt rows of X2 are imag parts of pathgains
            
            %Re_rxSig = Re_txSig*real(layer.pathGains).' - Im_txSig*imag(layer.pathGains).'; % txSig(samples x Nt), pathGains (Nr x Nt)
            %Im_rxSig = Re_txSig*imag(layer.pathGains).' + Im_txSig*real(layer.pathGains).';
            
            Re_rxSig = sum(Re_txSig.*Re_pathGains - Im_txSig.*Im_pathGains,2); % txSig(samples x Nt), pathGains (Nr x Nt)
            Im_rxSig = sum(Re_txSig.*Im_pathGains + Im_txSig.*Re_pathGains,2);
            
            Re_rxSig = Re_rxSig.';
            Im_rxSig = Im_rxSig.';
            
            Z = [Re_rxSig; Im_rxSig];
        end
        
    end
end
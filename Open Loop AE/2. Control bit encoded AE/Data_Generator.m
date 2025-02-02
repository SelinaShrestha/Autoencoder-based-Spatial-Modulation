rng(352); % random number generator seed for training
% Derived parameters
k = 3;    % number of input bits
n = 2;    % number of channel uses
EbNo = 30; % Eb/No in dB
c = 1; % number of control bits that determine active antenna (no of antennas = 2^c)
M = 2^k;
d = k-c; % number of data bits
M_d = 2^d; % number of possible data symbols transmitted through active antenna
M_c = 2^c; % number of possible antenna id
Nt = M_c;

KFactor = 10;                  % In dB
KFactorLin = 10.^(KFactor/10); % Linear units

frame_length_train = 1;
numTrainSymbols = frame_length_train * 80000; % 80 frames % 2500 * M

frame_length_test = 1000;
numValidationSymbols = frame_length_test * 10;
numTestSymbols = frame_length_test * 10; 

%Data generation
data = randi([0 M-1],numTrainSymbols+numValidationSymbols+numTestSymbols,1);

pathGains = zeros([numTrainSymbols+numValidationSymbols+numTestSymbols, Nt]); % samples x Nt

for i=1:numTrainSymbols
    mimochannel = comm.MIMOChannel('SampleRate',1, ...
        'PathDelays',[0],'AveragePathGains',[0], ...
        'MaximumDopplerShift',0,'SpatialCorrelationSpecification','None', ...
        'FadingDistribution','Rician','KFactor', KFactorLin, ...
        'NumTransmitAntennas',Nt,'NumReceiveAntennas',1,...
        'PathGainsOutputPort',true);
    [dummy, pG] = mimochannel(zeros(1,Nt));
    pathGains(i,:) = reshape(pG, [1,Nt]);
end
    
for i=1:ceil((numValidationSymbols+numTestSymbols)/frame_length_test)
    mimochannel = comm.MIMOChannel('SampleRate',1, ...
        'PathDelays',[0],'AveragePathGains',[0], ...
        'MaximumDopplerShift',0,'SpatialCorrelationSpecification','None', ...
        'FadingDistribution','Rician','KFactor', KFactorLin, ...
        'NumTransmitAntennas',Nt,'NumReceiveAntennas',1,...
        'PathGainsOutputPort',true);
    [dummy, pG] = mimochannel(zeros(frame_length_test,Nt));
    pathGains(numTrainSymbols + (i-1)*frame_length_test + 1: numTrainSymbols + i*frame_length_test,:) = reshape(pG, [frame_length_test,Nt]);
end
train_data = [data(1:numTrainSymbols,:) pathGains(1:numTrainSymbols,:)];
validation_data = [data(numTrainSymbols+1:numTrainSymbols+numValidationSymbols,:) pathGains(numTrainSymbols+1:numTrainSymbols+numValidationSymbols,:)];
test_data = [data(numTrainSymbols+numValidationSymbols+1:numTrainSymbols+numValidationSymbols+numTestSymbols,:) pathGains(numTrainSymbols+numValidationSymbols+1:numTrainSymbols+numValidationSymbols+numTestSymbols,:)];

writematrix(train_data,'Datasets\c1d2_rician10\train_data.csv');
writematrix(validation_data,'Datasets\c1d2_rician10\validation_data.csv');
writematrix(test_data,'Datasets\c1d2_rician10\test_data.csv');



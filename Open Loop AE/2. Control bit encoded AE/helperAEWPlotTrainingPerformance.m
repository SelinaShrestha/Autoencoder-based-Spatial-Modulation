function helperAEWPlotTrainingPerformance(info)
%helperAEWTrainPlotTrainingPerformance Plot training performance
%   helperAEWTrainPlotTrainingPerformance(I) plots validation accuracy and
%   validation loss as a function of training iterations for the training
%   information structure, I.
%
%   See also AutoencoderForWirelessCommunicationsExample, helperAEWEncode,
%   helperAEWDecode, helperAEWNormalizationLayer, helperAEWAWGNLayer.

%   Copyright 2020 The MathWorks, Inc.

validLoss = info.ValidationLoss;
idx = find(~isnan(validLoss));
yyaxis left
semilogy(idx, validLoss(idx), 'o-','tag','aew_valid_loss')
ylabel('Validation Loss')
validAcc = info.ValidationAccuracy;
idx = find(~isnan(validAcc));
yyaxis right
semilogy(idx, validAcc(idx), '*-','tag','aew_valid_acc')
ylabel('Validation Accuracy')
grid on
xlabel('Iteration')
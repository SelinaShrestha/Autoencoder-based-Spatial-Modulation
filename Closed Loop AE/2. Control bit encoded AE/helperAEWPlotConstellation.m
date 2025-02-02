function helperAEWPlotConstellation(trainedNet,encoder_layer,varargin)
%helperAEWPlotConstellation Plot autoencoder constellation
%   helperAEWPlotConstellation(NET) plots the autoencoder constellation
%   interpreting the encoder output as an interleaved complex number
%   sequence. For all M possible input symbols, get the output of the
%   normalization layer. Map the real samples to complex samples by using
%   odd samples as real part (in-phase) and even samples as imaginary part
%   (quadrature).
%
%   helperAEWPlotConstellation(NET,VIS) plots the autoencoder constellation
%   using VIS visualization method. VIS must be one of 'interleaved' or
%   't-sne'. The default is 'interleaved'. If VIS is 't-sne', this function
%   interprets the encoder output as an n-D vector and computes the 2-D
%   constellation points using the t-SNE non-linear dimensionality
%   reduction algorithm used for exploring high-dimensional data. 
%
%   See also AutoencoderForWirelessCommunicationsExample, helperAEWEncode,
%   helperAEWDecode, helperAEWAWGNLayer, tsne.

%   Copyright 2020 The MathWorks, Inc.

if nargin > 2
  method = varargin{1};
else
  method = 'interleaved';
end
if nargin > 2
  showLegend = varargin{2};
else
  showLegend = false;
end
if nargin > 3
  ax = varargin{3};
else
  ax = gca;
end

M = trainedNet.Layers(1).InputSize;
M_d = trainedNet.Layers(2).numOutputs; % Data Layer
Nt = trainedNet.Layers(3).numOutputs; % Control Layer

k = log2(M);
n = trainedNet.Layers(4).OutputSize;

%inputSymbols = eye(M);
inputSymbols = [repelem(eye(Nt),M_d,1) repmat(eye(M_d),Nt,1)];

if strcmp(method, 'interleaved')
  y = activations(trainedNet, inputSymbols, encoder_layer);
  y2D = reshape(y,2,[]);
  plot(ax,y2D(1,:) + 1i* y2D(2,:),'*','Tag','aew_constellation')
  grid(ax,"on")
  axis(ax,"equal")
  axis(ax,"square")
  axis([-2 2 -2 2])
  xlabel(ax,'In phase')
  ylabel(ax,'Quadrature')
  %title(sprintf('(%d,%d) Channel Uses',n,k))
else
  if ~license('test','statistics_toolbox') || ~exist('tsne','file')
    warning('commdemos:autoencoder:statsNeeded', ...
      ['t-SNE option requires Statistics and Machine Learning '...
      'Toolbox. Skipping.'])
    text(0.4,0.5,'Skipped')
    return
  end
  % Set useNoisySamples to true to generate noise samples for the t-SNE
  % algorithm. Noisy samples gives the algorithm a larger search space and
  % come up with various 2-D representation. This flexibility also makes it
  % prone to converging to a not so desirable solution. Set useNoisySamples
  % to false to provide the t-SNE algorithm with M perfect symbols. This
  % input makes the algorithm to converge to the same perfect constellation
  % every time. 
  useNoisySamples = false;
  if useNoisySamples
    rep = 50; %#ok<UNRCH>
    inputSymbols = repmat(eye(M),rep,1);
    y = activations(trainedNet, inputSymbols, encoder_layer);
    y = awgn(y,10);
    y2D = tsne(y','Algorithm','exact','Standardize',true,'Exaggeration',M,'Perplexity',M);
  else
    rep = 1;
    inputSymbols = repmat(eye(M),rep,1);
    y = activations(trainedNet, inputSymbols, encoder_layer);
    yInit = repmat(qammod((0:M-1)',M,'UnitAveragePower',true),rep,1);
    yInit = [real(yInit) imag(yInit)];
    warnState = warning('off','stats:tsne:BinarySearchNotConverge');
    restoreWarnState = onCleanup(@()warning(warnState));
    y2D = tsne(y','Algorithm','exact','Standardize',true,'Exaggeration',M,'Perplexity',M,'InitialY',yInit);
  end
  y2D = y2D - mean(y2D);
  y2D = y2D / sqrt(mean(y2D.^2, 'all'));
  colors = turbo(M);
  h = gscatter(ax,y2D(:,1),y2D(:,2),repmat(categorical(0:M-1),1,rep),colors,[],[],showLegend);
  [h.Tag] = deal('aew_constellation');
  axis(ax,"equal")
  axis(ax,"square")
  grid on
  if strcmp(showLegend,'on')
    l = legend;
    l.Interpreter = "none";
    l.Location = "bestoutside";
  end
  xlabel(ax,'In phase')
  ylabel(ax,'Quadrature')
  title(sprintf('2D Mapped (%d,%d) AE Constellation',n,k))
end




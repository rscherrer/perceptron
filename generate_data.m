% Function to generate a dataset
function [dataset, labels] = generate_data(nPoints, nDimensions)

% Generate a dataset with nDimensions columns and nPoints rows
% The data are sampled from a normal distribution and the samples are
% independent
dataset = randn(nPoints, nDimensions);

% Generate random labels for each data point
labels = binornd(1, 0.5, [1 nPoints]);
labels(labels == 0) = -1;

end
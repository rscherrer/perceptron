% Rosenblatt's perceptron

% Parameters
nEpochs = 50; % number of training cycles
tiny = 0.001; % minimal threshold for successful assignment of a point
nReplicates = 100; % number of replicates to calculate proportion from
alphas = 0.25:0.25:4.0; % range of number of points / dimensionality ratios
[~, nAlphas] = size(alphas);

% Different dimensionalities
Ns = [5 20 100];
[~, nDimensionalities] = size(Ns);

% Initialize a matrix to store probabilities
successMatrix = zeros(nAlphas, nDimensionalities);

% Loop through dimensionalities
for j = 1:nDimensionalities
    
    nDimensions = Ns(j);
    
    % Different sets of dimensions and numbers of points
    Ps = round(alphas * nDimensions);
    
    % Prepare to store the rates of success for each set along the alpha axis
    successRates = repelem(0, nAlphas);
    
    % Loop through each number of points
    for i = 1:nAlphas
    
        nPoints = Ps(i);
    
        % Assess perceptrons on simulated datasets
        successRates(i) = assess_perceptron(nPoints, nDimensions, nEpochs, tiny, nReplicates);
    
    end
    
    % Update the success matrix
    successMatrix(:,j) = successRates;
    
end

% Plot the resulting success curves
plot(alphas, successMatrix)
title('Perceptron performance')
xlabel('\alpha (= P/N)')
ylabel('Probability of success')
legend('N = 5', 'N = 20', 'N = 100')

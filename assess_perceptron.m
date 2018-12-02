% Function to calculate the probability of successful separation of a
% dataset by a perceptron
% Simulates several datasets and run a perceptron on each one of them
function probSuccess = assess_perceptron(nPoints, nDimensions, nEpochs, tiny, nReplicates)

% Number of successful separation of the data
nSuccess = 0;

% Repeat for each replicate
for i = 1:nReplicates
    
    % Generate random data
    [dataset, labels] = generate_data(nPoints, nDimensions);

    % Run the perceptron
    [isSuccess, ~, ~] = run_perceptron(dataset, labels, nEpochs, tiny);
    
    nSuccess = nSuccess + isSuccess;
    
end

% Return the probability of success
probSuccess = nSuccess / nReplicates;

end
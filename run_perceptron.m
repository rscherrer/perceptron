% Function to run the perceptron algorithm until full separation
% Returns a 1 if separation was successful, 0 if it could not separated
% within a reasonable amount of time (given by nEpochs)
% tiny is the potential value under which a point is not correctly assigned
function [isSuccess, nIterations, normalVector] = run_perceptron(dataset, labels, nEpochs, tiny)

% What are the dimensions of the dataset?
[nPoints, nDimensions] = size(dataset);

% Initialize the vector w, the vector that is normal to the hyperplane
normalVector = repelem(0, nDimensions);

% Initialize the vector of embedding strengths
embeddingStrengths = repelem(0, nPoints);

% To check when the algorithm has succesfully separated the dataset
isSuccess = 0;

% Counter for iterations
nIterations = 0;

% Go through all epochs up to a certain point
for epoch = 1:nEpochs
    
    % Go through points iteratively
    for i = 1:nPoints
        
        % Calculate the potential of the current point
        potential = dot(dataset(i,:), normalVector) * labels(i);
        
        % If the potential is too small...
        if potential <= tiny
            
            % Increment the embedding strength of the current point
            embeddingStrengths(i) = embeddingStrengths(i) + 1;
            
        end
        
        % Update the normal vector based on the current point
        normalVector = normalVector + dataset(i,:) * labels(i) * embeddingStrengths(i) / nPoints;
        
        %disp(embeddingStrengths);
        
        % Now check if all points are correctly separated
        isSuccess = is_separated(dataset, labels, normalVector, tiny);
        
        % Increment number of iterations
        nIterations = nIterations + 1;
        
        % If yes, break the loop
        if isSuccess
            break
        end
        
    end
    
    % Break if success
    if isSuccess
        break
    end
    
end

% isSuccess is returned

end

% Accessory function to check if the data are separated
function isSuccess = is_separated(dataset, labels, normalVector, tiny)
    
    % Count the number of points
    [nPoints, ~] = size(dataset);

    % Initialize success as true, will become false if at least one
    % potential is too small
    isSuccess = 1;
    
    % Loop through all points and calculate their potential
    for i = 1:nPoints
        
        % Calculate the potential of the point
        potential = dot(dataset(i,:), normalVector) * labels(i);
        
        % If the potential is too small, break the loop and return false
        % The separation is not a success
        if potential < tiny
            
            isSuccess = 0;
            break
            
        end
        
    end
    
    % Returns 1 if the loop went through all the points without
    % encountering a too small potential, and 0 if the loop broke

end
function nn = nnsetup(architecture)
%NNSETUP creates a Feedforward Backpropagate Neural Network
% nn = nnsetup(size) returns an neural network structure with n=numel(size)
% layers, size being a n x 1 vector of layer sizes e.g. [784 100 10]

    nn.size   = architecture;
    nn.n      = numel(nn.size);
    
<<<<<<< HEAD
    nn.learningRate                     = 1;    %  learning rate 
    nn.scaling_learningRate             = 1;      %  Scaling factor for the learning rate (each epoch)
=======
    nn.learningRate                     = 0.1;    %  learning rate 
>>>>>>> d85b1462bead21ab809497f476b5ae66f547d45f
    nn.momentum                         = 0.5;    %  Momentum
    nn.weightPenaltyL2                  = 0;      %  L2 regularization
    nn.nonSparsityPenalty               = 0;      %  Non sparsity penalty
    nn.sparsityTarget                   = 0.05;   %  Sparsity target
    nn.inputZeroMaskedFraction          = 0;      %  Used for Denoising AutoEncoders
    nn.dropoutFraction                  = 0;      %  Dropout level (http://www.cs.toronto.edu/~hinton/absps/dropout.pdf)
    nn.testing                          = 0;      %  Internal variable. nntest sets this to one.
    nn.output                           = 'softmax'; %  output unit 'sigm' (=logistic), 'softmax' and 'linear'

    for i = 2 : nn.n
<<<<<<< HEAD
=======
        % biases and bias momentum
        nn.b{i - 1} = zeros(nn.size(i), 1);
        nn.vb{i - 1} = zeros(size(nn.b{i - 1}));
        
>>>>>>> d85b1462bead21ab809497f476b5ae66f547d45f
        % weights and weight momentum
        nn.W{i - 1} = (rand(nn.size(i), nn.size(i - 1)) - 0.5) * 2 * 4 * sqrt(6 / (nn.size(i) + nn.size(i - 1)));
        nn.vW{i - 1} = zeros(size(nn.W{i - 1}));
        
        % average activations (for use with sparsity)
        nn.p{i}     = zeros(1, nn.size(i));   
    end
end

function net = cnnbp(net, y)
    n = numel(net.layers);

    %  error
    net.e = net.o - y;
    if 1 %(cnn.output_error,'softmax');
        net.L = -sum(sum(y .* log(net.o))) / size(y,2);
    else
        %  loss function
        net.L = 1/2* sum(net.e(:) .^ 2) / size(net.e, 2);
    end

    %%  backprop deltas
    net.od = net.e .* (net.o .* (1 - net.o));   %  output delta
    net.fvd = (net.ffW' * net.od);              %  feature vector delta
    if strcmp(net.layers{n}.type, 'c')         %  only conv layers has sigm function
        net.fvd = net.fvd .* (net.fv .* (1 - net.fv));
    end

    
    %% See the notes from http://deeplearning.stanford.edu/wiki/index.php/Exercise:Convolution_and_Pooling
    % about why we need to flip it first (mainly becaue of matlab built in
    % function)
    %reshape feature vector deltas into output map style
    sa = size(net.layers{n}.a{1});
    fvnum = sa(1) * sa(2);
    for j = 1 : numel(net.layers{n}.a)
        net.layers{n}.d{j} = reshape(net.fvd(((j - 1) * fvnum + 1) : j * fvnum, :), sa(1), sa(2), sa(3));
    end

    for l = (n - 1) : -1 : 1
        if  strcmp(net.layers{l}.type, 'c') 
<<<<<<< HEAD
=======
            if l==(n-1) % l==(n-1) condition means the last two layers are sigm fully connnected
                 for j = 1 : numel(net.layers{l}.a)
                    net.layers{l}.d{j} = net.layers{l}.a{j} .* (1 - net.layers{l}.a{j}) .* ...
                        (net.layers{l + 1}.d{j});
                end
            else
>>>>>>> d85b1462bead21ab809497f476b5ae66f547d45f
                for j = 1 : numel(net.layers{l}.a)
                    net.layers{l}.d{j} = net.layers{l}.a{j} .* (1 - net.layers{l}.a{j}) .* ...
                        (expand(net.layers{l + 1}.d{j},[net.layers{l + 1}.scale net.layers{l + 1}.scale 1]) / net.layers{l + 1}.scale ^ 2);
                end
<<<<<<< HEAD
=======
            end
>>>>>>> d85b1462bead21ab809497f476b5ae66f547d45f
        elseif strcmp(net.layers{l}.type, 't')
            for j = 1 : numel(net.layers{l}.a)
                 net.layers{l}.d{j} = (1 - tanh(net.layers{l}.a{j}).^2) .* ...
                    (expand(net.layers{l + 1}.d{j},[net.layers{l + 1}.scale net.layers{l + 1}.scale 1]) / net.layers{l + 1}.scale ^ 2);
            end
            
        elseif strcmp(net.layers{l}.type, 's')
            for i = 1 : numel(net.layers{l}.a)
                z = zeros(size(net.layers{l}.a{1}));
                for j = 1 : numel(net.layers{l + 1}.a)
                     z = z + convn(net.layers{l + 1}.d{j}, rot180(net.layers{l + 1}.k{i}{j}), 'full');
                end
                net.layers{l}.d{i} = z;
            end
        elseif strcmp(net.layers{l}.type, 'm')
            for i = 1 : numel(net.layers{l}.a)
                z = zeros(size(net.layers{l}.a{1}));
                for j = 1 : numel(net.layers{l + 1}.a)
                     z = z + convn(net.layers{l + 1}.d{j}, rot180(net.layers{l + 1}.k{i}{j}), 'full');
                end
                net.layers{l}.d{i} = z;
            end
            
        end
    end

    %%  calc gradients
    for l = 2 : n
        if strcmp(net.layers{l}.type, 'c')
            for j = 1 : numel(net.layers{l}.a)
                for i = 1 : numel(net.layers{l - 1}.a)
                    net.layers{l}.dk{i}{j} = convn(flipall(net.layers{l - 1}.a{i}), net.layers{l}.d{j}, 'valid') / size(net.layers{l}.d{j}, 3);
                end
                net.layers{l}.db{j} = sum(net.layers{l}.d{j}(:)) / size(net.layers{l}.d{j}, 3);
            end
        end
         if strcmp(net.layers{l}.type, 't')
            for j = 1 : numel(net.layers{l}.a)
                for i = 1 : numel(net.layers{l - 1}.a)
                    net.layers{l}.dk{i}{j} = convn(flipall(net.layers{l - 1}.a{i}), net.layers{l}.d{j}, 'valid') / size(net.layers{l}.d{j}, 3);
                end
                net.layers{l}.db{j} = sum(net.layers{l}.d{j}(:)) / size(net.layers{l}.d{j}, 3);
            end
        end
    end
    net.dffW = net.od * (net.fv)' / size(net.od, 2);
    net.dffb = mean(net.od, 2);

    function X = rot180(X)
        X = flipdim(flipdim(X, 1), 2);
    end
end

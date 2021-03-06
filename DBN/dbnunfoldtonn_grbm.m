function nn = dbnunfoldtonn_grbm(dbn, outputsize,grbm);
%DBNUNFOLDTONN Unfolds a DBN to a NN
%   dbnunfoldtonn(dbn, outputsize ) returns the unfolded dbn with a final
%   layer of size outputsize added.
    if(exist('outputsize','var'))
        size = [length(grbm.fvar)  dbn.sizes outputsize];
    else
        size = [dbn.sizes];
    end
<<<<<<< HEAD
    nn = nnsetup_grbm(size);
=======
    nn = nnsetup(size);
>>>>>>> d85b1462bead21ab809497f476b5ae66f547d45f
    
    for i=1
        nn.W{i} = grbm.vhW';
        nn.b{i} = grbm.hb';
        
    end
    
    for i = 1 : numel(dbn.rbm)
        nn.W{i+1} = dbn.rbm{i}.W;
        nn.b{i+1} = dbn.rbm{i}.c;
    end
end


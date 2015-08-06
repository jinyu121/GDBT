function [ out ] = Tree_apply( intree,X )

% Extract input
X_ndarray=X;
X_sample_stride=1;
X_fx_stride=length(X);
n_samples=Util_shape(X,0);

% Initialize output
out=zeros(1,n_samples);

% Initialize auxiliary data-structure
node=[];
i=0;

% for i=1:1:n_samples
%     for i in range(n_samples):
%                 node = self.nodes
%                 # While node not a leaf
%                 while node.left_child != _TREE_LEAF:
%                     # ... and node.right_child != _TREE_LEAF:
%                     if X_ptr[X_sample_stride * i +
%                              X_fx_stride * node.feature] <= node.threshold:
%                         node = &self.nodes[node.left_child]
%                     else:
%                         node = &self.nodes[node.right_child]
% 
%                 out_ptr[i] = <SIZE_t>(node - self.nodes)  # node offset
end

end


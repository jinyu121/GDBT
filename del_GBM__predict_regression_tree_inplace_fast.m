function [ ret ] = GBM__predict_regression_tree_inplace_fast( X,root_node,value,scale,k,K,n_samples,n_features,out )
ret=out;
for i =1:1:n_samples
    node=root_node;
    while(node.left_child~=1)&&(node.right_child~=1)
        if X(i * n_features + node.feature)<=node.threshold
            node = root_node + node.left_child;
        else
            node = root_node + node.right_child;
        end
    end
    ret(i * K + k) =out(i * K + k)+ scale * value(node - root_node);
end

end

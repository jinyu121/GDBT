function [ root_node,value ] = GBM__partial_dependence_tree( tree,X,target_feature,learn_rate,out )
n_features = Util_shape(X,1);
% 会被更改
root_node = tree.nodes;
% 会被更改
value = tree.value;
node_count = tree.node_count;
stack_capacity = node_count * 2;
weight_stack = ones(1,stack_capacity);
stack_size = 1;
total_weight = 0.0;
% 会被更改
% current_node

underlying_stack = zeros(1,stack_capacity)
node_stack = underlying_stack.data;

for i=1:1:Util_shape(X,0)
    stack_size = 1;
    node_stack(0( = root_node;
    weight_stack(0) = 1.0;
    total_weight = 0.0;
    while stack_size > 0
        stack_size = stack_size-1;
        current_node = node_stack(stack_size);
        if current_node.left_child == -1
            out(i) = out(i)+weight_stack(stack_size) * value(current_node - root_node) .*learn_rate;
            total_weight =total_weight+ weight_stack(stack_size);
        else
            feature_index = GBM_array_index(current_node.feature, target_feature);
            if feature_index ~= -1
                if X(i, feature_index) <= current_node.threshold
                    node_stack(stack_size) = (root_node +current_node.left_child);
                else
                    node_stack(stack_size) = (root_node +current_node.right_child);
                end
                stack_size =stack_size+ 1;
                
                
            else
                node_stack(stack_size) = root_node + current_node.left_child;
                current_weight = weight_stack(stack_size);
                left_sample_frac = root_node(current_node.left_child).n_node_samples ./ current_node.n_node_samples;
                if (left_sample_frac <= 0.0) || (left_sample_frac >= 1.0)
                    error('Some error occurs...');
                end
                weight_stack(stack_size) = current_weight .* left_sample_frac;
                stack_size =stack_size+1;
                
                node_stack(stack_size) = root_node + current_node.right_child;
                weight_stack(stack_size) = current_weight .*(1.0 - left_sample_frac);
                stack_size =stack_size+1;
            end
        end
    end
end
if abs(total_weight-1)>0.001
    error('Total weight should be 1.0 but was not');
end
end


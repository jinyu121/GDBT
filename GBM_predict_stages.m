function [ ret ] = GBM_predict_stages( estimators,X,scale,out )
n_estimators=Util_shape(estimators,0);
K=Util_shape(estimators,1);
for i=1:1:n_estimators
    tree=estimators(i,K).tree_;
    ret=GBM__predict_regression_tree_inplace_fast(X,tree.nodex,tree.value,scale,k,K,Util_shape(X,0),Util_shape(X,1),out.data);
end
end


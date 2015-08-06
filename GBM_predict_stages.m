function [ score ] = GBM_predict_stages( ingbm, estimators,X,scale,inscore )
self=ingbm;
score=inscore;
n_estimators=Util_shape(estimators,0);
K=Util_shape(estimators,1);
for i=1:1:n_estimators
    for k=1:1:K
    	tree=estimators{i,K};
        score(:,k) = score(:,k)+(scale.*predict(tree,X));
%     ret=GBM__predict_regression_tree_inplace_fast(X,tree.nodex,tree.value,scale,k,K,Util_shape(X,0),Util_shape(X,1),out.data); 
    end
end
end

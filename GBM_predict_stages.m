function [ score ] = GBM_predict_stages( ingbm, estimators,X,scale,inscore )
self=ingbm;
score=inscore;
n_estimators=Util_shape(estimators,0);
K=Util_shape(estimators,1);
for i=1:1:n_estimators
    for k=1:1:K
    	tree=estimators{i,k};
        score(:,k) = score(:,k)+(scale*predict(tree,X));
        % out += scale * tree.predict(X).reshape((X.shape[0], 1))
    end
end
end

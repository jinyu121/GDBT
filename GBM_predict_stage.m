function [ ret ] = GBM_predict_stage( estimators,stage,X,scale,out )
ret=predict_stages(estimators(stage:stage + 1), X, scale,out);

end


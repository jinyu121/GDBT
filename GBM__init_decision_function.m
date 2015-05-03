function [ score ] = GBM_init_decision_function( inself,X )
self=inself;

%% """Check input and compute prediction of ``init``. """
if isempty(self.estimators_) 
    error('Estimator not fitted, call `fit` before making predictions`.')
end

% size(X)(2) or length(x)?
Xshape=size(X);
if Xshape(2) ~= self.n_features
    error('Shape not match');
end
score = EstimatorPredict(self.init_,X);

end


function self = GBM_resize_state( inself )
self=inself;
% % Add additional ``n_estimators`` entries to all attributes.
% # self.n_estimators is the number of additional est to fit
total_n_estimators = self.n_estimators
if total_n_estimators < Util_shape0(self.estimators_)
    error('resize with smaller n_estimators');
end

reshape(self.estimators_',total_n_estimators, self.loss_.K);
reshape(self.train_score_',[],total_n_estimators);

if (self.subsample < 1 ) || (~isempty(self.oob_improvement_))
    reshape( self.oob_improvement_',[],total_n_estimators);
else
    self.oob_improvement_ = zeros(1,total_n_estimators);
end
end

function self = GBM__resize_state( ingbm )
self=ingbm;
% % Add additional ``n_estimators`` entries to all attributes.
% # self.n_estimators is the number of additional est to fit
total_n_estimators = self.n_estimators;
if total_n_estimators < Util_shape(self.estimators_,0)
    error('resize with smaller n_estimators');
end

self.estimators_=reshape(self.estimators_', self.loss_.K,total_n_estimators)';
self.train_score_=reshape(self.train_score_',[],total_n_estimators);

if (self.subsample < 1 ) || (~isempty(self.oob_improvement_))
    reshape( self.oob_improvement_',[],total_n_estimators);
else
    self.oob_improvement_ = zeros(1,total_n_estimators);
end
end

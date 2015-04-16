function self = GBM_resize_state( inself )
self=inself;
% % Add additional ``n_estimators`` entries to all attributes.
% # self.n_estimators is the number of additional est to fit
total_n_estimators = self.n_estimators

% I think it is useless, so i deleted it!!!
% self.estimators_.resize((total_n_estimators, self.loss_.K))
% self.train_score_.resize(total_n_estimators)

if self.subsample < 1
    self.oob_improvement_ = np.zeros((total_n_estimators,))
elseif self.oob_improvement_~=[]
    %     # if do oob resize arrays or create new if not available
    self.oob_improvement_=OOB_resize(self.oob_improvement_,total_n_estimators)
end
end

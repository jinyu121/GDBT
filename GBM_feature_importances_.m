function [ importances ] = GBM_feature_importances_( ingbm )

if isempty(self.estimators_)
    error('Estimator not fitted, call fit before feature_importances_ .');
end

total_sum=zeros(1,self.n_features);
for stage=1:1:length(self.estimators_)
%     stage2=self.estimators_(stage);
%     stage_sum=0;
%     stage_sum = sum(tree.feature_importances_ for tree in stage) ./ length(stage2);
%     total_sum = total_sum+stage_sum;
end
importances = total_sum / length(self.estimators_);

end

function [self,outParameter] = GBM__fit_stages( ingbm, X, y, y_pred, sample_weight, begin_at_stage )
self=ingbm;
n_samples = Util_shape(X,0);
do_oob = self.subsample < 1.0 ;
sample_mask=ones(1,n_samples);
n_inbag = max(1, floor(self.subsample * n_samples));
loss_ = self.loss_;

if (self.min_weight_fraction_leaf ~= 0) && ~(isempty(sample_weight))
    min_weight_leaf=self.min_weight_fraction_leaf .*sum(sample_weight);
else
    min_weight_leaf=0;
end

% init criterion and splitter
% Todo: How to translate them?
%
%         criterion = FriedmanMSE(1)
%         splitter = PresortBestSplitter(criterion,
%                                        self.max_features_,
%                                        self.min_samples_leaf,
%                                        self.min_weight_fraction_leaf,
%                                        random_state)

%%%%% THIS IS FAKE!!!
criterion=nan;
splitter=nan;
%%%%% THIS IS FAKE!!!

if self.verbose
     verbose_reporter = VerboseReporter(self.verbose);
     verbose_reporter = VerboseReporter_init(verbose_reporter,self, begin_at_stage);
end

% perform boosting iterations
for i=begin_at_stage+1:1:self.n_estimators
    %     subsampling
    if do_oob
        sample_mask = Util__random_sample_mask(n_samples, n_inbag);
        %         OOB score before adding this stage
        old_oob_score = LossFunction__call__(loss_,y(~sample_mask),y_pred(~sample_mask),sample_weight(~sample_mask));
    end
    
    %     fit next stage of trees
    [self,y_pred] = GBM__fit_stage(self, i, X, y, y_pred, sample_weight,sample_mask, criterion, splitter);
    
    %     track deviance (= loss)
    if do_oob
        self.train_score_(i) = LossFunction__call__(loss_,y(sample_mask),y_pred(sample_mask),sample_weight(sample_mask));
        self.oob_improvement_(i) = (old_oob_score -LossFunction_call(loss_,y(~sample_mask), y_pred(~sample_mask),sample_weight(~sample_mask)));
    else
        %         no need to fancy index w/ no subsampling
        self.train_score_(i) = LossFunction__call__(loss_,y, y_pred, sample_weight);
      end
%     if self.verbose > 0
%         [verbose_reporter,self]=VerboseReporter_update(verbose_reporter,i, self);
%     end
end
outParameter=i+1;
end

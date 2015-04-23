function [self,outParameter] = GBM_fit_stages( inself, X, y, y_pred, sample_weight, random_state,begin_at_stage )
self=inself;
% Iteratively fits the stages.
%         For each stage it computes the progress (OOB, train score)
%         and delegates to ``_fit_stage``.
%         Returns the number of stages fit; might differ from ``n_estimators``
%         due to early stopping.
%    == Do not care about the last sentence! I remove it
n_samples = length(X);
sample_mask=ones(1,n_samples);
do_oob = self.subsample < 1.0 ;
n_inbag = max(1, int(self.subsample * n_samples));
loss_ = self.loss_

% init criterion and splitter
% Todo: How to translate them?
%
%         criterion = FriedmanMSE(1)
%         splitter = PresortBestSplitter(criterion,
%                                        self.max_features_,
%                                        self.min_samples_leaf,
%                                        self.min_weight_fraction_leaf,
%                                        random_state)

% I think the whole Verbose is useless, So i deleted it!!!
% if self.verbose
%     verbose_reporter = VerboseReporter(self.verbose);
%     verbose_reporter = VerboseReporter_init(self, begin_at_stage);
% end

% perform boosting iterations
for i=begin_at_stage:1:self.n_estimators-1
    %     subsampling
    if do_oob
        sample_mask = GBM_random_sample_mask(n_samples, n_inbag, random_state);
        %         OOB score before adding this stage
        old_oob_score = loss_(y(~sample_mask),y_pred(~sample_mask),sample_weight(~sample_mask));
    end
    %     fit next stage of trees
    y_pred = GBM_fit_stage(i, X, y, y_pred, sample_weight,sample_mask, criterion, splitter,random_state);
    %     track deviance (= loss)
    if do_oob
        self.train_score_(i) = loss_(y(sample_mask),y_pred(sample_mask),sample_weight(sample_mask));
        self.oob_improvement_(i) = (old_oob_score -loss_(y(~sample_mask), y_pred(~sample_mask),sample_weight(~sample_mask)));
    else
        %         no need to fancy index w/ no subsampling
        self.train_score_(i) = loss_(y, y_pred, sample_weight)
    end
    if self.verbose > 0
        [verbose_reporter,self]=VerboseReporter_update(verbose_reporter,i, self)
    end
end
outParameter=self.n_estimators
end


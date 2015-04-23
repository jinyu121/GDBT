function self = LossFunction( inname, inalpha,n_classes_ )
% Attributes
%     ----------
%     K : int
%         The number of regression trees to be induced;
%         1 for regression and binary classification;
%         ``n_classes`` for multi-class classification.
%     """
self.name=inname;
self.alpha=inalpha;
self.K=n_classes_;
self.is_multi_class = False;
end


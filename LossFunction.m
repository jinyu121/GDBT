function self = LossFunction( inname,n_classes_ , inalpha )
% Attributes
%     ----------
%     K : int
%         The number of regression trees to be induced;
%         1 for regression and binary classification;
%         ``n_classes`` for multi-class classification.
%     """
self.name=inname;
self.alpha=inalpha;
self.K=n_classes;
self.is_multi_class = False;
end


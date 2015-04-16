function ans=Estimator_Quantitle_weighted_percentile(array, sample_weight, percentile)
% The default value of percentile is 50

% Compute the weighted ``percentile`` of ``array`` with ``sample_weight``.
sorted_idx = sortrows(array)

% Find index of median prediction for each sample
weight_cdf = cumsum(sample_weight(sorted_idx))
% percentile_idx = np.searchsorted(
%         weight_cdf, (percentile / 100.) * weight_cdf[-1])
%     return array[sorted_idx[percentile_idx]]
% Todo:
% http://docs.scipy.org/doc/numpy/reference/generated/numpy.searchsorted.html
% I don't know how to translate this 


end
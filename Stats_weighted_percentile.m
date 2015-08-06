function returnParam=Estimator_Quantitle_weighted_percentile(inself,array, sample_weight, percentile)
% The default value of percentile is 50

% Compute the weighted ``percentile`` of ``array`` with ``sample_weight``.
sorted_idx = sortrows(array)

% Find index of median prediction for each sample
weight_cdf = cumsum(sample_weight(sorted_idx))
% percentile_idx = np.searchsorted(
%         weight_cdf, (percentile / 100.) * weight_cdf[-1])
% Todo:
% http://docs.scipy.org/doc/numpy/reference/generated/numpy.searchsorted.html
% I don't know how to translate this

% I find this: http://www.codeitive.com/0NNgjXgUVg/equivalent-of-matlab-ismember-in-numpy-python.html
% So is it right?
[tf, percentile_idx] = ismember((percentile / 100.) * weight_cdf(length(weight_cdf)), weight_cdf);
returnParam=sorted_idx(percentile_idx)


end

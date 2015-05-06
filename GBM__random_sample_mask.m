function [ sample_mask ] = GBM__random_sample_mask( n_total_samples,n_total_in_bag )

ra=rand(1,n_total_samples);
sample_mask=zeros(1,n_total_samples);
n_bagged = 0;
for i=1:1:n_total_samples
    if ra(i) * (n_total_samples - i) < (n_total_in_bag - n_bagged)
        sample_mask(i) = 1;
        n_bagged=n_bagged+1;
    end
end
end


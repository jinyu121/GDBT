function [ xx ] = Util_ravel( x )
xx=x' ;
xx=xx(:);
xx=xx';
end

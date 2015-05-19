function [ y ] = Util_nan_to_num( x )
y=x;
y(isnan(y))=0;
y(y==(-inf))=(-1.79769313e+308);
y(y==(inf))=(1.79769313e+308);
end

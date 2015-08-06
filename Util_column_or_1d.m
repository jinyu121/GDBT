function [ y ] = Util_column_or_1d( y )

ishape=size(y);
if length(ishape)==2 && ishape(1)==1
    y=Util_ravel(y);
elseif length(ishape)==2 && ishape(2)==1
    y=Util_ravel(y);
else
    error('bad input shape.');
end

end

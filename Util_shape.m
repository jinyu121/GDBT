function [ y ] = Util_shape( x ,which)
[a,b]=size(x);
switch which
    case 0:
        y=b;
    case 1:
        y=a;
end
end


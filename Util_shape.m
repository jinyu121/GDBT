function [ y ] = Util_shape( x ,which)
[a,b]=size(x);
switch which
    case 0
        y=a;
    case 1
        y=b;
end
end


function [ ret ] = GBM_array_index( val,arr )
ret=-1;
n=Util_shape(arr,0);
for i=1:1:n
    if arr(i)==val
        ret=i;
        return;
    end
end
end

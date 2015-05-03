function [ is_initialized ] = GBM_is_initialized( inself )
self=inself;
is_initialized=(~isempty(self.estimators_));
end


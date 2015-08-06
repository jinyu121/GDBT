function [ is_initialized ] = GBM_is_initialized( ingbm )
self=ingbm;
is_initialized=(~isempty(self.estimators_));
end

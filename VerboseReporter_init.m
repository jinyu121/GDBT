function self = VerboseReporter_init( inverbose,inest,inbegin_at_stage )
% # plot verbose info each time i % verbose_mod == 0
self=inverbose;
est=inest;

self.Iter=true;
fprintf('Iter\t');
self.Loss=true;
fprintf('Train_Loss\t');
if est.subsample<1
    self.OOB_Improve=true;
    fprintf('OOB_Improve');
else
    self.OOB_Improve=false;
end
self.verbose_mod = 1;
self.begin_at_stage = inbegin_at_stage;
fprintf('\n');
end

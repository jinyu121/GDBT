function self = VerboseReporter_init( inverbose,inest,inbegin_at_stage )
% # plot verbose info each time i % verbose_mod == 0
self=inverbose;
self.verbose_mod = 1;
self.begin_at_stage = inbegin_at_stage;
self.verbose_fmt ='{iter:>10d} {train_score:>16.4f}';
if est.subsample < 1
    append(verbose_fmt,' {oob_impr:>16.4f}');
end
end

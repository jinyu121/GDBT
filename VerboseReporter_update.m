function self = VerboseReporter_update( inself,j,est )
self=inself;
% """Update reporter with new iteration. """
do_oob = (est.subsample < 1);
i = j - self.begin_at_stage;
if mod((i + 1) , self.verbose_mod) == 0
    if do_oob
        oob_impr = est.oob_improvement_(j);
    else
        oob_impr=0;
    end
    fprintf(self.verbose_fmt,j + 1,est.train_score_(j),oob_impr);
    if self.verbose == 1 && (int((i + 1) / (self.verbose_mod * 10)) > 0)
        self.verbose_mod = self.verbose_mod*10;
    end
end
end


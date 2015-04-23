function self = VerboseReporter_update( inself,j,est )
self=inself;
% """Update reporter with new iteration. """
do_oob = (est.subsample < 1);
i = j - self.begin_at_stage;
if mod((i + 1) , self.verbose_mod) == 0
    if dp_oob
        oob_impr = est.oob_improvement_(j)
    else
        oob_impr=0
    end
    if self.verbose == 1 && (int((i + 1) / (self.verbose_mod * 10)) > 0)
        %         # adjust verbose frequency (powers of 10)
        self.verbose_mod *= 10
    end
end
end


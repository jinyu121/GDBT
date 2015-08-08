function self = VerboseReporter_update( inVerboseReporter,j,est )
self=inVerboseReporter;
% """Update reporter with new iteration. """
do_oob = (est.subsample < 1);
i = j - self.begin_at_stage;
if mod((i + 1) , self.verbose_mod) == 0
    if do_oob
        oob_impr = est.oob_improvement_(j);
    else
        oob_impr=0;
    end
    if self.Iter>0
        fprintf('%10d\t',j+1);
    end
    if self.Loss>0
        fprintf('%16.4f\t',est.train_score_(j));
    end
    if self.OOB_Improve>0
        fprintf('%16.4f\t',oob_impr);
    end
    fprintf('\n');
    if self.verbose == 1 && (int((i + 1) / (self.verbose_mod * 10)) > 0)
        % adjust verbose frequency (powers of 10)
        self.verbose_mod = self.verbose_mod*10;
    end
end
end

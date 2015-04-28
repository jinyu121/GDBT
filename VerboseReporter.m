function self  = VerboseReporter( verbose )
%     """Reports verbose output to stdout.
% 
%     If ``verbose==1`` output is printed once in a while (when iteration mod
%     verbose_mod is zero).; if larger than 1 then output is printed for
%     each update.
%     """
self.verbose=verbose;
end


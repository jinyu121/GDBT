function [ self,y ] = GBM__validate_y( inself,Y )


self=inself;
if strcmp(self.name,'GradientBoostingClassifier')
    [self.classes_,unuse,y]=unique(y);
    y=y';
    self.n_classes_ = length(self.classes_);
else
    self.n_classes_ = 1;
    y=Y;
end


end


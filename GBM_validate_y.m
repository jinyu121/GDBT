function [self,y]=GBM_validate_y(inself,inY)
%% Reformat y and calculate the number of the classes
y=inY;
self=inself;
[self.classes_,unuse,y]=unique(y);
self.n_classes_=length(self.classes_);
end
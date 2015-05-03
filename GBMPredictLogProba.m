function [ proba ] = GBMPredictLogProba( inself,X )
self=inself;
if strcmp(self.name,'GradientBoostingClassifier')
    proba = GBMPredictProba(self,X);
    proba=log(proba);
end

end
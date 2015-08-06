function [ proba ] = GBMPredictLogProba( ingbm,X )
self=ingbm;
if strcmp(self.name,'GradientBoostingClassifier')
    proba = GBMPredictProba(self,X);
    proba=log(proba);
end
end

function [ ret ] = LossFunction_score_to_decision( inLossFunction, score )
self=inLossFunction;
switch self.name
    case 'BinomialDeviance'
        proba = LossFunction__score_to_proba(self,score);
        [foo,ret]=max(proba');
    case 'MultinomialDeviance'
        proba = LossFunction__score_to_proba(self,score);
        [foo,ret]=max(proba');
    case 'ExponentialLoss'
        ret= (Util_ravel(score) >= 0.0);
end
end

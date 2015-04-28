function [ ret ] = LossFunction_score_to_decision( inLossFunction, score )
self=inLossFunction;
switch self.name
    case 'BinomialDeviance'
        
        proba = LossFunction_score_to_proba(self,score);
        %         Todo:
        %         ret =argmax(proba, axis=1);
        return np.argmax(proba, axis=1)
    case 'MultinomialDeviance'
        proba = LossFunction_score_to_proba(self,score);
        %         Todo:
        %         ret =argmax(proba, axis=1);
    case 'ExponentialLoss'
        ret= (Util_reval(score) >= 0.0)
end
end


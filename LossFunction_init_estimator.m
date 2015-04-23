function [ ouEstimator ] = LossFunction_init_estimator( inLossFunction )
self=inLossFunction;
switch self.name
    case 'LeastSquaresError'
        ouEstimator=Estimeter('MeanEstimator',0);
    case 'LeastAbsoluteError'
        ouEstimator=Estimeter('MeanEstimator',0.5);
    case 'HuberLossFunction'
        ouEstimator=Estimeter('QuantileEstimator',0.5);
    case 'QuantileLossFunction'
        ouEstimator=Estimeter('QuantileEstimator',self.alpha);
    case 'BinomialDeviance'
        ouEstimator=Estimeter('LogOddsEstimator',0);
    case 'MultinomialDeviance'
        ouEstimator=Estimeter('PriorProbabilityEstimator',0);
    case 'ExponentialLoss'
        ouEstimator=Estimeter('ScaledLogOddsEstimator',0);
end
end


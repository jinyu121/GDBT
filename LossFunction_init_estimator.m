function [ ouEstimator ] = LossFunction_init_estimator( inLossFunction )
self=inLossFunction;
switch self.name
    case 'LeastSquaresError'
        ouEstimator=Estimeter('MeanEstimator',nan);
    case 'LeastAbsoluteError'
        ouEstimator=Estimeter('QuantileEstimator',0.5);
    case 'HuberLossFunction'
        ouEstimator=Estimeter('QuantileEstimator',0.5);
    case 'QuantileLossFunction'
        ouEstimator=Estimeter('QuantileEstimator',self.alpha);
    case 'BinomialDeviance'
        ouEstimator=Estimeter('LogOddsEstimator',nan);
    case 'MultinomialDeviance'
        ouEstimator=Estimeter('PriorProbabilityEstimator',nan);
    case 'ExponentialLoss'
        ouEstimator=Estimeter('ScaledLogOddsEstimator',nan);
end
end


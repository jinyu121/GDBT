function [ ouEstimator ] = LossFunction_init_estimator( inLossFunction )
self=inLossFunction;
switch self.name
    case 'LeastSquaresError'
        ouEstimator=Estimator('MeanEstimator',nan);
    case 'LeastAbsoluteError'
        ouEstimator=Estimator('QuantileEstimator',0.5);
    case 'HuberLossFunction'
        ouEstimator=Estimator('QuantileEstimator',0.5);
    case 'QuantileLossFunction'
        ouEstimator=Estimator('QuantileEstimator',self.alpha);
    case 'BinomialDeviance'
        ouEstimator=Estimator('LogOddsEstimator',nan);
    case 'MultinomialDeviance'
        ouEstimator=Estimator('PriorProbabilityEstimator',nan);
    case 'ExponentialLoss'
        ouEstimator=Estimator('ScaledLogOddsEstimator',nan);
end
end

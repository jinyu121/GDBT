% Cleaning Workspace
clear all;
close all;
clc;

% Load data
load 'Data_set_wine_indx_fixed.mat'

result=[];

for i=1:1:10
    fprintf('#%2d\t',i);
    
    sets=Dataset_info.indices(i);
    training=sets.training;
    test=sets.test;
    % The GBM
    gbm=GradientBoostingClassifier('deviance', ...
        0.1,...
        100,...
        2,...
        1,...
        0.0,...
        3,...
        [],...
        1.0,...
        [],...
        0.9,...
        0,...
        [],...
        true);
    
    % Train The Model
    fprintf('Training\t');
    gbm=GBMFit(gbm,feature(training,:),target(training,:),[]);
    
    % Predict
    fprintf('Predicting\t');
    Result_Predict=GBMPredict(gbm,feature(test,:));
    Result_Target=Util_ravel(target(test,:));
    
    % Calculate the error rate
    Error_Rate=sum(Result_Predict~=Result_Target)/Util_shape(test,0);
    result(i)=1-Error_Rate;

    fprintf('-> %.4f',result(i));
    fprintf('\n')
end


result
fprintf('Max: %.4f\t Min: %.4f\t Avg: %.4f', ...
        max(result), ...
        min(result), ...
        mean(result));
fprintf('\n');
    

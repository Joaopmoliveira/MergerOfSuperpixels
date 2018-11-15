function [data]=ScatterData(data)
    if isfield(data,'gaussian')
    data=rmfield(data,'gaussian');
    end
    Names=fieldnames(data.Objects);
    numberObjects=numel(Names);
    figure
    for i=1:numberObjects
        Statistics=data.Objects.(Names{i});
        VarianceVector=Statistics(2,:);
        MeanVar=mean(VarianceVector);
        SkewnessVector=Statistics(3,:);
        SkewnessMean=mean(SkewnessVector);
        KurtosisVector=Statistics(4,:);
        KurtosisMean=var(KurtosisVector);
        scatter3(VarianceVector,SkewnessVector,KurtosisVector);
        hold on
        MatrixSigma=cov([VarianceVector',SkewnessVector',KurtosisVector'],1);
        data.gaussian(i)=struct('String',Names{i},'Gauss_Sigma',MatrixSigma,'Gauss_Center',[MeanVar,SkewnessMean,KurtosisMean]');
    end
    xlabel('variance');
    ylabel('Skewness');
    zlabel('Kurtwness');
    legend('Mar','Arvore','Estrada');
end
function Boolean=statisticsOfImage(Act,Var,ColorVector,thresholdStat)
load data1
Names=fieldnames(data1.Objects);
numberObjects=numel(Names);
RunVector=[Act,Var];
for i=RunVector
    for j=1:numberObjects
        MatrixSigma=1;
        Probability=(1/(((2*pi)^(3/2))*sqrt(det(MatrixSigma))))*exp((-1/2)*(ColorVector(5:7,Act)-1)*1*(1));
        
    end
end
end
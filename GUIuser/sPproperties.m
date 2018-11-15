function handles = sPproperties(B,N,L,handles)
numRows = size(B,1);
numCols = size(B,2);
adj = cell(N,1);
%Aqui guardamos os valores de cor num vetor para facilitar o processamento
%que é necessario a seguir
idx=handles.idx;
Igray=rgb2gray(B);
MessageWarning = msgbox({'Your image is being processed'; 'Wait until this window closes'});
ColorVector=zeros(4,N);
for pixVal=1:N;
    redIdx               = idx{pixVal};
    greenIdx             = idx{pixVal}+numRows*numCols;
    blueIdx              = idx{pixVal}+2*numRows*numCols;
    [count,X]      = imhist(Igray(idx{pixVal}));
    occurenceVector= createOcurrenceVector(X,count);
    var       = std(occurenceVector);
    skew      = skewness(occurenceVector);
    Kurt      = kurtosis(occurenceVector);
    ColorVector(1,pixVal)= mean(B(redIdx));
    ColorVector(2,pixVal)= mean(B(greenIdx));
    ColorVector(3,pixVal)= mean(B(blueIdx));
    ColorVector(4,pixVal)= length(idx{pixVal});
    ColorVector(5,pixVal)= var;
    ColorVector(6,pixVal)= skew;
    ColorVector(7,pixVal)= Kurt;
    prevMask             = (L == pixVal);
    currMask             = imdilate(prevMask, ones(3));
    adj{pixVal}          = unique(L(currMask & ~prevMask));
end
if ~isempty(MessageWarning)
    delete(MessageWarning);
end
handles.ColorVector=ColorVector;
handles.adj=adj;
end


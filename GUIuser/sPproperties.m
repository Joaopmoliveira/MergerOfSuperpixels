function [ColorVector,adj] = sPproperties(B,N,idx,L)
numRows = size(B,1);
numCols = size(B,2);
adj = cell(N,1);
%Aqui guardamos os valores de cor num vetor para facilitar o processamento
%que é necessario a seguir
ColorVector=zeros(4,N);
for pixVal=1:N;
    redIdx               = idx{pixVal};
    greenIdx             = idx{pixVal}+numRows*numCols;
    blueIdx              = idx{pixVal}+2*numRows*numCols;
    ColorVector(1,pixVal)= mean(B(redIdx));
    ColorVector(2,pixVal)= mean(B(greenIdx));
    ColorVector(3,pixVal)= mean(B(blueIdx));
    ColorVector(4,pixVal)= length(idx{pixVal});
    prevMask             = (L == pixVal);
    currMask             = imdilate(prevMask, ones(3));
    adj{pixVal}          = unique(L(currMask & ~prevMask));
end
end


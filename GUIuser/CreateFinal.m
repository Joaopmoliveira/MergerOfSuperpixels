function outputImage=CreateFinal(B,idx,numRows,numCols)
    N=length(idx);
    outputImage=zeros(size(B));
    for labelVal = 1:N
        redIdx = idx{labelVal};
        greenIdx = idx{labelVal}+numRows*numCols;
        blueIdx = idx{labelVal}+2*numRows*numCols;
        outputImage(redIdx) = mean(B(redIdx));
        outputImage(greenIdx) = mean(B(greenIdx));
        outputImage(blueIdx) = mean(B(blueIdx));
    end 
end
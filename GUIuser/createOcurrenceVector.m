function occurenceVector=createOcurrenceVector(x,count)
    n=sum(count);
    occurenceVector=zeros(1,n);
    j=1;
    for i=1:length(x)
        temporaryVector=ones(1,count(i))*x(i);
        occurenceVector(j:j-1+length(temporaryVector))=temporaryVector;
        j=j+length(temporaryVector);
    end
end
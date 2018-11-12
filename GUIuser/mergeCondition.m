function Boolean=mergeCondition(pixVal,adj,ColorVector,condition,j,threshold)
switch condition
    case 1
        Boolean=ColorConditionAngle(pixVal,adj{pixVal}(j),ColorVector,threshold);
    case 2
        Boolean=ColorConditionNorm(pixVal,adj{pixVal}(j),ColorVector,threshold);
    case 3
        Boolean=0;
    case 4
        Boolean=ColorConditionAngle(pixVal,adj{pixVal}(j),ColorVector,threshold);
end
end
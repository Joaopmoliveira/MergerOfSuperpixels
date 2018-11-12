function [MergeMatrix,handles] = mergeSP(adj,ColorVector,threshold,N,B,BW,handles)
MergeMatrix=zeros(N);
[condition,handles]=chooseCondition(B,BW,handles);
for pixVal=1:N
    for j=1:length(adj{pixVal})
        if  mergeCondition(pixVal,adj,ColorVector,condition,j,threshold)% ColorConditionAngle(pixVal,adj{pixVal}(j),ColorVector,condition) %&& statisticsOfImage() %Esta � a condi��o de inclus�o se um grupo de
            %pixeis do no i deve ou n�o ser fundido com o grupo de pixeis do no j
            MergeMatrix(pixVal,adj{pixVal}(j))=1;
        end
    end
end
end
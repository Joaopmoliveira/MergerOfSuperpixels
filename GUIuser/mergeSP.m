function handles = mergeSP(N,B,BW,handles)
MergeMatrix=zeros(N);
[condition,handles]=chooseCondition(B,BW,handles);
adj=handles.adj;
for pixVal=1:N
    for j=1:length(adj{pixVal})
        if  mergeCondition(pixVal,adj,condition,j,handles)% ColorConditionAngle(pixVal,adj{pixVal}(j),ColorVector,condition) %&& statisticsOfImage() %Esta é a condição de inclusão se um grupo de
            %pixeis do no i deve ou não ser fundido com o grupo de pixeis do no j
            MergeMatrix(pixVal,adj{pixVal}(j))=1;
        end
    end
end
handles.MergeMatrix=MergeMatrix;
end
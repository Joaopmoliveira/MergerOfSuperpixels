function StartHere()
close
clearvars
addpath([pwd,'\GUIuser'])
%Here the algorithm asks the user for the image he wants so select 
%and what are the parameters for the SLIC method
[B,L,N,idx,BW,handles]=preprocessing();
%Here the properties of the Superpixels are processed
[ColorVector,adj] = sPproperties(B,N,idx,L);
%Here the superpixels that will be connected are identified
[MergeMatrix,handles] = mergeSP(adj,ColorVector,0.04,N,B,BW,handles);
%The graph resulting from the connected superpixels is identified and 
% the final resulting hyperpixels (the previous superpixels connected)
% are created
[idxfinal,Lf] = graphMerge(MergeMatrix,L,idx);
%the final results are shown to the user
PlotFinalResults(handles,B,BW,idxfinal,idx,Lf)
end

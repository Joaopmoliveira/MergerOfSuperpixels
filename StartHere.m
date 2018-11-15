function StartHere()
close
clearvars
addpath([pwd,'\GUIuser'])
%Here the algorithm asks the user for the image he wants so select 
%and what are the parameters for the SLIC method
[B,L,N,BW,handles]=preprocessing();
%Here the properties of the Superpixels are processed
handles = sPproperties(B,N,L,handles);
%Here the superpixels that will be connected are identified
handles = mergeSP(N,B,BW,handles);
%The graph resulting from the connected superpixels is identified and 
% the final resulting hyperpixels (the previous superpixels connected)
% are created
[handles,Lf] = graphMerge(L,handles);
%the final results are shown to the user
PlotFinalResults(handles,B,BW,Lf)
end

function PlotFinalResults(handles,B,BW,idxfinal,idx,Lf)
numRows = size(B,1);
numCols = size(B,2);
Ifinal=CreateFinal(B,idxfinal,numRows,numCols);
Iinitial=CreateFinal(B,idx,numRows,numCols);
Ifinal=uint8(ImproveImage(Ifinal,1.5,1.05));
Iinitial=uint8(ImproveImage(Iinitial,1.5,1.05));
B=uint8(ImproveImage(B,1.5,1.05));
BWf= boundarymask(Lf);
INmedian=imoverlay(B,BW,'cyan');
FNmedian=imoverlay(B,BWf,'cyan');
Imedian=imoverlay(Iinitial,BW,'cyan');
Fmedian=imoverlay(Ifinal,BWf,'cyan');
axesHandlesToChildObjects = findobj(handles.CurrentAxx, 'Type', 'image');
if ~isempty(axesHandlesToChildObjects)
    delete(axesHandlesToChildObjects);
end
set(handles.Possibilities,'Visible','off')
set(handles.Text6,'Visible','off')
set(handles.Next1,'Visible','off')
test=figure('Name','PreProcessing Image');
set(test,'position',[100 100 800 500]);
CurrentAxx=axes('position',[0.10 0.125 0.75 0.7]);
imshow(FNmedian);
handles.CurrentAxx=CurrentAxx;
Previous=uicontrol('Style','pushbutton','Position',[80 440 300 20],'string','Preprocessed Image');
NextIm=uicontrol('Style','pushbutton','Position',[380 440 300 20],'string','Processed Image');
MedianCo=uicontrol('Style','pushbutton','Position',[680 200 90 100],'string','Median Color');
string='finish';
Close=uicontrol('Style','pushbutton','Position',[680 100 90 20],'string','Close');
Previous.Callback={@endfunction1_callback,MedianCo,handles,INmedian,Imedian};
NextIm.Callback={@endfunction2_callback,MedianCo,handles,FNmedian,Fmedian};
MedianCo.Callback={@endfunction3_callback};
Close.Callback={@endfinish_callback,string};

    function endfunction1_callback(src,event,MedianCo,handles,INmedian,Imedian)
        verify=MedianCo.String;
        src.UserData=verify;
        if strcmp(verify,'Median Color')
            axesHandlesToChildObjects = findobj(handles.CurrentAxx, 'Type', 'image');
            if ~isempty(axesHandlesToChildObjects)
                delete(axesHandlesToChildObjects);
            end
            CurrentAxx=axes('position',[0.10 0.125 0.75 0.7]);
            imshow(INmedian)
            handles.CurrentAxx=CurrentAxx;
        else
            CurrentAxx=axes('position',[0.10 0.125 0.75 0.7]);
            imshow(Imedian)
            handles.CurrentAxx=CurrentAxx;
        end         
    end
    function endfunction2_callback(src,event,MedianCo,handles,FNmedian,Fmedian)
        verify=MedianCo.String;
        src.UserData=verify;
        if strcmp(verify,'Median Color')
            axesHandlesToChildObjects = findobj(handles.CurrentAxx, 'Type', 'image');
            if ~isempty(axesHandlesToChildObjects)
                delete(axesHandlesToChildObjects);
            end
            CurrentAxx=axes('position',[0.10 0.125 0.75 0.7]);
            imshow(FNmedian)
            handles.CurrentAxx=CurrentAxx;
        else
            CurrentAxx=axes('position',[0.10 0.125 0.75 0.7]);
            imshow(Fmedian)
            handles.CurrentAxx=CurrentAxx;
        end    
    end
    function endfunction3_callback(src,event)
        if strcmp(src.String,'Median Color')
            src.String='Original';
        else
            src.String='Median Color';
        end  
    end
    function endfinish_callback(src,event,string)
        src.String=string;
    end
waitfor(Close,'String')
close all
end
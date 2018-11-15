function [B,L,N,BW,handles]=preprocessing()
Message_to_user = msgbox({'This GUI was made in order to help you find the correct parameters for the algorithm provided';...
'You should habe the following programs inside the folder "GUIuser" your directory';...
'-preprocessing.m';'-sPproperties.m';'-mergeSP.m';'-chooseCondition.m';'-mergeCondition.m';...
'-graphMerge.m';'-PlotFinalResults.m';'-CreateFinal.m';'-ImproveImage.m';...
'You shold also have a folder in your directory named "Images" where all your images are.';...
'On a final note, after learning what are the correct parameters for the end goals you want you shold try using the code in folder "code" to modify and improve the algorithm'},'Use of GUI');
waitfor(Message_to_user);
d=dir('Images\*JPG');
addpath([pwd,'\Images'])
A=imread(d(1).name);
test=figure('Name','PreProcessing Image');
set(test,'position',[100 100 800 500]);
CurrentAxx=axes('position',[0.35 0.2 0.6 0.8]);
imshow(A)
k={d(:).name};
clear A;
ImageSelection=uicontrol('Style','listbox','Position',[50 50 200 400],'string',k);
Text1=uicontrol('Style','text','String','Images on your directory:','Position',[50 460 200 16]);
Text2=uicontrol('Style','text','String','Current image choosen','Position',[420 460 200 16]);
ImageSelection.Callback={@plotNewImage_callback,k,CurrentAxx};    
Next=uicontrol('Style','pushbutton','Position',[670 50 100 20],'string','Select Image');
Next.Callback={@endfunction_callback,k,ImageSelection};
handles = guihandles(test);
handles.Text1=Text1;
handles.Text2=Text2;
handles.ImageSelection=ImageSelection;
handles.Next=Next;
    function plotNewImage_callback(src,event,k,CurrentAxx)
        axesHandlesToChildObjects = findobj(CurrentAxx, 'Type', 'image');
        if ~isempty(axesHandlesToChildObjects)
            delete(axesHandlesToChildObjects);
        end
        SelectedImage=event.Source.Value;
        IM=imread(k{SelectedImage});
        CurrentAxx=axes('position',[0.35 0.2 0.6 0.8]);
        event.Source.UserData=CurrentAxx;
        imshow(IM)
    end
    function endfunction_callback(src,event,k,ImageSelection)
        stringImage=k{ImageSelection.Value};
        src.UserData=stringImage;
    end
waitfor(Next,'UserData');
set(ImageSelection,'Enable','inactive')
A=imread(stringImage);
B=imresize(A,1/4);
set(Next,'Enable','off')
Done=uicontrol('Style','pushbutton','Position',[670 50 100 20],'string','Done');
Done.Callback={@finalfucntion_callback};
    function finalfucntion_callback(src,event)
        src.UserData='String';
    end
Text3=uicontrol('Style','text','String','Properties for the SLIC method','Position',[280 110 200 16]);handles.Text3=Text3;
Text4=uicontrol('Style','text','String','Desired SP number','Position',[280 90 110 16]);handles.Text4=Text4;
ValueInput = uicontrol('Style','edit','Position',[400 90 50 16]);
uicontrol(ValueInput);
waitfor(ValueInput,'String')
NumberSP = str2double(get(ValueInput,'String'));
handles.ValueInput=ValueInput;
Text5=uicontrol('Style','text','String','Compactness factor','Position',[280 70 110 16]);handles.Text5=Text5;
ValueInput2 = uicontrol('Style','edit','Position',[400 70 50 16]);
uicontrol(ValueInput2);
waitfor(ValueInput2,'String')
handles.ValueInput2=ValueInput2;
Compactness = str2double(get(ValueInput2,'String'));
Retry=uicontrol('Style','pushbutton','Position',[570 50 100 20],'string','Retry');
handles.Done=Done;
Retry.Callback={@Retryfunction_callback,handles};
    function Retryfunction_callback(src,event,handles)
        set(handles.ValueInput2,'Enable','off')
        set(handles.ValueInput2,'Visible','off')
        set(handles.ValueInput,'Enable','off')
        set(handles.ValueInput,'Visible','off')
        set(handles.Done,'Enable','inactive')
        ValueInput = uicontrol('Style','edit','Position',[400 90 50 16]);
        uicontrol(ValueInput);
        waitfor(ValueInput,'String')
        NumberSP = str2double(get(ValueInput,'String'));
        handles.ValueInput=ValueInput;
        ValueInput2 = uicontrol('Style','edit','Position',[400 70 50 16]);
        uicontrol(ValueInput2);
        waitfor(ValueInput2,'String')
        Compactness = str2double(get(ValueInput2,'String'));
        handles.ValueInput2=ValueInput2;
        [L,N] = superpixels(B,NumberSP,'Method','slic','Compactness',Compactness);
        BW = boundarymask(L);
        axesHandlesToChildObjects = findobj(ImageSelection.UserData, 'Type', 'image');
        if ~isempty(axesHandlesToChildObjects)
             delete(axesHandlesToChildObjects);
        end
        CurrentAxx=axes('position',[0.35 0.2 0.6 0.8]);
        imshow(imoverlay(B,BW,'cyan'));
        handles.CurrentAxx=CurrentAxx;       
        set(handles.Done,'Enable','on')
        event.Source.UserData.handles=handles;
        event.Source.UserData.activation=1;
    end
[L,N] = superpixels(B,NumberSP,'Method','slic','Compactness',Compactness);
BW = boundarymask(L);
set(Text2,'String','Result of SLIC method')
axesHandlesToChildObjects = findobj(ImageSelection.UserData, 'Type', 'image');
if ~isempty(axesHandlesToChildObjects)
    delete(axesHandlesToChildObjects);
end
CurrentAxx=axes('position',[0.35 0.2 0.6 0.8]);
imshow(imoverlay(B,BW,'cyan'));
waitfor(Done,'UserData')
if ~isempty(Retry.UserData)
    handles=Retry.UserData.handles;
else
    handles.CurrentAxx=CurrentAxx;
end
handles.idx=label2idx(L);
end
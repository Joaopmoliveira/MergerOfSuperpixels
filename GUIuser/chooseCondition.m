function [condition,handles]=chooseCondition(B,BW,handles)
set(handles.Next,'Visible','off')
set(handles.Done,'Visible','off')
set(handles.Text1,'Visible','off')
set(handles.Text2,'Visible','off')
set(handles.ImageSelection,'Visible','off')
set(handles.Text3,'Visible','off')
set(handles.Text4,'Visible','off')
set(handles.Text5,'Visible','off')
set(handles.ValueInput,'Visible','off')
set(handles.ValueInput2,'Visible','off')
axesHandlesToChildObjects = findobj('Type', 'image');
if ~isempty(axesHandlesToChildObjects)
    delete(axesHandlesToChildObjects);
end
String='Acepted';
handles.CurrentAxx=axes('position',[0.1250 0.4 0.75 0.53]);
imshow(imoverlay(B,BW,'cyan'));
Options={'1-Maximum angle between SP in RBG space.'...
    ,'2-Maximum norm of the differente between two different SP in RBG space.'...
    ,'3-Statistics of graycale image (Standart deviation, Skewness, Kurtosis).'...
    ,'4-Both coditions 1 and 3.'};
possibilities=uicontrol('Style','listbox','Position',[100 75 600 76],'string',Options);
handles.Possibilities=possibilities;
Text6=uicontrol('Style','text','String','Choose what condition you want to test:','Position',[100 150 200 16]);
handles.Text6=Text6;
Next1=uicontrol('Style','pushbutton','Position',[100 50 600 20],'string','Select method to process Image');
Next1.Callback={@endfunction_callback,String};
    function endfunction_callback(src,event,String)
        src.UserData=String;
    end
waitfor(Next1,'UserData')
handles.Next1=Next1;
condition = get(possibilities,'Value');
end
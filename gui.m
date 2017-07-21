function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 16-Jul-2017 20:48:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.excelOpen_button,'enable','off');

% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in select_button.
function select_button_Callback(hObject, eventdata, handles)
% hObject    handle to select_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function select_edit_Callback(hObject, eventdata, handles)
% hObject    handle to select_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of select_edit as text
%        str2double(get(hObject,'String')) returns contents of select_edit as a double


% --- Executes during object creation, after setting all properties.
function select_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in run_button.
function run_button_Callback(hObject, eventdata, handles)
% hObject    handle to run_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
error=0;
video_name = get(handles.select_edit,'string');
video_info = VideoReader(video_name);
    
x1=get(handles.x1_edit,'string');
x1=str2num(x1);
x2=get(handles.x2_edit,'string');
x2=str2num(x2);
y1=get(handles.y1_edit,'string');
y1=str2num(y1);
y2=get(handles.y2_edit,'string');
y2=str2num(y2);
folder_name= get(handles.folder_edit,'string');
image_name=get(handles.image_name,'string');
if((x1>=video_info.Width) || (x1<0))
    error=1;
end

if(x2>=video_info.Width || x2<0)
    error=1;
end

if(y1>=video_info.Height || y1<0)
    error=1;
end

if(y2>=video_info.Height || y2<0)
    error=1;
end

if(error==1)
    msgbox('Line error\n\rToa do duong la so va trong khoang do phan giai video')
else
    set(handles.y2_edit,'string',num2str(y1));
    line = [x1 y1 x2 y2];
end
excel_name=get(handles.excelName_edit,'string');

if(excel_name==' ')
    error=2;
    msgbox('Excel file name error');
else
    excel_file=strcat(excel_name,'.xlsx');
end

if(folder_name==' ')
    error=3;
    msgbox('Folder name error');
end
if(image_name==' ')
    error=3;
    msgbox('Image name error');
end
set(handles.excelOpen_button,'enable','off');
if(error==0)    
    Cat_Anh_To_Vien2(video_name, line, excel_file,folder_name,image_name);
end
set(handles.excelOpen_button,'enable','on');

% --- Executes on button press in close_button.
function close_button_Callback(hObject, eventdata, handles)
% hObject    handle to close_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choice = questdlg('Do you want to quit?', ...
	'Close', ...
	'Yes','No','No');
% Handle response
switch choice
    case 'Yes'
        close
    case 'No'      
end


function x1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to x1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x1_edit as text
%        str2double(get(hObject,'String')) returns contents of x1_edit as a double


% --- Executes during object creation, after setting all properties.
function x1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to y1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y1_edit as text
%        str2double(get(hObject,'String')) returns contents of y1_edit as a double


% --- Executes during object creation, after setting all properties.
function y1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to x2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x2_edit as text
%        str2double(get(hObject,'String')) returns contents of x2_edit as a double


% --- Executes during object creation, after setting all properties.
function x2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to y2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y2_edit as text
%        str2double(get(hObject,'String')) returns contents of y2_edit as a double


% --- Executes during object creation, after setting all properties.
function y2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function excelName_edit_Callback(hObject, eventdata, handles)
% hObject    handle to excelName_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of excelName_edit as text
%        str2double(get(hObject,'String')) returns contents of excelName_edit as a double


% --- Executes during object creation, after setting all properties.
function excelName_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to excelName_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in excelOpen_button.
function excelOpen_button_Callback(hObject, eventdata, handles)
% hObject    handle to excelOpen_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
excel_name=get(handles.excelName_edit,'string');
if(excel_name==' ')
    msgdialog('Excel file name error ');
else
    excel_file=strcat(excel_name,'.xlsx');
    winopen(excel_file);
end



function folder_edit_Callback(hObject, eventdata, handles)
% hObject    handle to folder_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of folder_edit as text
%        str2double(get(hObject,'String')) returns contents of folder_edit as a double


% --- Executes during object creation, after setting all properties.
function folder_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to folder_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function image_name_Callback(hObject, eventdata, handles)
% hObject    handle to image_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of image_name as text
%        str2double(get(hObject,'String')) returns contents of image_name as a double


% --- Executes during object creation, after setting all properties.
function image_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to image_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on select_edit and none of its controls.
function select_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to select_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

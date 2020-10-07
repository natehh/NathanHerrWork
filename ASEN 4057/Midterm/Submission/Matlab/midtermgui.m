%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nathan Herr
% ASEN 4057-Midterm
% GUI to run simulate_particle and create plots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function varargout = midtermgui(varargin)
% MIDTERMGUI MATLAB code for midtermgui.fig
%      MIDTERMGUI, by itself, creates a new MIDTERMGUI or raises the existing
%      singleton*.
%
%      H = MIDTERMGUI returns the handle to a new MIDTERMGUI or the handle to
%      the existing singleton*.
%
%      MIDTERMGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MIDTERMGUI.M with the given input arguments.
%
%      MIDTERMGUI('Property','Value',...) creates a new MIDTERMGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before midtermgui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to midtermgui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help midtermgui

% Last Modified by GUIDE v2.5 17-Mar-2019 02:34:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @midtermgui_OpeningFcn, ...
                   'gui_OutputFcn',  @midtermgui_OutputFcn, ...
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


% --- Executes just before midtermgui is made visible.
function midtermgui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to midtermgui (see VARARGIN)

% Choose default command line output for midtermgui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes midtermgui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = midtermgui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function x0edit_Callback(hObject, eventdata, handles)
% hObject    handle to x0edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x0edit as text
%        str2double(get(hObject,'String')) returns contents of x0edit as a double


% --- Executes during object creation, after setting all properties.
function x0edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x0edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y0edit_Callback(hObject, eventdata, handles)
% hObject    handle to y0edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y0edit as text
%        str2double(get(hObject,'String')) returns contents of y0edit as a double


% --- Executes during object creation, after setting all properties.
function y0edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y0edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z0edit_Callback(hObject, eventdata, handles)
% hObject    handle to z0edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of z0edit as text
%        str2double(get(hObject,'String')) returns contents of z0edit as a double


% --- Executes during object creation, after setting all properties.
function z0edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to z0edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sigmaedit_Callback(hObject, eventdata, handles)
% hObject    handle to sigmaedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sigmaedit as text
%        str2double(get(hObject,'String')) returns contents of sigmaedit as a double


% --- Executes during object creation, after setting all properties.
function sigmaedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sigmaedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rhoedit_Callback(hObject, eventdata, handles)
% hObject    handle to rhoedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rhoedit as text
%        str2double(get(hObject,'String')) returns contents of rhoedit as a double


% --- Executes during object creation, after setting all properties.
function rhoedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rhoedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function betaedit_Callback(hObject, eventdata, handles)
% hObject    handle to betaedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of betaedit as text
%        str2double(get(hObject,'String')) returns contents of betaedit as a double


% --- Executes during object creation, after setting all properties.
function betaedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to betaedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function t0edit_Callback(hObject, eventdata, handles)
% hObject    handle to t0edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t0edit as text
%        str2double(get(hObject,'String')) returns contents of t0edit as a double


% --- Executes during object creation, after setting all properties.
function t0edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t0edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tendedit_Callback(hObject, eventdata, handles)
% hObject    handle to tendedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tendedit as text
%        str2double(get(hObject,'String')) returns contents of tendedit as a double


% --- Executes during object creation, after setting all properties.
function tendedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tendedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in simulate.
function simulate_Callback(hObject, eventdata, handles)
% hObject    handle to simulate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% define variables for input from text edits 
% positions
x0 = str2double(char(get(handles.x0edit,'String')));
y0 = str2double(char(get(handles.y0edit,'String')));
z0 = str2double(char(get(handles.z0edit,'String')));
% position vector
r0 = [x0,y0,z0];
% parameters
sigma = str2double(char(get(handles.sigmaedit,'String')));
rho = str2double(char(get(handles.rhoedit,'String')));
beta = str2double(char(get(handles.betaedit,'String')));
% start and end time
t0 = str2double(char(get(handles.t0edit,'String')));
tend = str2double(char(get(handles.tendedit,'String')));
% tspan
tspan = [t0,tend];
% call simulate_particle, plotter functions
[t,r] = simulate_particle(tspan, r0, sigma, rho, beta);
midtermplotter(t,r,handles.subplot)

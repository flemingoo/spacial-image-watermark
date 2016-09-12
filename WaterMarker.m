function varargout = WaterMarker(varargin)
% WATERMARKER MATLAB code for WaterMarker.fig
%      WATERMARKER, by itself, creates a new WATERMARKER or raises the existing
%      singleton*.
%
%      H = WATERMARKER returns the handle to a new WATERMARKER or the handle to
%      the existing singleton*.
%
%      WATERMARKER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WATERMARKER.M with the given input arguments.
%
%      WATERMARKER('Property','Value',...) creates a new WATERMARKER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before WaterMarker_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to WaterMarker_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help WaterMarker

% Last Modified by GUIDE v2.5 18-Oct-2015 23:52:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @WaterMarker_OpeningFcn, ...
                   'gui_OutputFcn',  @WaterMarker_OutputFcn, ...
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


% --- Executes just before WaterMarker is made visible.
function WaterMarker_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to WaterMarker (see VARARGIN)

% Choose default command line output for WaterMarker
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes WaterMarker wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = WaterMarker_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global assetIm
[path, usercancel]=imgetfile();
if usercancel
    %msgbox=(sprinf('Error.. Select an image. !!'));
    return
end 
assetIm=imread(path);
assetIm1=im2double(assetIm);
axes(handles.axes1);
imshow(assetIm1);




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global waterIm 
[path, usercancel]=imgetfile();
if usercancel
    return
end 
waterIm=imread(path);
waterIm1=im2double(waterIm);
axes(handles.axes2);
imshow(waterIm1);



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global assetIm waterIm outIm
sizeAssetIm=size(assetIm);
waterImResized = imresize(waterIm, [sizeAssetIm(1,1) sizeAssetIm(1,2)]);
M8 = bitget(waterImResized,8);
M7 = bitget(waterImResized,7);
M6 = bitget(waterImResized,6);
B3 = M8*2^2;
B2 = M7*2^1;
B1 = M6*2^0;
B4 = bitget(assetIm,4)*2^3 ;
B5 = bitget(assetIm,5)*2^4 ;
B6 = bitget(assetIm,6)*2^5 ;
B7 = bitget(assetIm,7)*2^6 ;
B8 = bitget(assetIm,8)*2^7 ;
outIm = B1+B2+B3+B4+B5+B6+B7+B8;
outIm1 = im2double(outIm);
axes(handles.axes3);
imshow(outIm1);

% --- Executes on button press in pushbutton5.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global markedIm 
[path, usercancel]=imgetfile();
if usercancel
    return
end 
markedIm=imread(path);
markedIm1=im2double(markedIm);
axes(handles.axes4);
imshow(markedIm1);

% --- Executes on button press in pushbutton4.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global markedIm messageIm waterIm
M6 = bitget(markedIm,1)*2^5 ;
M7 = bitget(markedIm,2)*2^6 ;
M8 = bitget(markedIm,3)*2^7 ;
messageIm = M6+M7+M8;
markedIm1=im2double(messageIm);
axes(handles.axes5);
imshow(markedIm1);
r=corr(messageIm,waterIm)

% --- Executes on button press in pushbutton5.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global outIm
[fileName,pathName] = uiputfile('Output.bmp','Save image as');
imwrite(outIm,fileName);
% if isequal(fileName,0) || isequal(pathName,0)
%    disp('User selected Cancel')
% else
%    disp(['User selected ',fullfile(pathName,fileName)])
% end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
arrayfun(@cla,findall(0,'type','axes'));

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close WaterMarker


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global messageIm
[fileName,pathName] = uiputfile('Watermark.bmp','Save image as');
imwrite(messageIm,fileName);

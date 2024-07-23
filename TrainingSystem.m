
function varargout = TrainingSystem(varargin)

% TRAININGSYSTEM MATLAB code for TrainingSystem.fig
%      TRAININGSYSTEM, by itself, creates a new TRAININGSYSTEM or raises the existing
%      singleton*.
%
%      H = TRAININGSYSTEM returns the handle to a new TRAININGSYSTEM or the handle to
%      the existing singleton*.
%
%      TRAININGSYSTEM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRAININGSYSTEM.M with the given input arguments.
%
%      TRAININGSYSTEM('Property','Value',...) creates a new TRAININGSYSTEM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TrainingSystem_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TrainingSystem_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TrainingSystem

% Last Modified by GUIDE v2.5 11-Dec-2019 02:30:48

% Begin initialization code - DO NOT EDIT
a = 100 ;
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TrainingSystem_OpeningFcn, ...
                   'gui_OutputFcn',  @TrainingSystem_OutputFcn, ...
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


% --- Executes just before TrainingSystem is made visible.
function TrainingSystem_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TrainingSystem (see VARARGIN)

% Choose default command line output for TrainingSystem
handles.output = hObject;
set(hObject,'toolbar','figure');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TrainingSystem wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TrainingSystem_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in catched.
function catched_Callback(hObject, eventdata, handles)
% hObject    handle to catched (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.catchedTheBall = 1;
set(handles.notCatched,'Value',0);
set(handles.catcherScore , 'Enable' , 'on');
set(handles.save , 'Enable' , 'off');
    hold on
     plot3(handles.graspingPosition(3) , handles.graspingPosition(1) ...
        , handles.graspingPosition(2)  ,'Marker', 'o', 'MarkerSize' , 15 ,'MarkerEdgeColor','k','MarkerFaceColor',[.49 1 .63],'Parent' , handles.jointsMap , ...
        'color' , 'g') ;
    hold off
    guidata(hObject, handles);
    
% Hint: get(hObject,'Value') returns toggle state of catched


% --- Executes on button press in notCatched.
function notCatched_Callback(hObject, eventdata, handles)
% hObject    handle to notCatched (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.catched,'Value',0);
handles.catchedTheBall = 0 ;
set(handles.catcherScore , 'Enable' , 'off');
set(handles.save , 'Enable' , 'on');
guidata(hObject, handles);
handles.catcherScoreByKeeper  = 0;
guidata(hObject, handles);



% Hint: get(hObject,'Value') returns toggle state of notCatched


% --- Executes on selection change in catcherScore.
function catcherScore_Callback(hObject, eventdata, handles)
% hObject    handle to catcherScore (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.catcherScoreByKeeper = get(handles.catcherScore , 'Value');
set(handles.save , 'Enable' , 'on');
guidata(hObject, handles);

% Hints: contents = cellstr(get(hObject,'String')) returns catcherScore contents as cell array
%        contents{get(hObject,'Value')} returns selected item from catcherScore


% --- Executes during object creation, after setting all properties.
function catcherScore_CreateFcn(hObject, eventdata, handles)
% hObject    handle to catcherScore (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

saveFile = matfile('ID.mat');
currentID = saveFile.ID ;
saveFile = matfile('No.mat');
currentNo = saveFile.No ;

% save things ///  to be writen later on

saveFile = matfile('order.mat');
order = saveFile.order ;
currentFolder = pwd ;
filename = sprintf('%s' , currentFolder , '\Datasets\before Throwing results.xlsx');
data = {currentID , currentNo , handles.depthSrc.BodyPosture , handles.bodyPosition(1),handles.bodyPosition(2),handles.bodyPosition(3),...
    handles.trackedLeftHand(1) ,handles.trackedLeftHand(2),handles.trackedLeftHand(3),...
    handles.trackedRightHand(1),handles.trackedRightHand(2),handles.trackedRightHand(3),...
    handles.direction, handles.height};
sheet = 1;
xlRange = sprintf('A%i' , order);
xlswrite(filename,data,sheet,xlRange)
filename = sprintf('%s' , currentFolder , '\Datasets\after Throwing results.xlsx');
handles.graspingHand, handles.graspingDirection
data = {currentID , currentNo, handles.graspingBodyPosition(1),handles.graspingBodyPosition(2),handles.graspingBodyPosition(3),...
    handles.graspingPosition(1) ,handles.graspingPosition(2),handles.graspingPosition(3),...
    handles.graspingHand,...
    handles.graspingDirection,...
    handles.catchedTheBall,...
    handles.catcherScoreByKeeper,...
    hardnessCalc(handles.graspingHand,handles.trackedLeftHand ...
    , handles.trackedRightHand ,  handles.graspingPosition)};
sheet = 1;
xlRange = sprintf('A%i' , order);
xlswrite(filename,data,sheet,xlRange)

imageData = getimage(handles.skeletonImage);
imwrite(imageData, sprintf('%s\\Datasets\\images\\ID%dNo%dimage.jpg' ,currentFolder , currentID , currentNo ));
set(gcf,'PaperPositionMode','auto')
%  saveas(handles.jointsMap , sprintf('%s\\Datasets\\plots images\\ID%dNo%dplot.png' ,currentFolder , currentID , currentNo ));
print(gcf ,sprintf('%s\\Datasets\\plots images\\ID%dNo%dplot' ,currentFolder , currentID , currentNo ) , '-dpng' , '-r0');

fignew = figure('Visible','off'); % Invisible figure
newAxes = copyobj(handles.jointsMap,fignew); % Copy the appropriate axes
set(newAxes,'Position',get(groot,'DefaultAxesPosition')); % The original position is copied too, so adjust it.
% set(fignew,'CreateFcn','set(gcbf,''Visible'',''on'')'); % Make it visible upon loading
set(fignew,'Visible' ,'on');
savefig(fignew,sprintf('%s\\Datasets\\plots\\ID%dNo%dplot.fig' ,currentFolder , currentID , currentNo ));
set(fignew,'Visible' ,'off');
delete(fignew);
% close(1);

order = order + 1;
save('order.mat','order');
No = currentNo + 1;
save('No.mat','No');

set(handles.catched , 'Enable' , 'off');
set(handles.notCatched , 'Enable' , 'off');
set(handles.catcherScore , 'Enable' , 'off');
set(handles.save , 'Enable' , 'off');

saveFile = matfile('ID.mat');
set(handles.ID, 'String' , num2str(saveFile.ID));
saveFile = matfile('No.mat');
set(handles.No, 'String' , num2str(saveFile.No));

axes(handles.jointsMap);
cla 


guidata(hObject, handles);




% --- Executes on selection change in bodyPosture.
function bodyPosture_Callback(hObject, eventdata, handles)
% hObject    handle to bodyPosture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns bodyPosture contents as cell array
%        contents{get(hObject,'Value')} returns selected item from bodyPosture
value = get(handles.bodyPosture , 'Value');
if value == 1
    handles.depthSrc.BodyPosture = 'Standing';
elseif value == 2
    handles.depthSrc.BodyPosture = 'Seated'; 
end
guidata(hObject, handles);
% --- Executes during object creation, after setting all properties.
function bodyPosture_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bodyPosture (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in depthMode.
function depthMode_Callback(hObject, eventdata, handles)
% hObject    handle to depthMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns depthMode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from depthMode
% handles.depthSrc.DepthMode = get(handles.depthMode , 'String') ;
value = get(handles.depthMode , 'Value');
if value == 1
    handles.depthSrc.DepthMode = 'Default';
elseif value == 2
    handles.depthSrc.DepthMode = 'Near'; 
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function depthMode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to depthMode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cameraAngleText_Callback(hObject, eventdata, handles)
% hObject    handle to cameraAngleText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cameraAngleText as text
%        str2double(get(hObject,'String')) returns contents of cameraAngleText as a double


% --- Executes during object creation, after setting all properties.
function cameraAngleText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cameraAngleText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function cameraAngleSlider_Callback(hObject, eventdata, handles)
% hObject    handle to cameraAngleSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

set(handles.cameraAngleText,'String',num2str(int8(get(handles.cameraAngleSlider , 'Value'))));
handles.depthSrc.CameraElevationAngle = int8(get(handles.cameraAngleSlider , 'Value'));


% --- Executes during object creation, after setting all properties.
function cameraAngleSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cameraAngleSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on button press in preview.
function preview_Callback(hObject, eventdata, handles)
% hObject    handle to preview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
preview(handles.depthVid)
 guidata(hObject, handles);


% --- Executes on button press in runButton.
function runButton_Callback(hObject, ~, handles)
% hObject    handle to runButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.catched , 'Enable' , 'off');
set(handles.notCatched , 'Enable' , 'off');
set(handles.catcherScore , 'Enable' , 'off');
set(handles.save , 'Enable' , 'off');

saveFile = matfile('ID.mat');
set(handles.ID, 'String' ,num2str(saveFile.ID));
saveFile = matfile('No.mat');
set(handles.No, 'string' ,saveFile.No);
if ishandle(1)
    close(1);
end
handles.hwInfo = imaqhwinfo('kinect');
mkdir('Datasets');
mkdir('Datasets','images');
mkdir('Datasets','plots');
mkdir('Datasets','plots images');

if size(handles.hwInfo.DeviceInfo,2) == 0
   KinectConnection = false  
else KinectConnection = true  
end

if KinectConnection
    %turns on the enables and visibles
    set(handles.textOnline , 'Enable' , 'on');
    set(handles.textOnline , 'Visible' , 'on');
    set(handles.textOffline , 'Enable' , 'off');
    set(handles.textOffline , 'Visible' , 'off');
    set(handles.cameraAngleX , 'Enable' , 'on');
    set(handles.cameraAngleX , 'Enable' , 'on');
    set(handles.bodyPosture , 'Enable' , 'on');
    set(handles.depthMode , 'Enable' , 'on');
    set(handles.cameraAngleText , 'Enable' , 'on');
    set(handles.cameraAngleSlider , 'Enable' , 'on');
    
    
    
    %Initializes the kinect Parameters
    
    
     handles.colorVid = videoinput('kinect',1)
     handles.depthVid = videoinput('kinect',2)
     
    triggerconfig([handles.colorVid handles.depthVid],'manual');
    handles.colorVid.FramesPerTrigger = 1;
    handles.depthVid.FramesPerTrigger = 1;
    
    handles.depthSrc = getselectedsource(handles.depthVid);
    
    handles.depthSrc.TrackingMode = 'Skeleton';
    
    % Sets the parameters
    set(handles.cameraAngleX , 'String' , num2str(handles.depthSrc.Accelerometer(1)*90));
    set(handles.cameraAngleText , 'String' , num2str(handles.depthSrc.CameraElevationAngle));
    set(handles.cameraAngleSlider , 'Value' , handles.depthSrc.CameraElevationAngle);
    pause(2);
    set(handles.checkThrow , 'Enable' , 'on');
    set(handles.preview , 'Enable' , 'on');
    guidata(hObject, handles);
       
else
    set(handles.textOnline , 'Visible' , 'off');
    set(handles.textOffline , 'Visible' , 'on');
    set(handles.textOnline , 'Enable' , 'off');
    set(handles.textOffline , 'Enable' , 'on');
end

% --- Executes on button press in checkThrow.
function checkThrow_Callback(hObject, eventdata, handles)
% hObject    handle to checkThrow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if strcmp(get(handles.checkThrow, 'String'),'Check Position')
    
    % Getting the initial Position of the body
    set(handles.checkDone, 'Visible', 'off');
    set(handles.throwDone, 'Visible', 'off');
    
    [ handles.bodyPosition ,handles.jointCoordinates, handles.trackedLeftHand, handles.trackedRightHand, handles.direction, handles.height] = ...
fetchingInitialData(handles.colorVid,handles.depthVid,handles.skeletonImage , get(handles.bodyPosture , 'Value'))

    set(handles.ATBPx, 'Visible', 'off');
    set(handles.ATBPy, 'Visible', 'off');
    set(handles.ATBPz, 'Visible', 'off'); 
    set(handles.ATTPx, 'Visible', 'off'); 
    set(handles.ATTPy, 'Visible', 'off');    
    set(handles.ATTPz, 'Visible', 'off');
    set(handles.ATGH, 'Visible', 'off');
    set(handles.ATDB, 'Visible', 'off');
    set(handles.throwDone, 'Visible', 'off');

     plot3(handles.jointCoordinates(:,3) , handles.jointCoordinates(:,1) ...
        , handles.jointCoordinates(:,2) , 'o' , 'Parent' , handles.jointsMap) ;
    skeletonViewer3d(handles.jointCoordinates,  handles.jointsMap , ':' , 'b');
    
    guidata(hObject, handles);
    set(handles.checkThrow, 'String','Throwing done');
    set(handles.checkThrow, 'BackgroundColor',[1 1 0]);
    set(handles.checkThrow, 'ForegroundColor',[1 0 0]);
    set(handles.checkDone, 'Visible', 'on');
    
    %Writing the datas in the site
    set(handles.BTBPx, 'Visible', 'on');
    set(handles.BTBPx, 'String',num2str(handles.bodyPosition(1)));
    set(handles.BTBPy, 'Visible', 'on');
    set(handles.BTBPy, 'String',num2str(handles.bodyPosition(2)));
    set(handles.BTBPz, 'Visible', 'on');
    set(handles.BTBPz, 'String',num2str(handles.bodyPosition(3)));
    
    set(handles.BTLHx, 'Visible', 'on');
    set(handles.BTLHx, 'String',num2str(handles.trackedLeftHand(1)));
    set(handles.BTLHy, 'Visible', 'on');
    set(handles.BTLHy, 'String',num2str(handles.trackedLeftHand(2)));
    set(handles.BTLHz, 'Visible', 'on');
    set(handles.BTLHz, 'String',num2str(handles.trackedLeftHand(3)));
    
    set(handles.BTRHx, 'Visible', 'on');
    set(handles.BTRHx, 'String',num2str(handles.trackedRightHand(1)));
    set(handles.BTRHy, 'Visible', 'on');
    set(handles.BTRHy, 'String',num2str(handles.trackedRightHand(2)));
    set(handles.BTRHz, 'Visible', 'on');
    set(handles.BTRHz, 'String',num2str(handles.trackedRightHand(3)));
    
    set(handles.BTDB, 'Visible', 'on');
    set(handles.BTDB, 'String',num2str(handles.direction));
    
    set(handles.BTH, 'Visible', 'on');
    set(handles.BTH, 'String',num2str(handles.height));
    
%      plot(handles.bodyPosition , 'Parent' , handles.jointsMap);
else
    set(handles.throwDone, 'Visible', 'off');
    [handles.graspingBodyPosition,handles.graspingJointCoordinates, handles.graspingPosition, handles.graspingHand, handles.graspingDirection] = ...
fetchingGraspData(handles.colorVid,handles.depthVid,handles.skeletonImage)
    guidata(hObject, handles);
    set(handles.throwDone, 'Visible', 'on');
    set(handles.catched , 'Enable' , 'on');
    set(handles.notCatched , 'Enable' , 'on');
    set(handles.checkThrow, 'String','Check Position');
    set(handles.checkThrow, 'BackgroundColor',[1 0 0]);
    set(handles.checkThrow, 'ForegroundColor',[1 1 1]);
    
    hold on
    plot3(handles.graspingJointCoordinates(:,3) , handles.graspingJointCoordinates(:,1) ...
        , handles.graspingJointCoordinates(:,2) , 'o' , 'Parent' , handles.jointsMap , ...
        'color' , 'r') ;    
    hold off
    skeletonViewer3d(handles.graspingJointCoordinates,  handles.jointsMap , '-' , 'r');
    %Writing Data in the site
    
    set(handles.ATBPx, 'Visible', 'on');
    set(handles.ATBPx, 'String',num2str(handles.graspingBodyPosition(1)));
    set(handles.ATBPy, 'Visible', 'on');
    set(handles.ATBPy, 'String',num2str(handles.graspingBodyPosition(2)));
    set(handles.ATBPz, 'Visible', 'on');
    set(handles.ATBPz, 'String',num2str(handles.graspingBodyPosition(3)));
    
    set(handles.ATTPx, 'Visible', 'on');
    set(handles.ATTPx, 'String',num2str(handles.graspingPosition(1)));
    set(handles.ATTPy, 'Visible', 'on');
    set(handles.ATTPy, 'String',num2str(handles.graspingPosition(2)));
    set(handles.ATTPz, 'Visible', 'on');
    set(handles.ATTPz, 'String',num2str(handles.graspingPosition(3)));
    
    set(handles.ATGH, 'Visible', 'on');
    set(handles.ATGH, 'String',handles.graspingHand);
    
    set(handles.ATDB, 'Visible', 'on');
    set(handles.ATDB, 'String',num2str(handles.graspingDirection));
    
    set(handles.calculatedHardnessText, 'Visible', 'on');
    set(handles.calculatedHardnessText, 'String' , num2str(hardnessCalc(handles.graspingHand,handles.trackedLeftHand ...
    , handles.trackedRightHand ,  handles.graspingPosition))) 
    
    set(handles.catched , 'value' , 0 );
    set(handles.notCatched , 'value' , 0 );
    
end
    



function ID_Callback(hObject, eventdata, handles)
% hObject    handle to ID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ID =  str2num(get(handles.ID, 'string'));
save('ID.mat','ID');
% Hints: get(hObject,'String') returns contents of ID as text
%        str2double(get(hObject,'String')) returns contents of ID as a double


% --- Executes during object creation, after setting all properties.
function ID_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function No_Callback(hObject, eventdata, handles)
% hObject    handle to No (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
No =  str2num(get(handles.No, 'string'));
save('No.mat','No');
% Hints: get(hObject,'String') returns contents of No as text
%        str2double(get(hObject,'String')) returns contents of No as a double


% --- Executes during object creation, after setting all properties.
function No_CreateFcn(hObject, eventdata, handles)
% hObject    handle to No (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

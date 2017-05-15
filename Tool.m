function varargout = Tool(varargin)
% TOOL MATLAB code for Tool.fig
%      TOOL, by itself, creates a new TOOL or raises the existing
%      singleton*.
%
%      H = TOOL returns the handle to a new TOOL or the handle to
%      the existing singleton*.
%
%      TOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TOOL.M with the given input arguments.
%
%      TOOL('Property','Value',...) creates a new TOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Tool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Tool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Tool

% Last Modified by GUIDE v2.5 13-May-2017 18:35:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Tool_OpeningFcn, ...
                   'gui_OutputFcn',  @Tool_OutputFcn, ...
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


% --- Executes just before Tool is made visible.
function Tool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Tool (see VARARGIN)

% Choose default command line output for Tool
handles.output = hObject;
       
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Tool wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Tool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
% --- Use this button, we can open the image to label
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image_save;     % route to save the opened image 
global filename_save;  % name to save the opened image 
global imageSave_route;% folder to save the labeled images
global filename_number; % number to save the order
global h_showImage;
global Data_3d   % used to define 3d matrix
global height_set;
global width_set;
if exist('Data_3d.mat','file')==2
    load Data_3d;
end
[filename,pathname]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.tif';'*.jpg'},'????');
%use function 'uigetfile' to open a dialog , then choose a file/image
%ex, if we click the image '000160.jpg' in folder '157_312'
%then pathname ='C:\Users\nfh21\Desktop\157_312\'
%     filename ='000160.jpg'
if isequal(filename,0)||isequal(pathname,0)
    errordlg('Choose nothing','Error');%
    return;
else
    image_original=[pathname,filename];%image_original is the whole strings
                                       % of the image's route
                                       
    %set all the editText to 0
    set(handles.Name_image,'String',filename);
    set(handles.edit_joint1, 'String', 0);
    set(handles.edit_joint2, 'String', 0);
    set(handles.edit_joint3, 'String', 0);
    set(handles.edit_joint4, 'String', 0);
    set(handles.edit_joint5, 'String', 0);
    set(handles.edit_joint6, 'String', 0);
    set(handles.edit_joint7, 'String', 0);
    set(handles.edit_joint8, 'String', 0);
    set(handles.edit_joint9, 'String', 0);
    set(handles.edit_joint10, 'String', 0);
    set(handles.edit_joint11, 'String', 0);
    set(handles.edit_joint12, 'String', 0);
    set(handles.edit_joint13, 'String', 0);
    set(handles.edit_joint14, 'String', 0);
    set(handles.edit_lieDirection, 'String', 0);
    for i=1:length(filename)
        if filename(i)~=0
            filename_number=str2num(filename(i:6));
            break;
        end
    end
    %    display(filename_number);    % testing
    %    display(image_original);          
    %    display([pathname,filename]);
    %    display(pathname);
    %    display(filename);
    
    filename_save=filename;
    image_save=image_original;
    image=imread(image_original);
    imageSave_route=strcat(pathname(1:length(pathname)-1),'_Labeled');
    if ~exist(imageSave_route)
        mkdir(imageSave_route)      % folder does not exist, create one
    end
    %set(handles.axes1,'HandleVisibility','ON');%
    %handles = guihandles(gcf);
    %axes(handles.axes1);%
    
    %To see images well, always make width<height
    %Sometimes, the image will show with head down,foot up,
    %Then we use button4 to rotate it
    if size(image,2)>size(image,1)
        image=imrotate(image,-90);
        imwrite(image,image_save)
    end
    height=size(image,1); % size to get height x width
    width=size(image,2);
    %show the size of original image
    Size_original=string(width)+'x'+string(height);
    set(handles.Size_original, 'String', Size_original);

    %height_set * 1.563 = height_save,
    if max(width,height)>690        %the height of my laptop is 1080, here set threshold is 690
        G=gcd(width,height);    %gcd is used to get the greatest common divisor
        width_1=width/G;
        height_1=height/G;
            display(G);
        %      G_=1:G;                      %G_ is vector of 1 to G
        %      G_divisor=G_(mod(G,G_)==0);   %G_ is vector of all divisors of G
        for i=1:G
            width_save=width_1*i;
            height_save=height_1*i;
            if max(width_save,height_save)>1000
                width_save=width_1*(i-1);
                height_save=height_1*(i-1);
                display(width_save);
                display(height_save);
                break;
            end
        end
        height_set=height_save/1.563;
        width_set=width_save/1.563;
    else
        height_set=height;
        width_set=width;
    end
    
    display(width_set);
    display(height_set);
    
    h=figure('Name',filename_save,'NumberTitle','off');  %set title of figures 
    h_showImage=imshow(image,'border','tight','initialmagnification','fit');%make the figure full fill the screen

    %set (gcf,'Position',[0,0,415,553]);%width x height:415x553,then the new saved image : 648x864,  times with 3 =1944x2592
    %set (gcf,'Position',[0,0,358,640]);%the new saved image : 560 x 1000, times 1.6 = 896 x 1600
    set (gcf,'Position',[0,0,width_set,height_set]);
    axis normal;%
    
    handles.img=image;   %
    guidata(hObject,handles); %save the changed variables?
    title('Label Tool');
    
    A=zeros(14,3);   %A: put the coordinations of 14 parts
    A2=zeros(2,3);   %A2: put the information of direction and body side
    
    %use ' for loop'+'ginput' to get x,y, and draw the line
    %here the order of click should follow the instruction
    if ishghandle(h)
        for i=1:14
            [x,y,ginput_flag]=ginput(1);   
            A(i,1:2)=[x,y];
            axis on;
            hold on;
            plot(x,y,'square', 'MarkerSize', 5, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'g');
            % to solve the problem, close figure without error message?but
            % it does not work
            %                 if ginput_flag~=1
            %                     axis off;
            %                     close(filename_save);
            %                     axis off;
            %                     break;
            %                 end
        end
        
        %use plot to draw the lines,total number 11
        plot([A(1,1),A(2,1)],[A(1,2),A(2,2)],'r','LineWidth',1);
        plot([A(2,1),A(3,1)],[A(2,2),A(3,2)],'y','LineWidth',1);
        plot([A(3,1),A(4,1)],[A(3,2),A(4,2)],'b','LineWidth',1);
        plot([A(4,1),A(5,1)],[A(4,2),A(5,2)],'y','LineWidth',1);
        plot([A(5,1),A(6,1)],[A(5,2),A(6,2)],'r','LineWidth',1);
        plot([A(7,1),A(8,1)],[A(7,2),A(8,2)],'r','LineWidth',1);
        plot([A(8,1),A(9,1)],[A(8,2),A(9,2)],'y','LineWidth',1);
        plot([A(9,1),A(10,1)],[A(9,2),A(10,2)],'b','LineWidth',1);
        plot([A(10,1),A(11,1)],[A(10,2),A(11,2)],'y','LineWidth',1);
        plot([A(11,1),A(12,1)],[A(11,2),A(12,2)],'r','LineWidth',1);
        plot([A(13,1),A(14,1)],[A(13,2),A(14,2)],'b','LineWidth',1);
    end
%     filename_1={filename};     %testing
%     celldisp(filename_1);
      Info=[A',A2'];             %Info={filename,A',A2};
%     %disp(Info);
    
    Data_3d(1:3,1:16,filename_number)=Info(1:3,1:16);
    %display(Data_3d);
    save('Data_3d.mat','Data_3d');
    %disp(filename_1);
    %display(xlRange);
end


% --- Executes on button press in pushbutton2.
% --- Use this button, we can save the labeled images
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%saveas(image,'image0_feature.jpeg')
global h_showImage;            %name to save the processed images
global filename_save;
global imageSave_route;
route=strcat(imageSave_route,'\',filename_save);
saveas(h_showImage,route);
image =imread(route);      %here, image is reading the new saved image
height_save=size(image,1); % size to get height x width
width_save=size(image,2);
Size_save=string(width_save)+'x'+string(height_save);
set(handles.Size_save, 'String', Size_save);
display(width_save);       %testing
display(height_save);
% h2=imread(route);
% h_final=imresize(h2,3);   %resize the image
% imwrite(h_final,route);
%print(image,'-djpeg','E:\image0_feature.jpeg')

% --- Executes on button press in pushbutton3.
% --- Use this button, we can preprocess the images
% --- in fact, the function is used to change names of all images 
% --- to new names, like'000000.jpg,000001.jpg,000002.jpg,...'
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global Data_3d;
[filename_1,pathname_1]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.tif';'*.jpg'},'????');
if isequal(filename_1,0)||isequal(pathname_1,0)
    errordlg('Choose nothing','Error');%
    return;
else
    imagePreprocess_route=pathname_1(1:length(pathname_1)-1);
    imagePreprocess_set=imageSet(imagePreprocess_route);
    display(imagePreprocess_route);
    for i=1:imagePreprocess_set.Count
        newname='\000000.jpg';
        i_str=int2str(i);
        len=length(i_str);
        if len==1
            newname(7)=i_str;
        else newname(8-len:7)=i_str;
        end
        imagePreprocess_newname=strcat(imagePreprocess_route,newname);
        imagePreprocess_oldname=char(imagePreprocess_set.ImageLocation(i));
        name_compare=strcmp(imagePreprocess_oldname,imagePreprocess_newname);
        % use strcmp to compare 2 strings, different->0,same->1
        if name_compare==0
            movefile(imagePreprocess_oldname,imagePreprocess_newname);
        end
        %display(imagePreprocess_newname);  %test
    end
end
%Data_3d=zeros(3,16,imagePreprocess_set.Count);

% --- Executes on button press in pushbutton4.
% --- Use this button, we can rotate the images with 180 degrees
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image_save;
global filename_save;
image=imread(image_save);%
image=imrotate(image,180);
imwrite(image,image_save);
close(filename_save);


% --- Executes on button press in pushbutton5.
% --- Use this button, we can checked all the labeled data
% --- By draw line with Data_3d, to see the new images
% --- It can also be used to save the labeled images(with lines)
% --- automatically.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
global height_set;
global width_set;
if exist('Data_3d.mat','file')==2
    %load Data_labeled_colorful_3d;
    load Data_3d;
    %Data_3d=Data_labeled_colorful_3d;
    [filename_check,pathname_check]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.tif';'*.jpg'},'????');
    if isequal(filename_check,0)||isequal(pathname_check,0)
        errordlg('Choose nothing','Error');%
        return;
    else
        imageCheck_route=pathname_check(1:length(pathname_check)-1); % -1 to delete '\'
        imageCheckSave_route=strcat(imageCheck_route,'_Checked');
        imageCheck_set=imageSet(imageCheck_route);
        if ~exist(imageCheckSave_route)
            mkdir(imageCheckSave_route);    % folder does not exist, create one
        end
        display(imageCheck_route);
        for i=1:imageCheck_set.Count
            if i>size(Data_3d,3)            % avoid the number of images > data
                break;
            end 
%             Y=1;                          %testing
%             display(Y);
            if isequal(Data_3d(1:3,1:16,i),zeros(3,16))==0
%                 Y=2;
%                 display(Y);
                imageToCheck_route=char(imageCheck_set.ImageLocation(i));
                figure;
                image=imread(imageToCheck_route);
                h=imshow(image,'border','tight','initialmagnification','fit');%make the figure full fill the screen
                %set (gcf,'Position',[0,0,358,640]);
                if isempty(width_set)
                    set (gcf,'Position',[0,0,358,640]);
                    yb=1;
                    display(yb);
                else
                    set (gcf,'Position',[0,0,width_set,height_set]);
                    yb=11;
                    display(yb);
                end
                axis normal;
                title('Label Tool');
                hold on;
                
                DataDot = Data_3d(1:3,1:16,i);
                for j=1:14
                    plot(DataDot(1,j),DataDot(2,j),'square', 'MarkerSize', 5, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'g');
                    hold on;
                end
                plot([DataDot(1,1),DataDot(1,2)],[DataDot(2,1),DataDot(2,2)],'r','LineWidth',1);hold on;
                plot([DataDot(1,2),DataDot(1,3)],[DataDot(2,2),DataDot(2,3)],'y','LineWidth',1);hold on;
                plot([DataDot(1,3),DataDot(1,4)],[DataDot(2,3),DataDot(2,4)],'b','LineWidth',1);hold on;
                plot([DataDot(1,4),DataDot(1,5)],[DataDot(2,4),DataDot(2,5)],'y','LineWidth',1);hold on;
                plot([DataDot(1,5),DataDot(1,6)],[DataDot(2,5),DataDot(2,6)],'r','LineWidth',1);hold on;
                plot([DataDot(1,7),DataDot(1,8)],[DataDot(2,7),DataDot(2,8)],'r','LineWidth',1);hold on;
                plot([DataDot(1,8),DataDot(1,9)],[DataDot(2,8),DataDot(2,9)],'y','LineWidth',1);hold on;
                plot([DataDot(1,9),DataDot(1,10)],[DataDot(2,9),DataDot(2,10)],'b','LineWidth',1);hold on;
                plot([DataDot(1,10),DataDot(1,11)],[DataDot(2,10),DataDot(2,11)],'y','LineWidth',1);hold on;
                plot([DataDot(1,11),DataDot(1,12)],[DataDot(2,11),DataDot(2,12)],'r','LineWidth',1);hold on;
                plot([DataDot(1,13),DataDot(1,14)],[DataDot(2,13),DataDot(2,14)],'b','LineWidth',1);hold on;
                
                l=length(imageToCheck_route);
                image_eachname=imageToCheck_route(l-9:l);
                route=strcat(imageCheckSave_route,'\',image_eachname);
                saveas(h,route);
                display(imageCheckSave_route);
            end
        end
    end
end



function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit1 and none of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
% input_1=1;
% display(input_1);


% --- Executes on key press with focus on edit1 and none of its controls.
function edit1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



function edit_joint1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_joint1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_joint1 as text
%        str2double(get(hObject,'String')) returns contents of edit_joint1 as a double
global filename_number;
visiblity1 = str2num(get(hObject,'String'));
if (isempty(visiblity1))
    set(hObject,'String','0')
end
guidata(hObject, handles);
if exist('Data_3d.mat','file')==2
    if visiblity1==1
        load Data_3d;
        Data_3d(3,1,filename_number)=1;
        save('Data_3d.mat','Data_3d');
    end
end


% --- Executes during object creation, after setting all properties.
function edit_joint1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_joint1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_joint2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_joint2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_joint2 as text
%        str2double(get(hObject,'String')) returns contents of edit_joint2 as a double
global filename_number;
visiblity2 = str2num(get(hObject,'String'));
if (isempty(visiblity2))
    set(hObject,'String','0')
end
guidata(hObject, handles);
if exist('Data_3d.mat','file')==2
    if visiblity2==1
        load Data_3d;
        Data_3d(3,2,filename_number)=1;
        save('Data_3d.mat','Data_3d');
    end
end


% --- Executes during object creation, after setting all properties.
function edit_joint2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_joint2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_joint3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_joint3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_joint3 as text
%        str2double(get(hObject,'String')) returns contents of edit_joint3 as a double
global filename_number;
visiblity3 = str2num(get(hObject,'String'));
if (isempty(visiblity3))
    set(hObject,'String','0')
end
guidata(hObject, handles);
if exist('Data_3d.mat','file')==2
    if visiblity3==1
        load Data_3d;
        Data_3d(3,3,filename_number)=1;
        save('Data_3d.mat','Data_3d')
    end
end


% --- Executes during object creation, after setting all properties.
function edit_joint3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_joint3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_joint4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_joint4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_joint4 as text
%        str2double(get(hObject,'String')) returns contents of edit_joint4 as a double
global filename_number;
visiblity4 = str2num(get(hObject,'String'));
if (isempty(visiblity4))
    set(hObject,'String','0')
end
guidata(hObject, handles);
if exist('Data_3d.mat','file')==2
    if visiblity4==1
        load Data_3d;
        Data_3d(3,4,filename_number)=1;
        save('Data_3d.mat','Data_3d')
    end
end


% --- Executes during object creation, after setting all properties.
function edit_joint4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_joint4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_joint5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_joint5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_joint5 as text
%        str2double(get(hObject,'String')) returns contents of edit_joint5 as a double
global filename_number;
visiblity5 = str2num(get(hObject,'String'));
if (isempty(visiblity5))
    set(hObject,'String','0')
end
guidata(hObject, handles);
if exist('Data_3d.mat','file')==2
    if visiblity5==1
        load Data_3d;
        Data_3d(3,5,filename_number)=1;
        save('Data_3d.mat','Data_3d')
    end
end


% --- Executes during object creation, after setting all properties.
function edit_joint5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_joint5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_joint6_Callback(hObject, eventdata, handles)
% hObject    handle to edit_joint6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_joint6 as text
%        str2double(get(hObject,'String')) returns contents of edit_joint6 as a double
global filename_number;
visiblity6 = str2num(get(hObject,'String'));
if (isempty(visiblity6))
    set(hObject,'String','0')
end
guidata(hObject, handles);
if exist('Data_3d.mat','file')==2
    if visiblity6==1
        load Data_3d;
        Data_3d(3,6,filename_number)=1;
        save('Data_3d.mat','Data_3d')
    end
end


% --- Executes during object creation, after setting all properties.
function edit_joint6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_joint6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_joint7_Callback(hObject, eventdata, handles)
% hObject    handle to edit_joint7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_joint7 as text
%        str2double(get(hObject,'String')) returns contents of edit_joint7 as a double
global filename_number;
visiblity7 = str2num(get(hObject,'String'));
if (isempty(visiblity7))
    set(hObject,'String','0')
end
guidata(hObject, handles);
if exist('Data_3d.mat','file')==2
    if visiblity7==1
        load Data_3d;
        Data_3d(3,7,filename_number)=1;
        save('Data_3d.mat','Data_3d')
    end
end


% --- Executes during object creation, after setting all properties.
function edit_joint7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_joint7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_joint8_Callback(hObject, eventdata, handles)
% hObject    handle to edit_joint8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_joint8 as text
%        str2double(get(hObject,'String')) returns contents of edit_joint8 as a double
global filename_number;
visiblity8 = str2num(get(hObject,'String'));
if (isempty(visiblity8))
    set(hObject,'String','0')
end
guidata(hObject, handles);
if exist('Data_3d.mat','file')==2
    if visiblity8==1
        load Data_3d;
        Data_3d(3,8,filename_number)=1;
        save('Data_3d.mat','Data_3d')
    end
end


% --- Executes during object creation, after setting all properties.
function edit_joint8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_joint8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_joint9_Callback(hObject, eventdata, handles)
% hObject    handle to edit_joint9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_joint9 as text
%        str2double(get(hObject,'String')) returns contents of edit_joint9 as a double
global filename_number;
visiblity9 = str2num(get(hObject,'String'));
if (isempty(visiblity9))
    set(hObject,'String','0')
end
guidata(hObject, handles);
if exist('Data_3d.mat','file')==2
    if visiblity9==1
        load Data_3d;
        Data_3d(3,9,filename_number)=1;
        save('Data_3d.mat','Data_3d')
    end
end


% --- Executes during object creation, after setting all properties.
function edit_joint9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_joint9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_joint10_Callback(hObject, eventdata, handles)
% hObject    handle to edit_joint10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_joint10 as text
%        str2double(get(hObject,'String')) returns contents of edit_joint10 as a double
global filename_number;
visiblity10 = str2num(get(hObject,'String'));
if (isempty(visiblity10))
    set(hObject,'String','0')
end
guidata(hObject, handles);
if exist('Data_3d.mat','file')==2
    if visiblity10==1
        load Data_3d;
        Data_3d(3,10,filename_number)=1;
        save('Data_3d.mat','Data_3d')
    end
end


% --- Executes during object creation, after setting all properties.
function edit_joint10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_joint10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_joint11_Callback(hObject, eventdata, handles)
% hObject    handle to edit_joint11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_joint11 as text
%        str2double(get(hObject,'String')) returns contents of edit_joint11 as a double
global filename_number;
visiblity11 = str2num(get(hObject,'String'));
if (isempty(visiblity11))
    set(hObject,'String','0')
end
guidata(hObject, handles);
if exist('Data_3d.mat','file')==2
    if visiblity11==1
        load Data_3d;
        Data_3d(3,11,filename_number)=1;
        save('Data_3d.mat','Data_3d')
    end
end


% --- Executes during object creation, after setting all properties.
function edit_joint11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_joint11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_joint12_Callback(hObject, eventdata, handles)
% hObject    handle to edit_joint12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_joint12 as text
%        str2double(get(hObject,'String')) returns contents of edit_joint12 as a double
global filename_number;
visiblity12 = str2num(get(hObject,'String'));
if (isempty(visiblity12))
    set(hObject,'String','0')
end
guidata(hObject, handles);
if exist('Data_3d.mat','file')==2
    if visiblity12==1
        load Data_3d;
        Data_3d(3,12,filename_number)=1;
        save('Data_3d.mat','Data_3d')
    end
end


% --- Executes during object creation, after setting all properties.
function edit_joint12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_joint12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_joint13_Callback(hObject, eventdata, handles)
% hObject    handle to edit_joint13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_joint13 as text
%        str2double(get(hObject,'String')) returns contents of edit_joint13 as a double
global filename_number;
visiblity13 = str2num(get(hObject,'String'));
if (isempty(visiblity13))
    set(hObject,'String','0')
end
guidata(hObject, handles);
if exist('Data_3d.mat','file')==2
    if visiblity13==1
        load Data_3d;
        Data_3d(3,13,filename_number)=1;
        save('Data_3d.mat','Data_3d')
    end
end


% --- Executes during object creation, after setting all properties.
function edit_joint13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_joint13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_joint14_Callback(hObject, eventdata, handles)
% hObject    handle to edit_joint14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_joint14 as text
%        str2double(get(hObject,'String')) returns contents of edit_joint14 as a double
global filename_number;
visiblity14 = str2num(get(hObject,'String'));
if (isempty(visiblity14))
    set(hObject,'String','0')
end
guidata(hObject, handles);
if exist('Data_3d.mat','file')==2
    if visiblity14==1
        load Data_3d;
        Data_3d(3,14,filename_number)=1;
        save('Data_3d.mat','Data_3d')
    end
end


% --- Executes during object creation, after setting all properties.
function edit_joint14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_joint14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_lieDirection_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lieDirection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lieDirection as text
%        str2double(get(hObject,'String')) returns contents of edit_lieDirection as a double
global filename_number;
lieDirection = str2num(get(hObject,'String'));
if (isempty(lieDirection))
    set(hObject,'String','0')
end
guidata(hObject, handles);
if exist('Data_3d.mat','file')==2
    load Data_3d;
    if lieDirection==1
        Data_3d(3,16,filename_number)=1;
        save('Data_3d.mat','Data_3d')
    end
    if lieDirection==2
        Data_3d(3,16,filename_number)=2;
        save('Data_3d.mat','Data_3d')
    end
    
end


% --- Executes during object creation, after setting all properties.
function edit_lieDirection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lieDirection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%% Correspondence Calculation & 3D Reconstructoin %%%%
%%%% In this code the Hamiltonina Patterns are created %%%%
%%%% Then, the correspondences are found using the scheme explained int the
%%%% paper. At last 3D reconstruction is done using triangulation. 
clear all
clc

margin=20; %%% threshold for clustering. 

%%% Reading the Patterns 
opt.read='C:\Users\Kavir\Desktop\demo\1\Final_Project_Code\read\';

%%% Creating the mask %%%
I1=[];
I2=[];

width=2560;
height=1600;

H=1600;
W=2560;
d=5;

M1=imread([opt.read,'capture_1.bmp']);
M2=imread([opt.read,'capture_2.bmp']);
Mask=imbinarize(M1-M2);

%% Creating the Hamlitonian Patterns %%
P=find_the_cycle(H,W,d); 
%%
%%% Reading Vertical & Horizontal Patterns Patterns %%%%%%%%%
for i=1:2
    for j=1:5
        switch i
            
            case 1
                
                m1=imread([opt.read,'camera',num2str(i),num2str(j),'.bmp']);
                I1(:,:,j)=m1.*uint8(Mask);
                
            case 2
                
                m1=imread([opt.read,'camera',num2str(i),num2str(j),'.bmp']);
                I2(:,:,j)=m1.*uint8(Mask);
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%% Finding the points inside the mask %%%%

[r,c]=find(Mask);
points=[r,c];

D1=NaN(2048,2448); %%% For columns
D2=NaN(2048,2448); %%% For rows

%%%% 0:black 1:white 2:between %%%
%% Finding the columns in projector space %%%%
for k=1:size(points,1)
    
    p=points(k,:);
    
    q=p(1);
    e=p(2);
    
    t=I1(q,e,:);

    code_point=ones(1,5)*2;
    [Y,I]=sort(t);
    
    code_point(I(5))=1;
    code_point(I(1))=0;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Clustering the intensities in the projected patterns %%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    cluster_white=[Y(5)];
    cluster_black=[Y(1)];
    cluster_between=[];
    %%% Clustering the black pixels %%%
    if(t(I(2))-t(I(1))<=margin)
        code_point(I(2))=0;
        cluster_black=[cluster_black,t(I(2))];
    end
    
    if(t(I(3))-t(I(1))<=margin)
        code_point(I(3))=0;
        cluster_black=[cluster_black,t(I(3))];
    end
        
        
    if(t(I(4))-t(I(1))<=margin)
        code_point(I(4))=0;
        cluster_black=[cluster_black,t(I(4))];
    end
    
    %%%% Clustering the white pixels %%%
    if(t(I(5))-t(I(2))<=margin)
        code_point(I(2))=1;
        cluster_white=[cluster_white,t(I(2))];
    end
    
    
    if(t(I(5))-t(I(3))<=margin)
        code_point(I(3))=1;
        cluster_white=[cluster_white,t(I(3))];
    end
    
    
    if(t(I(5))-t(I(4))<=margin)
        code_point(I(4))=1;
        cluster_white=[cluster_white,t(I(4))];
    end
    
    
    %%% If valid point, calculate the column index in the projector space
    %%% A valid point should have one middle intensity. 
    
    if(size((find(code_point==2)),2)==1)
        
        
        
       
        
        cluster_between=t(find(code_point==2));
        Imin=mean(cluster_black);
        Imax=mean(cluster_white);
        %%%% calculate the interval in the projector space %%%
        
        [interval_num,increase]=find_interval(p,code_point);
        
        if(interval_num~=-1)
            
            kk=(I1(q,e,find(code_point==2))-Imin)/(Imax-Imin);
            
            switch increase
                
                case 1
                    c=(interval_num-1)*85+floor(85*kk)+5;
                case 0
                    c=(interval_num-1)*85+floor(85*(1-kk))+5;
                    
                    
                    
            end
            
           
            
            D1(q,e)=c;
            
        end
    end
    
    
        
    
    
    
end
    
    
 %% Finding the rows in projector space %%%%
    
%% Finding the columns in projector space %%%%
for k=1:size(points,1)
    
    p=points(k,:);
    q=p(1);
    e=p(2);
    t=I2(q,e,:);

    code_point=ones(1,5)*2;
    [Y,I]=sort(t);
    
    code_point(I(5))=1;
    code_point(I(1))=0;
    
    cluster_white=[Y(5)];
    cluster_black=[Y(1)];
    cluster_between=[];
    
    if(t(I(2))-t(I(1))<=margin)
        code_point(I(2))=0;
        cluster_black=[cluster_black,t(I(2))];
    end
    
    if(t(I(3))-t(I(1))<=margin)
        code_point(I(3))=0;
        cluster_black=[cluster_black,t(I(3))];
    end
        
        
    if(t(I(4))-t(I(1))<=margin)
        code_point(I(4))=0;
        cluster_black=[cluster_black,t(I(4))];
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%
    if(t(I(5))-t(I(2))<=margin)
        code_point(I(2))=1;
        cluster_white=[cluster_white,t(I(2))];
    end
    
    
    if(t(I(5))-t(I(3))<=margin)
        code_point(I(3))=1;
        cluster_white=[cluster_white,t(I(3))];
    end
    
    
    if(t(I(5))-t(I(4))<=margin)
        code_point(I(4))=1;
        cluster_white=[cluster_white,t(I(4))];
    end
    
    
    %%% If valid point, calculate the column index in the projector space
    
    
    if(size((find(code_point==2)),2)==1)
       
        cluster_between=t(find(code_point==2));
        Imin=mean(cluster_black);
        Imax=mean(cluster_white);
        %%%% calculate the interval in the projector space %%%
        
        [interval_num,increase]=find_interval(p,code_point);
        
        if(interval_num~=-1)
            kk=(I2(q,e,find(code_point==2))-Imin)/(Imax-Imin);
            
            switch increase
                
                case 1
                    c=(interval_num-1)*53+floor(53*kk)+5;
                case 0
                    c=(interval_num-1)*53+floor(53*(1-kk))+5;
                    
                    
                    
            end
            
           
            
            D2(q,e)=c;
            
        end
    end
    
    
    
end    
    
%% Deleting invalid points %%% 

D1(~Mask) = NaN;
D2(~Mask) = NaN;
D1(D1 > width) = NaN;
D2(D2 > height) = NaN;
D1(D1 < 1) = NaN;
D2(D2 < 1) = NaN;

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find pixel correspondence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mapCamToProj1 = D1;
mapCamToProj2 = D2;
idx = find(~isnan(mapCamToProj1) & ~isnan(mapCamToProj2));
[row,col] = ind2sub(size(mapCamToProj1),idx);
num_matches = length(row);

% xy are coordinates in camera, uv are coordinates in projector;
% origin of coordinate systems are at top left;
% x and u access the columns (right from the origin);
% y and v access the rows (down from the origin).
xy_cam = [col row];
uv_pro = zeros(size(xy_cam));
for i=1:num_matches
   c_cam = xy_cam(i,1);     % get column from camera
   r_cam = xy_cam(i,2);     % get row from camera
   uv_pro(i,1) = mapCamToProj1(r_cam,c_cam);    % col index at D{1,:}
   uv_pro(i,2) = mapCamToProj2(r_cam,c_cam);    % row index at D{2,:}
end

%% Start

addpath(genpath('_drivers'));
addpath(genpath('_externalcode'));

% Folder names
param.saveFolder = datestr(now, 'yyyy.mm.dd_HH.MM.SS');
param.saveFolder = ['_output/',param.saveFolder,'/'];
mkdir(param.saveFolder);
param.modelFile = [param.saveFolder,'model3d']; % output 3D reconstructed model

%% 3D Reconstruction

disp('Performing 3D reconstruction...');
% Can downsample points for faster 3D reconstruction

%%% loading the calibrated projector and camera
projector=(load('projector.mat'));
camera=(load('camera.mat'));

projector=projector.projector;
camera=camera.camera;

image01_points = uv_pro(1:1:end,:);
image02_points = xy_cam(1:1:end,:);
points3d = reconstruct3dPts(image01_points', image02_points', projector, camera);
param.modelFile = [param.saveFolder,'model3d']; % output 3D reconstructed model
save3D(points3d,param.modelFile,'ply','cloud',false); %Delaunay triangulation creates HUGE file size.







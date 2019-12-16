%%%% Finding the Correspondence for the new suggestion %%%%

clear all
clc

%opt.read='C:\Users\Kavir\Desktop\demo\1\Final_Project_Code\read1\';

%% Creating the mask %%%
I1=[];
I2=[];

width=2560;
height=1600;

%%%Creating the Mask
M1=imread('capture_1.bmp');
M2=imread('capture_2.bmp');
Mask=imbinarize(M1-M2);

%% Reading the Captured Images 

I1=imread('camera_new1.bmp');
I2=imread('camera_new2.bmp');

%% Calculating the fft of the captured images 


F1=fft2(double(I1));
F1=fftshift(F1);
F1=abs(F1);
%%%% plotting the middle column
m=F1(:,1000)';
x=1:1:size(m,2);
plot(x,m)


%% Calculating the fft of the captured images 
F1=fft2(double(I2));
F1=fftshift(F1);
F1=abs(F1);
    
f1=F1(1,500:700);
f2=F1(1,700:900);
f3=F1(1,900:1100);
f4=F1(1,1100:1300);
f5=F1(1,1300:1500);

N1=zeros(size(I1,1),size(I1,2));
N2=zeros(size(I1,1),size(I1,2));
N3=zeros(size(I1,1),size(I1,2));
N4=zeros(size(I1,1),size(I1,2));
N5=zeros(size(I1,1),size(I1,2));

N1(:,500:700)=repmat(f1,size(I1,1),1);
N2(:,700:900)=repmat(f2,size(I1,1),1);
N3(:,900:1100)=repmat(f3,size(I1,1),1);
N4(:,1100:1300)=repmat(f4,size(I1,1),1);
N5(:,1300:1500)=repmat(f5,size(I1,1),1);

N1=abs(ifftshift(ifft2((N1))));
N2=abs(ifftshift(ifft2((N2))));
N3=abs(ifftshift(ifft2((N3))));
N4=abs(ifftshift(ifft2((N4))));
N5=abs(ifftshift(ifft2((N5))));


figure;
imagesc(N1)
figure;
imagesc(N2)
figure;
imagesc(N3)
figure;
imagesc(N4)
figure;
imagesc(N5)












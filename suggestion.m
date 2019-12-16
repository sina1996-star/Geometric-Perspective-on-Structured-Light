%%% The suggestion %%%%
%%%% The horizontal pattern %%%%

I1=[];
I2=[];

W =2550;
H =1590;

for i=1:2
    for j=1:5
        switch i
            
            case 1
                
                m1=imread(['pattern_',num2str(i),num2str(j),'.png']);
                I1(:,:,j)=m1;
                
            case 2
                
                m1=imread(['pattern_',num2str(i),num2str(j),'.png']);
                I2(:,:,j)=m1;
        end
    end
end

new1=zeros(H,W);
new2=zeros(H,W);

%%% Creating the five horizontal sine images %%% 


p(:,:,1)=sine_image(H,W,20,0);
p(:,:,2)=sine_image(H,W,40,0);
p(:,:,3)=sine_image(H,W,60,0);
p(:,:,4)=sine_image(H,W,80,0);
p(:,:,5)=sine_image(H,W,100,0);
%%% Creating the proposed pattern using frequency modulation 
for q=1:5;
    
    new1=p(:,:,q).*I1(:,:,q)+new1;
    
end

imwrite(uint8(new1),'new_1.png');
figure;
imshow(uint8(new1));
%%% Creating the five vertical sine images %%%

W =2550;
H =1590; 

p(:,:,1)=sine_image(H,W,20,1);
p(:,:,2)=sine_image(H,W,40,1);
p(:,:,3)=sine_image(H,W,60,1);
p(:,:,4)=sine_image(H,W,80,1);
p(:,:,5)=sine_image(H,W,100,1);

%%% Creating the proposed pattern using frequency modulation 

for q=1:5;
    
    new2=p(:,:,q).*I2(:,:,q)+new2;
    
end



imwrite(uint8(new2),'new_2.png');
figure;
imshow(uint8(new2))

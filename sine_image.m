function img1=sine_image(H,W,fs,mode)

%%% Creating sine images with a particualr frequency 
switch mode
    
    case 0 %%% horizontal bars
        
        
        img1 = zeros(H,W);
        x=0:0.001:(H-1)*0.001;
        y=sin(2*fs*pi*x)+1;
        %y1=round(y/8*255);
        
        for i=1:W
            img1(:,i)=(y/8)';
            
        end
        
        
        
        
    case 1 %%% vertical bars
        
        img1 = zeros(H,W);
        x=0:0.001:(W-1)*0.001;
        y=sin(2*fs*pi*x)+1;
        %y1=round(y/2*255);
        
        for i=1:H
            img1(i,:)=(y/8);
        end
        
       
end

end
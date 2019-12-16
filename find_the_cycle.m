%%% finding a Hamiltonian cycle in a hypercube and creating the Hamiltonian Patterns %%%

function P=find_the_cycle(H,W,d)

%%% Creating a Hypercube
A=hypercube(d);

G=graph(A);
figure;
plot(G);
axis square

%%% Deleting the origin and the diagonally opposit vertex.
A(1,:)=[];
A(end,:)=[];
A(:,1)=[];
A(:,end)=[];
G=graph(A);

%%% Finding a Hamiltonian Cycle in the graph
P=hamiltonian(double(A),1,1)
digits = zeros(size(P,2),d);
for i=1:size(P,2)
    M=dec2bin(P(i),d);
    digits(i,:)=num2str(M)-'0';
end

P=zeros(d,size(P,2));
for i=1:d
    P(i,:)=(digits(:,i))';
end

x=0:2^d-2;

num_w=floor(W/(2^d-2));
num_h=floor(H/(2^d-2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Creating the verical patterns %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pattern=zeros(num_h*(2^d-2),num_w*(2^d-2),d);

for j=1:d
for i=1:(2^d-2)
    if(i==2^d-2)
        
        if(P(j,i)==0 && P(j,1)==0)
            pattern(:,(i-1)*num_w+1:i*num_w,j)=0;
            
        elseif(P(j,i)==1 && P(j,1)==1)
            pattern(:,(i-1)*num_w+1:i*num_w,j)=255;
            
        elseif(P(j,i)==0 && P(j,1)==1)
            p=increase(num_w,num_h*(2^d-2),0);
            pattern(:,(i-1)*num_w+1:i*num_w,j)=p;
            
        elseif(P(j,i)==1 && P(j,1)==0)
             p=decrease(num_w,num_h*(2^d-2),0);
             pattern(:,(i-1)*num_w+1:i*num_w,j)=p;
            
        end
    else
        if(P(j,i)==0 && P(j,i+1)==0)
            pattern(:,(i-1)*num_w+1:i*num_w,j)=0;
        
        elseif(P(j,i)==1 && P(j,i+1)==1)
            pattern(:,(i-1)*num_w+1:i*num_w,j)=255;
            
        elseif(P(j,i)==0 && P(j,i+1)==1)
            p=increase(num_w,num_h*(2^d-2),0);
            pattern(:,(i-1)*num_w+1:i*num_w,j)=p;
            
        elseif(P(j,i)==1 && P(j,i+1)==0)
            p=decrease(num_w,num_h*(2^d-2),0);
            pattern(:,(i-1)*num_w+1:i*num_w,j)=p;
        
        end
    end
end
end   
    


for i=1:d
    figure;
    imshow(uint8(pattern(:,:,i)));
    imwrite(uint8(pattern(:,:,i)),['pattern_1',num2str(i),'.png']);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Creating the horizontal patterns %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pattern_h=zeros(num_h*(2^d-2),num_w*(2^d-2),d);

for j=1:d
for i=1:(2^d-2)
    if(i==2^d-2)
        
        if(P(j,i)==0 && P(j,1)==0)
            pattern_h((i-1)*num_h+1:i*num_h,:,j)=0;
            
        elseif(P(j,i)==1 && P(j,1)==1)
            pattern_h((i-1)*num_h+1:i*num_h,:,j)=255;
            
            
        elseif(P(j,i)==0 && P(j,1)==1)
            p=increase(num_h,num_w*(2^d-2),1);
            pattern_h((i-1)*num_h+1:i*num_h,:,j)=p;
            
            
        elseif(P(j,i)==1 && P(j,1)==0)
             p=decrease(num_h,num_w*(2^d-2),1);
             pattern_h((i-1)*num_h+1:i*num_h,:,j)=p;
            
        end
    else
        if(P(j,i)==0 && P(j,i+1)==0)
            pattern_h((i-1)*num_h+1:i*num_h,:,j)=0;
        
        elseif(P(j,i)==1 && P(j,i+1)==1)
            pattern_h((i-1)*num_h+1:i*num_h,:,j)=255;
            
        elseif(P(j,i)==0 && P(j,i+1)==1)
            p=increase(num_h,num_w*(2^d-2),1);
            pattern_h((i-1)*num_h+1:i*num_h,:,j)=p;
            
        elseif(P(j,i)==1 && P(j,i+1)==0)
            p=decrease(num_h,num_w*(2^d-2),1);
            pattern_h((i-1)*num_h+1:i*num_h,:,j)=p;
        
        end
    end
end
end   
    


for i=1:d
    figure;
    imshow(uint8(pattern_h(:,:,i)));
    
    imwrite(uint8(pattern_h(:,:,i)),['pattern_2',num2str(i),'.png']);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Saving the pattern in P
P={};

for i=1:2
    if(i==1)
        for j=1:size(pattern,3)
            P{i,j}=uint8(pattern(:,:,j));
        end
    else
        for j=1:size(pattern_h,3)
            P{i,j}=uint8(pattern_h(:,:,j));
        end


    end
end

end

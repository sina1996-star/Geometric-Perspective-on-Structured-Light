%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Creating the linearly decreasing interval
function p=decrease(num_h,H,s)

if (s==0)
    p=zeros(H,num_h);
    p_row=linspace(255,0,num_h+1);
    p_row(1)=[];

    for i=1:H
        p(i,:)=p_row;
    end

end    
    

if(s==1)
    p=zeros(num_h,H);
    p_row=linspace(255,0,num_h+1)';
    p_row(1)=[];


    for i=1:H
        p(:,i)=p_row;
    end
end


end

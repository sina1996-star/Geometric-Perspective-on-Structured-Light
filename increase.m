%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Creating the linearly increasing interval
function p=increase(num_h,H,s)

if(s==0)
    p=zeros(H,num_h);
    p_row=linspace(0,255,num_h+1);
    p_row(1)=[];


    for i=1:H
        p(i,:)=p_row;
    end
end


if(s==1)
    p=zeros(num_h,H);
    p_row=linspace(0,255,num_h+1)';
    p_row(1)=[];


    for i=1:H
        p(:,i)=p_row;
    end
end

end

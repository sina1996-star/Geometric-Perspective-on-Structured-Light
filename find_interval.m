%%%%% Find the interval %%%%%

%%%% Find the sub-interval that p belongs to 

function [interval_num,increase]=find_interval(p,code_point)


sub_intervasl_map=[0,0,0,2,1,3;
    0,0,0,1,2,4;
    0,0,2,1,0,3;
    0,0,1,2,0,4;
    0,0,1,0,2,3;
    0,0,1,2,1,3;
    0,2,1,1,1,3;
    0,1,2,1,1,4;
    0,1,0,2,1,4;
    0,1,0,0,2,4;
    0,1,0,2,0,3;
    0,1,2,1,0,3;
    0,1,1,2,0,4;
    0,1,1,0,2,3;
    2,1,1,0,1,3;
    1,2,1,0,1,4;
    1,0,1,0,2,4;
    1,0,2,0,0,4;
    1,0,0,2,0,3;
    1,0,0,1,2,3;
    1,0,2,1,1,3;
    1,0,1,1,2,4;
    1,2,1,1,0,3;
    1,1,1,2,0,4;
    1,1,2,0,0,4;
    1,1,0,2,0,3;
    1,1,0,1,2,3;
    1,1,0,2,1,4;
    1,2,0,0,1,4;
    2,0,0,0,1,4];



if (code_point==sub_intervasl_map(1,1:5))
    interval_num=1;
    increase=1;
    
elseif(code_point==sub_intervasl_map(2,1:5))
    interval_num=2;
    increase=0;
elseif(code_point==sub_intervasl_map(3,1:5))
    interval_num=3;
    increase=1;
elseif(code_point==sub_intervasl_map(4,1:5))
    interval_num=4;
    increase=0;
elseif(code_point==sub_intervasl_map(5,1:5))
    interval_num=5;
    increase=1;
elseif(code_point==sub_intervasl_map(6,1:5))
    interval_num=6;
    increase=1;
elseif(code_point==sub_intervasl_map(7,1:5))
    interval_num=7;
    increase=1;
elseif(code_point==sub_intervasl_map(8,1:5))
    interval_num=8;
    increase=0;
elseif(code_point==sub_intervasl_map(9,1:5))
    interval_num=9;
    increase=0;
elseif(code_point==sub_intervasl_map(10,1:5))
    interval_num=10;
    increase=0;
elseif(code_point==sub_intervasl_map(11,1:5))
    interval_num=11;
    increase=1;
elseif(code_point==sub_intervasl_map(12,1:5))
    interval_num=12;
    increase=1;
elseif(code_point==sub_intervasl_map(13,1:5))
    interval_num=13;
    increase=0;
elseif(code_point==sub_intervasl_map(14,1:5))
    interval_num=14;
    increase=1;
elseif(code_point==sub_intervasl_map(15,1:5))
    interval_num=15;
    increase=1;
elseif(code_point==sub_intervasl_map(16,1:5))
    interval_num=16;
    increase=0;
elseif(code_point==sub_intervasl_map(17,1:5))
    interval_num=17;
    increase=0;
elseif(code_point==sub_intervasl_map(18,1:5))
    interval_num=18;
    increase=0;
elseif(code_point==sub_intervasl_map(19,1:5))
    interval_num=19;
    increase=1;
elseif(code_point==sub_intervasl_map(20,1:5))
    interval_num=20;
    increase=1;
elseif(code_point==sub_intervasl_map(21,1:5))
    interval_num=21;
    increase=1;
elseif(code_point==sub_intervasl_map(22,1:5))
    interval_num=22;
    increase=0;
elseif(code_point==sub_intervasl_map(23,1:5))
    interval_num=23;
    increase=1;
elseif(code_point==sub_intervasl_map(24,1:5))
    interval_num=24;
    increase=0;
elseif(code_point==sub_intervasl_map(25,1:5))
    interval_num=25;
    increase=0;
elseif(code_point==sub_intervasl_map(26,1:5))
    interval_num=26;
    increase=1;
elseif(code_point==sub_intervasl_map(27,1:5))
    interval_num=27;
    increase=1;
elseif(code_point==sub_intervasl_map(28,1:5))
    interval_num=28;
    increase=0;
elseif(code_point==sub_intervasl_map(29,1:5))
    interval_num=29;
    increase=0;
elseif(code_point==sub_intervasl_map(30,1:5))
    interval_num=30;
    increase=0;
else
    
    interval_num=-1;
    increase=-1;
end





end



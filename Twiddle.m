%Twiddle Algorithm 
clear;
clc;
j=1;
P=[0 0 0];
dp=[0.1 0.1 0.1];

cam=webcam('Logitech Webcam 120');
preview(cam);
pause(2);

sum=dp(1)+dp(2)+dp(3);

%out=[avgerr init i]
robotxy=robot_position(cam);
init=[robotxy(2) robotxy(1)];
%goal=block();
goal=[77 109];
goalsdata=A_Star_Search(cam);%,goal);
%tic;

k=1;

    a=arduino('COM4','Uno'); 
    writeDigitalPin(a,'D4',0);
    writeDigitalPin(a,'D11',0);
 
out=run(a,P(1),P(2),P(3),init,goalsdata,j,cam)%,goal,k);%out=[avgerr init i goalsdata finalgoal k]
x=out(1);
while(sum>0.01)
 for k=1:1:4 
     P(k)=P(k)+dp(k);
     err=run(a,P(1),P(2),P(3),init,goalsdata,out(3),cam )%,out(5),out(6)); 
     
     if(err(1)<x)
            x=err(1);
            dp(k)=dp(k)*1.1;
     else
            P(k)=P(k)-2*dp(k);
            
            err=run(a,P(1),P(2),P(3),init,goalsdata,out(3),cam)%,out(5),out(6));
            
            if(err(1)<x)
                    x=err(1);
                    dp(k)=dp(k)*1.1;
            else
                P(k)=P(k)+dp(k);
                dp(k)=dp(k)*0.9;
            end
     end
     
 end
     
display(P);
display(x);
end

%display(p);
display(out(1));



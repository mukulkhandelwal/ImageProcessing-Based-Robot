function PIDControll()
  %lastTime;
 %Input, Output, Setpoint;
 %ITerm, lastInput;
 %kp ,ki ,kd;
 %SampleTime = 1000;% //1 sec
 %outMin, outMax;
%constant=[kp ki kd];
kp=0.1;
ki=1;
kd=0;
outMin=-0.3;
outMax=0.3;
ITerm=0;
Setpoint=0;
cam=webcam('Logitech Webcam 120');
preview(cam);
goalsdata=A_Star_Search(cam);
[x,y]=size(goalsdata);
goalsdata(y+1)=77;
goalsdata(y+2)=109;
y=y+2;
lastTime=0;
%robotX=0;
dInput=0;
Output=0;
%robotY=0;
robotxy=robot_position(cam);
lastInput=0;
SampleTime=-1;
i=1;
init=[robotxy(2) robotxy(1)];% by image
%goal=[goalsdata(i),goalsdata(i+1)];%first goal goal1 returns starting and final point pixel then we make equation of line
goal=[20 10];
    a=arduino('COM4','Uno'); 
    writeDigitalPin(a,'D4',0);
    writeDigitalPin(a,'D11',0);
 
    
    
  x=cast(robotxy(2),'double');
    %y=(double)robotxy(1);
    y=cast(robotxy(1),'double');
    
   % display(x);
    %display(y);   
      
    %Input=((robotxy(1)-init(1))*(goal(2)-init(2))-(robotxy(2)-init(2))*(goal(1)-init(1)))/((goal(1)-init(1))^2+(goal(2)-init(1))^2);
    %Input=InputFind(x,y,init(1),init(2),goal(1),goal(2));
    x1=cast(init(1),'double');%init(1);
    y1=cast(init(2),'double');
    x2=cast(goal(1),'double');%goal(1);
    y2=cast(goal(2),'double');%goal(2);
    
        X1=x-x1;
X1=cast(X1,'double');
        Y1=y2-y1;
   Y1=cast(Y1,'double');
        Y2=y-y1;
 Y2=cast(Y2,'double');
        X2=x2-x1;
    X2=cast(X2,'double');
        num=X1*Y1-Y2*X2;
   den=((X2)^2+(Y1)^2)^(1/2);

    %den=((((X2)^2+(Y1)^2))^(1/2));
 %  display(num);
  % display(den);
    Input=num/den;
    display(Input);
  

    
    co=[Output ITerm lastTime lastInput dInput];
%ab=SetOutputLimits(Min, Max); %ab=[Output,ITerm];
%Input=0;

%cd=SetSampleTime( NewSampleTime,SampleTime);%cd=[ki,kd,SampleTime]


%constant= SetTunings(constant,SampleTime);      %  constant(1) = kp;
                                                %  constant(2) = ki * SampleTimeInSec;
                                                % constant(3) =kd / SampleTimeInSec;
                    
tic
j=1;
while(j<40)
     %perpendicular distance
     robotxy=robot_position(cam);
     
  
  x=cast(robotxy(2),'double');
    %y=(double)robotxy(1);
    y=cast(robotxy(1),'double');
    
   % display(x);
    %display(y);   
      
    %Input=((robotxy(1)-init(1))*(goal(2)-init(2))-(robotxy(2)-init(2))*(goal(1)-init(1)))/((goal(1)-init(1))^2+(goal(2)-init(1))^2);
    %Input=InputFind(x,y,init(1),init(2),goal(1),goal(2));
    x1=cast(init(1),'double');%init(1);
    y1=cast(init(2),'double');
    x2=cast(goal(1),'double');%goal(1);
    y2=cast(goal(2),'double');%goal(2);
    
        X1=x-x1;
X1=cast(X1,'double');
        Y1=y2-y1;
   Y1=cast(Y1,'double');
        Y2=y-y1;
 Y2=cast(Y2,'double');
        X2=x2-x1;
    X2=cast(X2,'double');
        num=X1*Y1-Y2*X2;
   den=((X2)^2+(Y1)^2)^(1/2);

   
    Input=num/den;
    display(Input);
  
     %Input= InputFind(x,robotxy(2),init(1),init(2),goal(1),goal(2));

    co=compute(co(3),SampleTime,co(2),co(5),ki,kp,kd,Setpoint,outMax,outMin,co(4),Input,a)%,co(1));%co=[Output,ITerm,lastTime,lastInput,dInput];
    
  %arduinoCom = serial('COM3','BaudRate',9600 );  % insert your serial
                                                           %properties here
 %sendData = co(1);
% fopen(arduinoCom);
 %fprintf(arduinoCom,'%i',sendData); %this will send 5 to the arduino
 %fscanf(arduinoCom)    %this will read response
                       %or use BytesAvailableFcn property of serial
    
    % ab=setOutputLimits(Min,Max);%We have to check every time that the output not crosses its limit;%ab=[Output,ITerm];
    %if(co(1)~=0)   %output
        %motor controls how to do pid send signal to motor;
    
u=checkunbalance(x,y,x1,y1,x2,y2);
display(u);
if(u>1)
        init=goal;
        i=i+2;
        goal=[goalsdata(i) goalsdata(i+1)];% find its equation
    display(init);
    display(goal);
    
end
   % if(init(1)==goal(1)&&init(2)==goal(2))
    %    init=goal;
        
     %   goal=[goalsdata(i) goalsdata(i+1)];% find its equation
      %     i=i+2;
   % end
%end

                            
%co=compute(lastTime,SampleTime,ITerm,ki,kp,kd,Setpoint,Input,outMax,outMin);%co=[Output,Iterm,lastTime];
j=j+1;
end
end
function out =run(a,kp,ki,kd,init,goalsdata,i,cam)%,finalgoal,k)
%lastTime,SampleTime,ITerm,ki,kp,kd,Setpoint,outMax,outMin,lastInput,Input;
   tic;
 
   u=0;
   Output=0;
  erroradd=0;
   dInput=0;
   %erradd=0;
   lastInput=0;
   timeChange=0;
   outMax=0.3;
   outMin=-0.3;
   lastTime=0;
   ITerm=0;
   now=0;
   avgerr=0;
   %robotX=0;
    %robotY=0;
    Setpoint=0;
    err=0;
   SampleTime=1;
   
    goal=[goalsdata(i) goalsdata(i+1)];
  %display(goal);
  %display(init);
  
    for j=1:6
       robotxy=robot_position(cam);
    display(robotxy);
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
    %display(num/den);
    now = toc;
   timeChange = (now - lastTime);

      
   %if(timeChange>=SampleTime)
   
      %/*Compute all the working error variables*/
       err = Setpoint - Input;
      ITerm= ITerm+(ki * err);
      if(ITerm> outMax)
          ITerm= outMax;
      elseif(ITerm< outMin) 
              ITerm= outMin;
       dInput = (Input - lastInput);
      end
      %/*Compute PID Output*/
      
      Output = kp * err + ITerm- kd * dInput;
      
      if(Output > outMax)
          Output = outMax;
      elseif(Output < outMin) 
              Output = outMin;
      end
      
    
  m1speed=0.5-(Output);    
      m2speed=0.5+(Output);    
   
  writePWMDutyCycle(a,'D3',m1speed);
  writePWMDutyCycle(a,'D10',m2speed);
  
  pause(0.3);
  %
  writePWMDutyCycle(a,'D3',0);
  writePWMDutyCycle(a,'D10',0);


    
     
      
      
      
      lastInput = Input;
      lastTime = now;
   %end
    if(j>3)
    erroradd=erroradd+err;
    end
    
    u=checkunbalance(init,goal,x,y);
  %  if(robotxy(1)==goal(1)&&robotxy(2)==goal(2))
  display(u); 
  if(u>1)
        init=goal;
        i=i+2;
        goal=[goalsdata(i) goalsdata(i+1)];% find its equation
    display(init);
    display(goal);
    
  end
  
 % if(x==finalgoal(1)&&y==finalgoal(2)||x==finalgoal(1)-1&&y==finalgoal(2)||x==finalgoal(1)&&y==finalgoal(2)+1||x==finalgoal(1)&&y==finalgoal(2)-1)
   % finalgoal=dropingzone();
 %  
    %i=0;
    %if(k==1)
    %goalsdata=A_Star_Search(cam,finalgoal);
   % init(1)=x;
   %k=k+1
    %init(2)=y;
    %elseif(k==2)
    %finalgoal=finalgoal();
    %goalsdata=A_Star_Search(cam,finalgoal);
   %k=k+1;
    % init(1)=x;
    %init(2)=y;
    %end
  %end
  %if(x==goal(1)+1&&y==goal(2)||x==goal(1)-1&&y==goal(2)||x==goal(1)&&y==goal(2)+1||x==goal(1)&&y==goal(2)-1)
   %   init=goal;
    %  i=i+2;
     % goal=[goalsdata(i) goalsdata(i+1)];
    %end
    
%display(m1speed);
%display(m2speed);    
display(Output);
   j=j+1;
    
    end
    
    avgerr=erroradd/6;

   out=[avgerr init i goalsdata]%goalsdata finalgoal k]
   end
function co= compute(lastTime,SampleTime,ITerm,dInput,ki,kp,kd,Setpoint,outMax,outMin,lastInput,Input,a)%,Output)
   


%err=1;

    now = toc;
   timeChange = (now - lastTime);

      
  % if(timeChange>=SampleTime)
   
      %/*Compute all the working error variables*/
       err = (Setpoint - Input);
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
      
      
  m1speed=0.3-(Output);    
      m2speed=0.3+(Output);    
   
  writePWMDutyCycle(a,'D3',m1speed);
  writePWMDutyCycle(a,'D10',m2speed);
  
  pause(0.3);
  %
  writePWMDutyCycle(a,'D3',0);
  writePWMDutyCycle(a,'D10',0);


    
  
      %/*Remember some variables for next time*/
      
      lastInput = Input;
      lastTime = now;
   %end
   display(Output);
    co=[Output ITerm lastTime lastInput dInput];
end
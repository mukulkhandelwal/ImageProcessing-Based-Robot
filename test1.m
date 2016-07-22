clci=1;
a=arduino('COM4','Uno'); 
    writeDigitalPin(a,'D4',0);
    writeDigitalPin(a,'D11',0);
%cam=webcam('Logitech Webcam 120');
%preview(cam);

    while(i<10)   
   Output=5;
  m1speed=(150/255)+(Output/255);    
      m2speed=(150/255)-(Output/255);    
   
  writePWMDutyCycle(a,'D3',m1speed);
  writePWMDutyCycle(a,'D10',m2speed);
  
  pause(1.0);
  %
  writePWMDutyCycle(a,'D3',0);
  writePWMDutyCycle(a,'D10',0);
i=i+1;
    
end
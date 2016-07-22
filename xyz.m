a=arduino('COM4','Uno');
%while(1)
%for i=0.1:0.05:0.5
%m1speed=0.5-i;
%m2speed=0.5+i;
writePWMDutyCycle(a,'D3',1);
writePWMDutyCycle(a,'D10',1);
writeDigitalPin(a,'D4',0);
writeDigitalPin(a,'D11',0);

%end

function constant= SetTuning(constant,SampleTime)
SampleTimeInSec = (SampleTime)/1000;
   constant(1) = constant(1);
    constant(2) = constant(2) * SampleTimeInSec;
   constant(3) = constant(3) / SampleTimeInSec;
   
   
end
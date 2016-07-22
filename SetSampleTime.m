function cd=SetSampleTime(NewSampleTime,SampleTime)

if (NewSampleTime > 0)
   
     ratio  = NewSampleTime/SampleTime;
                      
      ki =ki* ratio;
      kd =kd/ ratio;
      SampleTime = NewSampleTime;
   cd=[ki,kd,SampleTime]
end
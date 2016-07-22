function ab = SetOutputLimits(Min, Max)
if(Min > Max)
    return;
   outMin = Min;
   outMax = Max;
    
   if(Output > outMax)
       Output = outMax;
   elseif(Output < outMin)
       Output = outMin;
   end
   if(ITerm> outMax)
       ITerm= outMax;
   elseif(ITerm< outMin)
       ITerm= outMin;
   end
   ab=[Output,ITerm];
end
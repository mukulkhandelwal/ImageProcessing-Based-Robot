function Input=InputFind(x,y,x1,y1,x2,y2)
   %Input1=2;
    X1=x-x1;
   Y1=y2-y1;
   Y2=y-y1;
   X2=x2-x1;
    num=X1*Y1-Y2*X2;
    den=((X2)^2+(Y1)^2)^(1/2);
   display(num);
   display(den);
    Input1=num/den;
    display(Input1);
    Input=Input1;
    
end
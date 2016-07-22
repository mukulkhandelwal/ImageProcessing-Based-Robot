function u=checkbalance(x,y,x1,y1,x2,y2)
x=cast(x,'double');
y=cast(y,'double');
X1=cast(x1,'double');
Y1=cast(y1,'double');
X2=cast(x2,'double');
Y2=cast(y2,'double');
u=abs((x-X1)*(X2-X1)+(y-Y1)*(Y2-Y1))/(((X2-X1)^2)+((Y2-Y1)^2)^(1/2));

end

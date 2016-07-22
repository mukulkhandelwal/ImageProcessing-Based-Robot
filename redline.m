function I=redline()%ima)
i=imread('redline.jpg');

 %   cam=webcam('Logitech Webcam 120');
%preview(cam);
%pause(1);

  % preview(cam);
%pause(8);
%   i=snapshot(cam);
imshow(i);
%i=rgb2ind(i);zz
%figure,imshow(i);
red=i(:,:,1);
green=i(:,:,2);
blue=i(:,:,3);

out=red>140&green<120&blue<120;
out1=imfill(out,'holes');

out2=bwmorph(out1,'dilate');
out2=imresize(out2,[200 250]);
%out2=imcomplement(out2);
%figure,imshow(out2);
se = strel('disk',2);
I = imdilate(out2,se);
%I=imerode(out2,se)
%I=imresize(I,[100 120]);
%[row,column]=size(out2);
%display(row);
%display(column);
I=imfill(I,'holes');
%I = gpuArray(out2);

%J = imcomplement(I);
 figure, imshow(I)%, figure, imshow(J)
%imwrite(J,redline.png)
 %display(I);
 %display(i);
 %figure,imshow(out2);
%figure,imshow(i);
%figure,imshow(I);
% sx=size(out1);

%display(sx)
%display(size(sx,1));
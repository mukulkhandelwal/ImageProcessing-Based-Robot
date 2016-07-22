function z=dropingzone()
cam=webcam('Logitech Webcam 120');
preview(cam);
pause(6);
im=snapshot(cam);
figure,imshow(im);
red=im(:,:,1);
green=im(:,:,2);
blue=im(:,:,3);

im=red>190&red<224&green>60&green<80&blue>100&blue<145;
figure,imshow(im);
se=strel('line',10,30);
im=imclose(im,se);
im=imfill(im,'holes');
se=strel('line',10,30);
im=imopen(im,se);
%imshow(im);
im=bwareaopen(im,180);


L=bwlabel(im);

stats=regionprops(L,'centroid');
centroids = cat(1, stats.Centroid);
figure,imshow(L);

hold on
plot(centroids(:,1),centroids(:,2), 'b*')
hold off
display(stats);
x=uint16t(stats(1).Centroid(1));
y=uint16(stats(1).Centroid(2));
z=[x y];
end
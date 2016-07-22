%vid=videoinput('winvideo',1,'MJPG_1280x720');
%preview(vid);
%start(vid);
function robotxy=robot_position()
%cam=webcam('Logitech Webcam 120');
%preview(cam);

%pause(3);
%im=snapshot(cam);
figure,imshow(im);
red=im(:,:,1);
green=im(:,:,2);
blue=im(:,:,3);
im= red>140&red<205 & green<170& green>120 & blue>140 & blue<200;
%im_g=rgb2gray(im);
%t000000000000=graythresh(im_g);
se=strel('line',10,30);
im=imclose(im,se);
im=imfill(im,'holes');
se=strel('line',10,30);
im=imopen(im,se);
%imshow(im);
im=bwareaopen(im,1000);
%im=imcomplement(im);
%figure,imshow(im);
im=imresize(im,[100 120]);
L=bwlabel(im);

stats=regionprops(L,'centroid');
centroids = cat(1, stats.Centroid);
figure,imshow(L);

hold on
plot(centroids(:,1),centroids(:,2), 'b*')
hold off
display(stats);

robotxy=uint8(stats(1).Centroid);
x=uint16(stats(1).Centroid(1));
y=uint16(stats(1).Centroid(2));
robotxy=[x y]
%display(robotxy(1));
%display(robotxy(2));
%x=uint8(stats(1).Centroid(1));
%display(x);
end
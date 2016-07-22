cam=webcam('USB Video Device');
preview(cam);

im=snapshot(cam);


%vid=videoinput('winvideo',1,'MJPG_848x480');%use image with clear red shapes
%start(vid);
%im=getsnapshot(vid);
%figure,imshow(im);
tic;
% Extract the individual red, green, and blue color channels.
redChannel = im(:, :, 1);
greenChannel = im(:, :, 2);
blueChannel = im(:, :, 3);
redPixels= redChannel <=20 & greenChannel  >=200 & blueChannel  <= 20;%red Identification
%OrangePixels=redChannel>=250 & 120<=greenChannel & greenChannel<=130 & 35<=blueChannel & blueChannel<=40;
%blue=redChannel<=140 & greenChannel <=240 & blueChannel <=245;
% Make red (255,0,0)
redChannel(redPixels) = 255;
greenChannel(redPixels) = 255;
blueChannel(redPixels) = 255;
% Recombine separate color channels into a single, true color RGB image.
%whitePixels= redChannel >=200 & greenChannel >=200 & blueChannel >=200;
%redChannel(whitePixels)=255;
%greenChannel(whitePixels)=0;
%blueChannel(whitePixels)=0;
%redChannel(blue)=0;
%greenChannel(blue)=0;
%blueChannel(blue)=255;
im = cat(3, redChannel, greenChannel, blueChannel);
%figure,imshow(im);
%rgbImage=imcomplement(rgbImage);
im=rgb2gray(im);
%L = medfilt2(rgbImage,[3 3]);
%figure,imshow(im);
toc;
%t=graythresh(im);
im_bw=im2bw(im,0.6);
%figure,imshow(im_g);
se=strel('square',1);
im_bw=imclose(im_bw,se);
im_bw=imfill(im_bw,'holes');
B=bwboundaries(im_bw,'noholes');
display(B);
L=bwlabel(im_bw);
%display(L);
stats=regionprops(L,'centroid');
centroids = cat(1, stats.Centroid);
figure,imshow(L);
hold on
%plot(centroids(:,1),centroids(:,2), 'b*')
hold off
display(stats);
%closepreview(cam);
clear('cam');
clear;
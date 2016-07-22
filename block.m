function b=block()
cam=webcam('Logitech Webcam 120');
preview(cam);
pause(1);
im=snapshot(cam);
imshow(im);
red=im(:,:,1);
green=im(:,:,2);
blue=im(:,:,3);



L=bwlabel(out);

stats=regionprops(L,'centroid');
centroids = cat(1, stats.Centroid);
figure,imshow(L);

hold on
plot(centroids(:,1),centroids(:,2), 'b*')
hold off
display(stats);
end
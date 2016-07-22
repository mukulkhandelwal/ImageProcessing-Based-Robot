function robotxy=robotposition()

 %   cam=webcam('Integrated Webcam');
%preview(cam);

%im=snapshot(cam);
im=imread('test.png');

red=im(:,:,1);
green=im(:,:,2);
blue=im(:,:,3);


out=red<5&green<5&blue<5;
out=imresize(out,[200 200]);
L=bwlabel(out);
%display(L);
stats=regionprops(L,'centroid');
centroids = cat(1, stats.Centroid);
figure,imshow(L);
hold on
plot(centroids(:,1),centroids(:,2), 'b*')
hold off
display(stats);
imshow(out);
display(stats(1).Centroid(2));

robotxy=[stats(1).Centroid(1) stats(1).Centroid(2)];
%clear('cam');
end
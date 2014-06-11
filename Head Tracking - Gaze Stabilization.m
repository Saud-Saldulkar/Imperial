%-----------------
%CLEAR
%-----------------
clear all;
close all;
clc;
%-----------------

%-----------------
%IMPORTING VIDEO
%-----------------
filename='/Head movement 1v 20Hz_C001H001S0001.avi';
xyloObj = VideoReader(filename); %changed mmreader to videoreader
nFrames = xyloObj.NumberOfFrames;
vidHeight = xyloObj.Height;
vidWidth = xyloObj.Width;
%-----------------
% stim_angles=zeros(nFrames,1);
% head_angles=zeros(nFrames,1);
%-----------------
% CREATE MOVIE STRUCTURE
%-----------------
mov(1:nFrames) = ...
    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
           'colormap', []);


%-----------------
% SET NO OF FRAMES TO CAPTURE
%-----------------       
fs = 10906;
%-----------------       

%-----------------
%DEFINING STORAGE VECTOR (v)
%-----------------
v = zeros(1,fs);       
%-----------------

%-----------------       
%CREATING A HANDLE (I)       
%-----------------       
nFrames = fs;
for k = 1:nFrames;
I = read(xyloObj,k); %Create a handle 
% imshow(I);   % Display Image%
%-----------------

%-----------------
%CONVERT TO BINARY
%-----------------
I=im2bw(I);
%-----------------

%-----------------
%REMOVE AREAS UNDER 600 PIXELS
%-----------------
I= bwareaopen(I,400);
%-----------------

%-----------------
%LABEL COMPONENTS
%-----------------
I=bwlabeln(I,8);
% I=logical(I);
%-----------------

%-----------------
%DEFINE PROPERTIES
%-----------------
stats = regionprops(I, 'BoundingBox', 'Centroid');
%-----------------

%-----------------
%DISPLAY FIGURE
%-----------------
imshow(I)
hold on
%-----------------

%-----------------
%BOUND THE OBJECTS IN A RECTANGULAR BOX AND ASSIGN CENTROIDS
%-----------------
for object = 1:length(stats)
        bb = stats(object).BoundingBox;
        bc = stats(object).Centroid;
        rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
        fig=plot(bc(1),bc(2), '-m+');
        a=text(bc(1)+15,bc(2), strcat('X: ', num2str(round(bc(1))), '    Y: ', num2str(round(bc(2)))));
        set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
end
%-----------------

%-----------------
%EXTRACT CENTROID VALUES
%-----------------
try
    head=stats(3,1).Centroid;
catch
    head=stats(2,1).Centroid;
    
end
%-----------------

%-----------------
%DRAW REFERENCE LINE
%-----------------
refline=line('XData',[54 400],'YData',[450 450],'Color','r');
%-----------------

%-----------------
%DEFINING CO-ORDINATES FOR MOBILE LINE
%-----------------
x1 = 54;
x2 = head(1:1);

y1 = 450;
y2 = head(2:2);
%-----------------


%-----------------
%DRAW MOBILE LINE
%-----------------
mobileline=line('XData',[x1 x2],'YData',[y1 y2],'Color','g');
%-----------------

%-----------------
%CALCULATE ANGLE
%-----------------
radangle = atan2(abs(x1*y2-y1*x2),x1*x2+y1*y2); %angle in radians
angle = (radangle*180)/ pi; %angle in degrees
%-----------------

%-----------------
%EXTRACTING (ANGLES) TO BE STORED IN THE STORAGE VECTOR(V)
%-----------------
if k ~= nFrames;
    v(1,k) = angle;
end
%-----------------
k
hold off
    
end

%-----------------
%SAVE MEASUREMENTS
%-----------------
save('measurements.mat','v');
%-----------------






%-----------------
%PATTERN RECOGNITION ALGORITHM 01 (USE DIRECTLY WITH IMAGE HANDLE)
%-----------------
% I = im2bw(I, graythresh(I));
% [B,L] = bwboundaries(I,'noholes');
% s=imshow(label2rgb(L, @jet, [0.5 0.5 0.5]));
% 
% hold on
% 
% for k = 1:length(B)
%     boundary = B{k};
%     %diff_im = imsubtract(data(:,:,1), rgb2gray(data));
%     plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
%     %imshow(diff_im)
% end
%-----------------

%-----------------
%CONNECT COMPONENTS
%-----------------
% bw = imopen(th,strel('disk',3));
% figure, imshow(bw)
%-----------------

%-----------------
%CROPPING
%-----------------
% c = imcrop(th,[364.5 269.5 98 115]);
% 
% imshow (c)
%-----------------

%-----------------
%THRESHOLDING
%-----------------
% th= im2bw(I, 0.5);
% I = th;
% imshow(I)
%-----------------

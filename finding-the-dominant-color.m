clc;
clear all;
close all;
[filename, pathname] = uigetfile('*.*', 'Pick an image');
if isequal(filename,0) || isequal(pathname,0)
    fprintf('Cancelled\n');
else
    rgbimage=imread(filename);  
    redChannel=rgbimage(:, :, 1);
    greenChannel=rgbimage(:, :, 2);
    blueChannel=rgbimage(:, :, 3);
    d=double([redChannel(:), greenChannel(:), blueChannel(:)]);
    k=input('How many colors will the image be divided into?  ');
    [m, n]=kmeans(d,k);
    m=reshape(m,size(rgbimage,1),size(rgbimage,2));
    n=n/255;
    clusteredImage=label2rgb(m,n);
    frequency=[];
    temp=0;
    for i = 1:k
        for a=1:size(rgbimage,1)
            for b=1:size(rgbimage,2)
                if(m(a,b)==i)
                    temp=temp+1;
                end
            end
        end
        frequency=[frequency temp];
        temp=0;
    end
    [ma,na]=max(frequency);
    subplot(2,2,1);
    imshow(rgbimage);
    title('Original Image');
    subplot(2,2,2);
    imshow(clusteredImage);
    title('Clustered Image');
    subplot(2,2,3);
    pie(frequency);
    colormap([n]);
    title('Proportion of Colors');
    subplot(2,2,4);
    patch([0 0 10 10],[0 10 10 0],n(na,:));
    title('Dominant Color');
end
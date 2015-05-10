function R=image_enhance
original=imread('001.jpg');
[ox oy oz]=size(original);
if oz~=1
    gray=rgb2gray(original);
end
gray_image(:,:,1)=gray;
gray_image(:,:,2)=gray;
gray_image(:,:,3)=gray;
subplot(1,2,1);imshow(gray_image);
%Gray histogram
histogram(gray);
%Gray transformation
%
%线性
G_trans1=gray/2;
G_trans1_image=gray_image/2;
figure,subplot(1,2,1);imshow(G_trans1_image);
histogram(G_trans1);
%分段线性
for i=1:ox
    for j=1:oy
        if gray(i,j)<100
            G_trans2(i,j)=gray(i,j)*0.8;
        elseif gray(i,j)<150
            G_trans2(i,j)=(gray(i,j)-100)*1.2/0.5+80;
        else
            G_trans2(i,j)=(gray(i,j)-150)*0.55/1.05+200;
        end
    end
end
G_trans2_image(:,:,1)=G_trans2;
G_trans2_image(:,:,2)=G_trans2;
G_trans2_image(:,:,3)=G_trans2;
figure,subplot(1,2,1);imshow(G_trans2_image);
histogram(G_trans2);
%Image smoothing
G_noise=imnoise(gray_image,'gaussian',0,0.0035);
figure,subplot(1,3,1);imshow(gray_image);
subplot(1,3,2);imshow(G_noise);
G_average=G_noise;
for i=2:(ox-1)
    for j=2:(oy-1)
        for k=1:3
            G_average(i,j,k)=G_noise(i-1,j-1,k)/9+G_noise(i-1,j,k)/9+G_noise(i-1,j+1,k)/9+ ...
                G_noise(i,j-1,k)/9+G_noise(i,j,k)/9+G_noise(i,j+1,k)/9+ ...
                G_noise(i+1,j-1,k)/9+G_noise(i+1,j,k)/9+G_noise(i+1,j+1,k)/9;
        end
    end
end
subplot(1,3,3);imshow(G_average);
%Image sharpening

%sober算子，效果不太好，如无需要可以不用，先注释掉
G_sharpen=uint16(gray_image);%此处可以修改处理图像
G_sharpen1=gray_image;
for i=2:(ox-1)
    for j=2:(oy-1)
        for k=1:3
            G_sharpen1(i,j,k)=G_sharpen(i-1,j-1,k)+2*G_sharpen(i-1,j,k)+G_sharpen(i-1,j+1,k)- ...
                              G_sharpen(i+1,j-1,k)-2*G_sharpen(i+1,j,k)-G_sharpen(i+1,j+1,k);
        end
    end
end

G_sharpen2=gray_image;
for i=2:(ox-1)
    for j=2:(oy-1)
        for k=1:3
            G_sharpen2(i,j,k)=G_sharpen(i-1,j-1,k)+2*G_sharpen(i,j-1,k)+G_sharpen(i+1,j-1,k)- ...
                              G_sharpen(i-1,j+1,k)-2*G_sharpen(i,j+1,k)-G_sharpen(i+1,j+1,k);
        end
    end
end
figure,subplot(1,3,1);imshow(gray_image);subplot(1,3,2);imshow(G_sharpen1);subplot(1,3,3);imshow(G_sharpen2);


%Laplace算子锐化法
G_sharpen=uint16(gray_image);%此处可以修改处理图像
G_sharpen3=gray_image;
for i=2:(ox-1)
    for j=2:(oy-1)
        for k=1:3
            G_sharpen3(i,j,k)=5*G_sharpen(i,j,k)-G_sharpen(i-1,j,k)-G_sharpen(i,j-1,k)- ...
                              G_sharpen(i,j+1,k)-G_sharpen(i+1,j,k);
        end
    end
end
figure,subplot(1,2,1);imshow(gray_image);subplot(1,2,2);imshow(G_sharpen3);

clc
clear
close all
lena = imread('lena_std.tif');
%imshow(lena);
lena = rgb2gray(lena);
%imshow(lena)

% Noise Reduction
filter = 1/159 *[2 4  5  4  2;
                 4 9  12 9  4;
                 5 12 15 12 5;
                 4 9  12 9  4;
                 2 4 5 4 2];
lena = imfilter(lena, filter);
%imshow(lena)

% Gradient
Fx = [-1 0 1;
      -2 0 2
      -1 0 1];
Fy = [1  2  1;
      0  0  0;
      -1 -2 -1];
Dx = double(imfilter(lena, Fx))/255;
Dy = double(imfilter(lena, Fy))/255;
D = sqrt(Dx.^2 + Dy.^2);
figure(1)
imshow(Dx);
theta = atan2(Dy,Dx);
theta = (theta * 180)/pi; %-180 ~ 180
thetaR = theta;
[rows, cols] = size(theta);
for r = 1: rows
    for c = 1: cols
        t = thetaR(r, c); 
        % yellow part
        if( (t >= -22.5 && t < 22.5) || (t >= 157.5 && t < 202.5))
            thetaR(r, c) = 0;
        % green part
        elseif( (t >= 22.5 && t < 67.5) || (t >= 202.5 && t < 247.5) )
            thetaR(r, c) = 45;
        % blue part
        elseif( (t >= 67.5 && t < 112.5) || (t >= 247.5 && t < 292.5))
            thetaR(r, c) = 90;
        % red part
        else
            thetaR(r, c) = 135;
        end
            
    end
end
%NMS
img_NMS = zeros(rows, cols);
for r = 2: rows - 1
    for c = 2: cols - 1
        t = thetaR(r, c);
        d = D(r, c);
        % 0
        if(t == 0)
            if( d > D(r + 1, c) && d > D(r - 1, c))
                img_NMS(r, c) = D(r, c);
            else
                img_NMS(r, c) = 0;
            end
        end
        % 90
        if(t == 90)
            if( d > D(r, c + 1) && d > D(r, c - 1))
                img_NMS(r, c) = D(r, c);
            else
                img_NMS(r, c) = 0;
            end
        end
        % 45
        if( t == 45)
            if( d > D(r + 1, c + 1) && d < D(r - 1, c - 1))
                img_NMS(r, c) = D(r, c);
            else
                img_NMS(r, c) = 0;
            end
        end
        % 135
        if(t == 135)
            if( d > D(r + 1, c - 1) && d < D(r - 1, c + 1))
                img_NMS(r, c) = D(r, c);
            else
                img_NMS(r, c) = 0;
            end
        end
    end %cols loop
end % rows loop

figure(2)
imshow(img_NMS);
% Thresholding
th_low = 0.1;
th_high = 0.5;
img_th = zeros(rows, cols);
test = 0;
for r = 1: rows 
    for c = 1: cols
        d = img_NMS(r, c);
        if(d < th_low)
            img_th(r, c) = 0;
        elseif(d > th_high)
            img_th(r, c) = 1;
       
        
        end
    end
end
figure(3)
imshow(img_th);


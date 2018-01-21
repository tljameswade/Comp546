radius = 13; % Param of the Gaussian radius

I1 = imread('james.jpg');
I2 = imread('jing.jpg');
I1_ = fftshift(fft2(double(I1)));
I2_ = fftshift(fft2(double(I2)));
[m, n, z] = size(I1);
h = fspecial('gaussian', [m n], radius);
h = h./max(max(h));
J_ = zeros(m,n,z);
for colorI = 1:3
    J_(:,:,colorI) = I1_(:,:,colorI).*(1-h) + I2_(:,:,colorI).*h;
end
J = uint8(real(ifft2(ifftshift(J_))));
imshow(J);
imwrite(J,'hybrid.jpg');
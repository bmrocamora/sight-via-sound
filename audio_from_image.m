clear all, close all, clc

n=5;
[x,y] = hilbert(n);

x = (x+0.5)*2^n+0.5;
y = (y+0.5)*2^n+0.5;

position = 'where';
rgbImage = imread([position '.jpg']);
rescaledRgbImage = imresize(rgbImage,[2^n 2^n]);

grayImage = rgb2gray(rgbImage);

f = 5+2000:5:(5*2^n*2^n+2000);

normalizedGrayImage = grayImage/(255);

signalPower = zeros(1,length(x));
for i=1:length(x)
signalPower (i) = normalizedGrayImage(y(i),x(i));
end

figure
plot(f,signalPower)
% 
% f = [2000 3000 4000 5000];
% signalPower = [0 0 1 0];

fs=51200;  % sampling frequency
duration=3;
t=0:1/fs:duration;

timeSignal = zeros(1,length(t));

for j = 1:length(f)
    
    for i = 1:length(t)
    
    timeSignal(i) = timeSignal(i) + signalPower(j)*sin(2*pi*f(j)*t(i));
    
    end

end

normalizedSignalSum = timeSignal/max(timeSignal);

figure
plot(t,normalizedSignalSum)

figure
image(grayImage);
colormap gray

% sound(normalizedSignalSum,fs);

filename = [position '.wav'];
audiowrite(filename,normalizedSignalSum,fs);

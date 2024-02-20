clc;
clear all;
close all;

areaW = 1000;
areaH = 1000;

bsX = 500;
bsY = 500;

numPhones = 20;
phoneX = randi([0, areaW], 1, numPhones);
phoneY = randi([0, areaH], 1, numPhones);

% Plotting the base station
plot(bsX, bsY, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
hold on;

% Plotting the mobile phones
%plot(phoneX, phoneY, 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'b');
%hold off;

% Calculate distances from base station to mobiles
distX = abs(bsX-phoneX);
distY = abs(bsY-phoneY);
distance = sqrt(distX.^2 + distY.^2);

% Set Fraunhofer distance
fraunhofer_distance = 300; 

% mobiles within Fraunhofer distance
farField = distance > fraunhofer_distance;
nearField = distance <= fraunhofer_distance;
nearfieldDevices = sum(nearField);

%power
pt=40;
gt=1;
gr=1;
c = 3e8;
f = 9e8;
lambda = c / f;

pr = (pt .* gt .* gr .* lambda^2) ./ (4 .* pi .* distance).^2;

pr_db = 10 .* log10(pr);
disp('Received Power (dB):');
disp(pr_db);
%print(pr);
scatter(phoneX(nearField), phoneY(nearField), 'bo', 'filled');
scatter(phoneX(farField), phoneY(farField), 'go', 'filled');

legend('Base Station', 'Near Field', 'Far Field');
xlabel = ('X');
ylabel = ('Y');
grid on;
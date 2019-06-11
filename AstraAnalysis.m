%% Purdue Orbital 
% 
% ASTRA DATA ANALYSIS
%
% Written by Dante Sanaei
% Started 4/7/2018
%
% Description of program
% This program allows the user to input a CSV file containing a simulation
% data from the online ASTRA high altitude balloon simulator (from the
% University of Southampton). Using this data it will find the average
% bursting altitude, the average maximum distance of landing, and the
% average horizontal velocity. 
%
% 
%%
function [averageMaxAlt, averageMaxDistance, averageVelocity, maxVelocity] = AstraAnalysis(file, simNum)
% help :
% 
% INPUTS:
%   file: the .csv file with single quotes around it
%   simNum: Number of simulations that were ran in ASTRA
% OUTPUTS:
%   averageMaxAlt: the average max altitude (bursting) (km)
%   averageMaxDistance: the average max distance (landing distance) (km)
%   averageVelocity: the average velocity in the flight relative to the
%   ground (m/s)
%
%
%%
%Initializations

clc 
close all
data = csvread(file, 2);
numLaunch = data(:,1);
time = data(:,2);
lat = data(:,3);
long = data(:,4);
altitude = data(:,5);
altitude = altitude / 1000;
time = time * 0.000277778;
%%
figure(4)
hold on
for u = 1:1
    altitude1 = altitude(numLaunch == u) * 1000;
    time1 = time(numLaunch == u) / 0.000277778;
    [a ind] = max(altitude1);
for o = 2:ind
    ascentRate(o) = (altitude1(o+1) - altitude1(o-1)) / (time1(o+1) - time1(o-1));
    
    
    
end
mean(ascentRate)
plot(time1(1:ind), ascentRate)

end
%%
%Calculations and plotting altitude vs time
numLaunch = data(:,1);
time = data(:,2);
lat = data(:,3);
long = data(:,4);
altitude = data(:,5);
altitude = altitude / 1000;
time = time * 0.000277778;
figure(1);
hold on
for j = 1:simNum
    plot(time(numLaunch == j), altitude(numLaunch == j))
end

title('Altitude Vs Time')
ylabel('Altitude (km)')
xlabel('Time (hours)')
grid on
hold off
averageTimeBurst = 0;
averageMaxAlt = 0;
for i = 1:simNum
    [MaxAlt, I] = max(altitude(numLaunch == i));
    burstTime = time(I);
    averageTimeBurst = averageTimeBurst + burstTime;
    averageMaxAlt = averageMaxAlt + MaxAlt;
end
averageMaxAlt = averageMaxAlt / i;
averageTimeBurst = averageTimeBurst / i

%%
%Calculations and plotting of distance vs time
numLaunch = data(:,1);
time = data(:,2);
lat = data(:,3);
long = data(:,4);
altitude = data(:,5);
altitude = altitude / 1000;
time = time * 0.000277778;
figure(2)
hold on
latlonStart = [lat(1), long(1)];
t = 1;
averageMaxDistance = 0;
for k = 1:simNum-1

    distance = [];
    
    while (t < length(numLaunch) && numLaunch(t) == k)
        [dist1] = lldistkm(latlonStart,[lat(t), long(t)]);
        distance = [distance, dist1];
        t = t + 1;
    end
    maxDistance = max(distance);
    averageMaxDistance = averageMaxDistance + maxDistance;
    plot(time(numLaunch == k), distance)
    
end
averageMaxDistance = averageMaxDistance / (simNum-1);
title('Distance vs Time')
ylabel('Distance (km)')
xlabel('Time (hours)')
grid on
hold off



%%
%Calculations and plotting of velocity vs time
numLaunch = data(:,1);
time = data(:,2);
lat = data(:,3);
long = data(:,4);
altitude = data(:,5);
altitude = altitude / 1000;
time = time * 0.000277778;
figure(3)
hold on
averageVelocity = 0;
maxVelocity = 0;
t = 1;
time = data(:,2);
for m = 1:simNum-1

    distance = [];
    
    while (t < length(numLaunch) && numLaunch(t) == m)
        [dist1] = lldistkm(latlonStart,[lat(t), long(t)]);
        distance = [distance, dist1];
        t = t + 1;
    end
    velocity = [];
    timeSim = time(numLaunch == m);
    for g = 2:length(distance)-1
        
        velocity = [velocity, (distance(g+1) *1000 - distance(g-1)*1000) / (time(g+1) - time(g-1))];
    end
    mVelocity = mean(velocity);
    maxVelocity1 = max(velocity);
    maxVelocity = maxVelocity + maxVelocity1;
    averageVelocity = averageVelocity + mVelocity;
    timeSim = timeSim(2:end-1);
    C = velocity;
    for y = 1:1000
        C = smoothdata(C,'gaussian',5);
    end
    plot(timeSim * 0.000277778, C)
end
averageVelocity = averageVelocity / (simNum-1);
maxVelocity = maxVelocity / (simNum - 1);
ylim([0 inf])
title('Velocity vs Time')
ylabel('Velocity (m/s)')
xlabel('Time (hours)')
grid on
hold off
%%



    




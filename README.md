# astra-analysis
A tool to analyze simulated data from ASTRA High Altitude Balloon Flight Planner

## Inputs:
- An exported svc data file from [ASTRA High Altitude Balloon Flight Planner](http://astra-planner.soton.ac.uk/). Place this file in the `Astra-Data` folder
- number of simulations that you want to analyze (must be less than the quantity exported from ASTRA)

## Outputs:
- Plots of velocity vs time, altitude vs time, and ground distance vs time
- Outputs:
    - averageMaxAlt: the average max altitude (bursting) (km)
    - averageMaxDistance: the average max distance (landing distance) (km)
    - averageVelocity: the average velocity in the flight relative to the ground (m/s)
    - averageAscentRate: the average ascent acceleration  (m/s^2^)


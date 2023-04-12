% Define the parameters
mRocket = 1000; % mass of rocket (kg)
mFuel = 500; % mass of fuel (kg)
FThrust = 50000; % thrust force (N)
g = 9.81; % gravitational acceleration (m/s^2)
tMax = 100; % maximum simulation time (s)
dt = 0.1; % time step (s)

% Initialize the arrays
t = 0:dt:tMax;
v = zeros(size(t));
x = zeros(size(t));
m = mRocket + mFuel; % initial total mass

% Loop through the time steps
for i = 2:length(t)
    % Calculate acceleration
    if x(i-1) < 10000 % acceleration phase
        a = (FThrust - m*g) / m;
        % Check if fuel tank is still attached
        if m > mRocket % fuel tank is still attached
            m = m - mFuel*dt/10; % decrease mass due to fuel consumption
        end
    else % coasting phase
        a = -g;
    end
    
    % Update the velocity and the position
    v(i) = v(i-1) + a*dt;
    x(i) = x(i-1) + v(i)*dt;
    
    % Stop the simulation if rocket hits the ground
    if x(i) < 0
        break
    end
end

% Plot the results
plot(t(1:i), x(1:i))
xlabel('Time (s)')
ylabel('Position (m)')
title('Rocket Motion')

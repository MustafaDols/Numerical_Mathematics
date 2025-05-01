h = 0.1;
T = 10;
t = 0:h:T;
N = length(t);

y_exact = zeros(1, N);
y_FE = zeros(1, N); % Forward Euler
y_ME = zeros(1, N); % Modified Euler
y_BE = zeros(1, N); % Backward Euler
y_RK2 = zeros(1, N); % Runge-Kutta 2nd order
y_RK3 = zeros(1, N); % Runge-Kutta 3rd order
y_RK4 = zeros(1, N); % Runge-Kutta 4th order
y_AB2 = zeros(1, N); % Adams-Bashforth 2-step
y_AM2 = zeros(1, N); % Adams-Moulton 2-step

y0 = 1;
y_FE(1) = y0;
y_ME(1) = y0;
y_BE(1) = y0;
y_RK2(1) = y0;
y_RK3(1) = y0;
y_RK4(1) = y0;
y_AB2(1) = y0;
y_AM2(1) = y0;

f = @(y, t) -0.5*y + sin(t);

% Forward Euler
for i = 1:N-1
    y_FE(i+1) = y_FE(i) + h * f(y_FE(i), t(i));
end

% Modified Euler
for i = 1:N-1
    y_predictor = y_ME(i) + h * f(y_ME(i), t(i));
    y_ME(i+1) = y_ME(i) + (h/2) * (f(y_ME(i), t(i)) + f(y_predictor, t(i+1)));
end

% Backward Euler
for i = 1:N-1
    y_BE(i+1) = (y_BE(i) + h * sin(t(i+1))) / (1 + 0.5*h);
end

% Runge-Kutta 2nd Order (Midpoint Method)
for i = 1:N-1
    k1 = h * f(y_RK2(i), t(i));
    k2 = h * f(y_RK2(i) + k1/2, t(i) + h/2);
    y_RK2(i+1) = y_RK2(i) + k2;
end

% Runge-Kutta 3rd Order
for i = 1:N-1
    k1 = h * f(y_RK3(i), t(i));
    k2 = h * f(y_RK3(i) + k1/2, t(i) + h/2);
    k3 = h * f(y_RK3(i) - k1 + 2*k2, t(i) + h);
    y_RK3(i+1) = y_RK3(i) + (k1 + 4*k2 + k3)/6;
end

% Runge-Kutta 4th Order
for i = 1:N-1
    k1 = h * f(y_RK4(i), t(i));
    k2 = h * f(y_RK4(i) + k1/2, t(i) + h/2);
    k3 = h * f(y_RK4(i) + k2/2, t(i) + h/2);
    k4 = h * f(y_RK4(i) + k3, t(i) + h);
    y_RK4(i+1) = y_RK4(i) + (k1 + 2*k2 + 2*k3 + k4)/6;
end

% Adams-Bashforth 2-Step (Explicit)
for i = 2:N-1
    y_AB2(i+1) = y_AB2(i) + h * (3/2 * f(y_AB2(i), t(i)) - 1/2 * f(y_AB2(i-1), t(i-1)));
end

% Adams-Moulton 2-Step (Implicit)
for i = 2:N-1
    y_AM2(i+1) = y_AM2(i) + h * (5/12 * f(y_AM2(i+1), t(i+1)) + 8/12 * f(y_AM2(i), t(i)) - 1/12 * f(y_AM2(i-1), t(i-1)));
end

% Exact
for i = 1:N
    y_exact(i) = exp(-0.5*t(i)) + 0.5*(sin(t(i)) - cos(t(i)));
end

figure;
plot(t, y_FE, 'r', 'LineWidth', 1.5); hold on;
plot(t, y_ME, 'b', 'LineWidth', 1.5);
plot(t, y_BE, 'g', 'LineWidth', 1.5);
plot(t, y_RK2, 'y', 'LineWidth', 1.5);
plot(t, y_RK3, 'm', 'LineWidth', 1.5);
plot(t, y_RK4, 'c', 'LineWidth', 1.5);
plot(t, y_AB2, 'k', 'LineWidth', 1.5);
plot(t, y_AM2, 'k-*', 'LineWidth', 1.5);
plot(t, y_exact, 'k-.', 'LineWidth', 1.5);
legend('Forward Euler', 'Modified Euler', 'Backward Euler', 'RK2', 'RK3', 'RK4', 'Adams-Bashforth', 'Adams-Moulton', 'Exact Solution');
xlabel('Time t');
ylabel('Solution y');
title('Comparison of Numerical Methods for ODE Solving');
grid on;


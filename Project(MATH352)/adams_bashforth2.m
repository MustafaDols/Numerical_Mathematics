function y_AB2 = adams_bashforth2(f, y0, t, dt)
    N = length(t);
    y_AB2 = zeros(1, N);
    y_AB2(1) = y0;

    % Initialize using Forward Euler for the first step
    y_AB2(2) = forward_euler(f, y0, t(1:2), dt)(2);

    for i = 2:N-1
        % Adams-Bashforth 2-step method
        y_AB2(i+1) = y_AB2(i) + (dt/2) * (3 * f(y_AB2(i), t(i)) - f(y_AB2(i-1), t(i-1)));
    end
end


function y_FE = forward_euler(f, T0, t, dt)
    N = length(t);
    y_FE = zeros(1, N);
    y_FE(1) = T0;
    for i = 1:N-1
        y_FE(i+1) = y_FE(i) + dt * f(y_FE(i), t(i));
    end
end


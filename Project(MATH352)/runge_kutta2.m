function y_RK2 = runge_kutta2(f, y0, t, dt)
    N = length(t);
    y_RK2 = zeros(1, N);
    y_RK2(1) = y0;

    for i = 1:N-1
        k1 = f(y_RK2(i), t(i));
        k2 = f(y_RK2(i) + dt*k1/2, t(i) + dt/2);
        y_RK2(i+1) = y_RK2(i) + dt * k2;
    end
end


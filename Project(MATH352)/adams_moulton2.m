function y_AM2 = adams_moulton2(f, y0, t, dt)
    N = length(t);
    y_AM2 = zeros(1, N);
    y_AM2(1) = y0;

    % Initialize using Forward Euler for the first step
    y_FE = forward_euler(f, y0, t(1:2), dt); % نحفظ النتيجة هنا
    y_AM2(2) = y_FE(2); % نأخذ القيمة الثانية من النتيجة

    for i = 2:N-1
        % Adams-Moulton 2-step method
        y_AM2(i+1) = y_AM2(i) + (dt/12) * (5 * f(y_AM2(i), t(i)) + 8 * f(y_AM2(i), t(i)) - f(y_AM2(i-1), t(i-1))) / (1 + 5 * dt / 12);
    end
end


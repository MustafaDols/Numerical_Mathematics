function y_ME = modified_euler(f, y0, t, dt)
    N = length(t);
    y_ME = zeros(1, N);
    y_ME(1) = y0;
    for i = 1:N-1
        % التنبؤ بالقيمة التالية
        y_predictor = y_ME(i) + dt * f(y_ME(i), t(i));

        % استخدام التنبؤ لحساب القيمة الجديدة باستخدام الطريقة المعدلة
        y_ME(i+1) = y_ME(i) + (dt/2) * (f(y_ME(i), t(i)) + f(y_predictor, t(i+1)));
    end
end


function y_BE = backward_euler(f, y0, t, dt)
    N = length(t);
    y_BE = zeros(1, N);
    y_BE(1) = y0;

    for i = 1:N-1
        % التقدير الأولي لـ T(i+1) باستخدام T(i)
        T_guess = y_BE(i);

        % حل معادلة Backward Euler باستخدام طريقة نيوتن-رابسون
        max_iter = 100; % أقصى عدد من التكرارات
        tol = 1e-6;     % دقة الحل (المسامحة)

        for iter = 1:max_iter
            % التابع الذي نريد حله
            F = T_guess - y_BE(i) - dt * f(T_guess, t(i+1));
            % المشتقة الأولى (التفاضل)
            dF = 1 - dt * 0.5;

            % تحديث القيمة باستخدام نيوتن-رابسون
            T_new = T_guess - F / dF;

            % إذا كانت القيمة الجديدة قريبة من القيمة القديمة (التقارب)
            if abs(T_new - T_guess) < tol
                break;
            end

            T_guess = T_new;  % التحديث للخطوة التالية
        end

        y_BE(i+1) = T_new;  % تخزين النتيجة النهائية
    end
end


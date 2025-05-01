function newton_cooling_gui

    f = figure('Position', [300 300 600 600], 'Name', 'Newton Cooling Solver', 'NumberTitle', 'off', 'Color', [0.95 0.95 0.95]);

    uicontrol('Style', 'text', 'Position', [50 550 500 30], ...
              'String', 'Temperature Calculation By Newton''s Law of Cooling', ...
              'FontSize', 12, 'FontWeight', 'bold', 'ForegroundColor', [0 0.5 1], 'BackgroundColor', [0.95 0.95 0.95]);

    uicontrol('Style', 'text', 'Position', [50 510 500 30], ...
              'String', 'Choose Method and Enter Parameters', ...
              'FontSize', 14, 'FontWeight', 'bold', 'ForegroundColor', [0.1 0.1 0.1], 'BackgroundColor', [0.95 0.95 0.95]);

    % T0
    uicontrol('Style', 'text', 'Position', [50 460 120 25], 'String', 'Initial T₀:', 'FontSize', 12, 'BackgroundColor', [0.95 0.95 0.95]);
    T0_input = uicontrol('Style', 'edit', 'Position', [170 460 100 25], 'String', '90', 'FontSize', 12, 'BackgroundColor', 'white');
    uicontrol('Style', 'text', 'Position', [280 460 60 25], 'String', '(°C)', 'FontSize', 10, 'BackgroundColor', [0.95 0.95 0.95]);

    % T_env
    uicontrol('Style', 'text', 'Position', [50 420 120 25], 'String', 'Environment Temp:', 'FontSize', 12, 'BackgroundColor', [0.95 0.95 0.95]);
    T_env_input = uicontrol('Style', 'edit', 'Position', [170 420 100 25], 'String', '25', 'FontSize', 12, 'BackgroundColor', 'white');
    uicontrol('Style', 'text', 'Position', [280 420 60 25], 'String', '(°C)', 'FontSize', 10, 'BackgroundColor', [0.95 0.95 0.95]);

    % k
    uicontrol('Style', 'text', 'Position', [50 380 120 25], 'String', 'Cooling constant(k):', 'FontSize', 12, 'BackgroundColor', [0.95 0.95 0.95]);
    k_input = uicontrol('Style', 'edit', 'Position', [170 380 100 25], 'String', '0.1', 'FontSize', 12, 'BackgroundColor', 'white');
    uicontrol('Style', 'text', 'Position', [280 380 60 25], 'String', '(1/min)', 'FontSize', 10, 'BackgroundColor', [0.95 0.95 0.95]);

    % t_final
    uicontrol('Style', 'text', 'Position', [50 340 120 25], 'String', 'Final Time (t_final):', 'FontSize', 12, 'BackgroundColor', [0.95 0.95 0.95]);
    t_final_input = uicontrol('Style', 'edit', 'Position', [170 340 100 25], 'String', '10', 'FontSize', 12, 'BackgroundColor', 'white');
    uicontrol('Style', 'text', 'Position', [280 340 60 25], 'String', '(min)', 'FontSize', 10, 'BackgroundColor', [0.95 0.95 0.95]);

    % result box
    result_box = uicontrol('Style', 'text', 'Position', [50 290 500 30], ...
                           'HorizontalAlignment', 'left', ...
                           'BackgroundColor', [1 1 1], ...
                           'FontSize', 12, ...
                           'FontWeight', 'bold', ...
                           'ForegroundColor', [0.2 0.6 0.2], ...
                           'String', 'Result will appear here');

    y_pos = 240;
    methods = {'Forward Euler', 'Modified Euler', 'Backward Euler', ...
               'RK2', 'RK4', 'Adams-Bashforth', 'Adams-Moulton', 'Exact Solution'};

    for i = 1:length(methods)
        uicontrol('Style', 'pushbutton', ...
                  'Position', [50 + mod(i-1,2)*250, y_pos, 200, 40], ...
                  'String', methods{i}, ...
                  'FontSize', 12, ...
                  'BackgroundColor', [0.1 0.6 0.1], ...
                  'ForegroundColor', 'white', ...
                  'Callback', @(~,~) solve_method(methods{i}, T0_input, T_env_input, k_input, t_final_input, result_box));
        if mod(i,2) == 0
            y_pos = y_pos - 50;
        end
    end
end

% دالة الحل المرتبطة بكل زر
function solve_method(method, T0_input, T_env_input, k_input, t_final_input, result_box)
    dt = 0.1;
    T_max = str2double(get(t_final_input, 'String'));
    t = 0:dt:T_max;

    T0 = str2double(get(T0_input, 'String'));
    T_env = str2double(get(T_env_input, 'String'));
    k = str2double(get(k_input, 'String'));

    f = @(T, t) -k * (T - T_env);

    switch method
        case 'Exact Solution'
            y = T_env + (T0 - T_env) * exp(-k * t);
        case 'Forward Euler'
            y = forward_euler(f, T0, t, dt);
        case 'Modified Euler'
            y = modified_euler(f, T0, t, dt);
        case 'Backward Euler'
            y = backward_euler(f, T0, t, dt);
        case 'RK2'
            y = runge_kutta2(f, T0, t, dt);
        case 'RK4'
            y = runge_kutta4(f, T0, t, dt);
        case 'Adams-Bashforth'
            y = adams_bashforth2(f, T0, t, dt);
        case 'Adams-Moulton'
            y = adams_moulton2(f, T0, t, dt);
        otherwise
            y = NaN(size(t));
    end

    result_text = sprintf('%s: Final T(%.1f) = %.2f °C', method, t(end), y(end));
    set(result_box, 'String', result_text);

    figure('Name', method);
    plot(t, y, '--', 'LineWidth', 2);
    xlabel('Time (min)');
    ylabel('Temperature (°C)');
    title(['Solution using ', method]);
    legend({method}, 'Location', 'best');
    grid on;
end


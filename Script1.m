% Given data points
x = [0; 1; 2];
y = [1; -1; -2];

% Using MATLAB's polyfit function for linear regression
coefficients = polyfit(x, y, 1);
slope = coefficients(1);
y_intercept = coefficients(2);

% Predicted y values based on the regression
y_pred = slope * x + y_intercept;

% Visualization
figure;
plot(x, y, 'o', 'MarkerSize', 8, 'MarkerEdgeColor', 'red', 'MarkerFaceColor', 'red'); % Original data points
hold on;
plot(x, y_pred, '-b', 'LineWidth', 2); % Regression line
xlabel('X');
ylabel('Y');
title('Simple Linear Regression');
legend('Given Data Points', 'Best Fit Line');
grid on;

% Load the data
data = csvread('sdata.csv');

% Center the data (make it zero mean)
mean_data = mean(data, 1);
centered_data = data - mean_data;

% Perform SVD on the centered data
[U, S, V] = svd(centered_data, 'econ');

% The principal direction is the first right singular vector
principal_direction = V(:,1);

% a) Plot the data and the approximating line
figure;
scatter3(centered_data(:,1), centered_data(:,2), centered_data(:,3), 'b.');
hold on;
% Create points for the line (extending the line beyond the data range for visualization)
t = linspace(min(centered_data * principal_direction), max(centered_data * principal_direction), 100);
line_points = t' * principal_direction';
plot3(line_points(:,1), line_points(:,2), line_points(:,3), 'r', 'LineWidth', 2);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Data and Best Approximating Line');
legend('Data', 'Best Approximating Line');
grid on;

% b) Convert (x, y, z) to w and vice versa
w = centered_data * principal_direction;

% c) Histogram of the w_i values
figure;
histogram(w, 20);
xlabel('w_i values');
ylabel('Frequency');
title('Histogram of w_i values');
grid on;

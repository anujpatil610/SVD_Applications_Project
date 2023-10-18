% Define the transformation matrix
matrix_A = [3 -2; -1 5];

% Generate coordinates for the unit circle
theta = linspace(0, 2*pi, 100);
circle_x_coord = cos(theta);
circle_y_coord = sin(theta);
circle_points = [circle_x_coord; circle_y_coord];

% Transform the unit circle using matrix A
ellipse_coords = matrix_A * circle_points;

% Compute SVD for matrix A
[U_matrix, Sigma_matrix, ~] = svd(matrix_A);

% Determine the scaled singular vectors
scaled_U_matrix = U_matrix * Sigma_matrix;

% Visualization
figure;
plot(circle_x_coord, circle_y_coord, 'k--', 'LineWidth', 1);  % Displaying unit circle in dashed black
hold on;
plot(ellipse_coords(1,:), ellipse_coords(2,:), 'b-', 'LineWidth', 1.5);
quiver(0, 0, scaled_U_matrix(1, 1), scaled_U_matrix(2, 1), 'r', 'LineWidth', 1.5, 'MaxHeadSize', 0.5);
quiver(0, 0, scaled_U_matrix(1, 2), scaled_U_matrix(2, 2), 'g', 'LineWidth', 1.5, 'MaxHeadSize', 0.5);
xlabel('Horizontal Coordinate (X)');
ylabel('Vertical Coordinate (Y)');
title('Unit Circle, Its Transformation, and Principal Directions');
legend('Unit Circle', 'Transformed Ellipse', 'Principal Direction 1', 'Principal Direction 2');
axis equal;
grid on;

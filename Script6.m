% Eigenface analysis

% Load all images from the provided directories
nonsmiling_dir = 'nonsmiling_cropped';
smiling_dir = 'smiling_cropped';

nonsmiling_files = dir(fullfile(nonsmiling_dir, '*.jpg')); % Assuming JPEG images, change extension if needed
smiling_files = dir(fullfile(smiling_dir, '*.jpg'));

% Decide on a standard size based on the first image in nonsmiling_files
reference_image = imread(fullfile(nonsmiling_dir, nonsmiling_files(1).name));
standard_size = size(reference_image);

% Convert each image to grayscale, resize to standard size, and flatten
num_images = length(nonsmiling_files) + length(smiling_files);
flat_size = prod(standard_size(1:2));

all_data = zeros(num_images, flat_size);

for i = 1:length(nonsmiling_files)
    img = imread(fullfile(nonsmiling_dir, nonsmiling_files(i).name));
    gray_img = rgb2gray(img);
    resized_img = imresize(gray_img, standard_size(1:2));
    all_data(i, :) = resized_img(:)';
end

for i = 1:length(smiling_files)
    img = imread(fullfile(smiling_dir, smiling_files(i).name));
    gray_img = rgb2gray(img);
    resized_img = imresize(gray_img, standard_size(1:2));
    all_data(length(nonsmiling_files) + i, :) = resized_img(:)';
end

% Normalize the data by subtracting the mean face
mean_face = mean(all_data, 1);
all_data = all_data - repmat(mean_face, size(all_data, 1), 1);

% Compute the covariance matrix of the normalized data
cov_matrix = cov(all_data);

% Compute the eigenvectors and eigenvalues of the covariance matrix
[V, D] = eig(cov_matrix);
eigenvalues = diag(D);

% Sort eigenvectors based on eigenvalues
[eigenvalues, order] = sort(eigenvalues, 'descend');
V = V(:, order);

% Display the top few eigenfaces and their associated eigenvalues
num_eigenfaces_to_display = 5; % Change this number as needed

figure;
for i = 1:num_eigenfaces_to_display
    subplot(2, num_eigenfaces_to_display, i);
    eigenface = reshape(V(:, i), standard_size(1:2));
    imshow(mat2gray(eigenface));
    title_str = ['Eigenface ' num2str(i)];
    title(title_str, 'Position', [standard_size(2)/2, -20]);
    
    subplot(2, num_eigenfaces_to_display, i + num_eigenfaces_to_display);
    bar(eigenvalues(i));
    ylabel('Eigenvalue');
    title_str = [ num2str(i)];
    title(title_str, 'Position', [1, 1.1*eigenvalues(i)]);
end




% This Program is to Process the Images from the Dataset Folder and Save them in the Output Folder, for the Final Project Submission.

% Step 1: Specify the File Paths to the Images:

normal_images = dir('C:\Users\yatis\OneDrive\Desktop\HAP 797\Project\Dataset\Normal\*.png');
benign_images = dir('C:\Users\yatis\OneDrive\Desktop\HAP 797\Project\Dataset\Benign\*.png');
malignant_images = dir('C:\Users\yatis\OneDrive\Desktop\HAP 797\Project\Dataset\Malignant\*.png');

% Step 2: Specify the Main Output Directory:

main_output_directory = 'C:\Users\yatis\OneDrive\Desktop\HAP 797\Project\Output\';

% Step 3: Set the Desired Size for the Resized Images:

SIZE = 256;

% Step 4: Process the Normal Images:

process_images(normal_images, 'Normal', main_output_directory, SIZE, false);

% Step 5: Manually Process the Benign Images:

process_images_manually(benign_images, 'Benign', main_output_directory, SIZE);

% Step 6: Manually Process the Malignant Images:

process_images_manually(malignant_images, 'Malignant', main_output_directory, SIZE);

% Step 7: Display the Process Completion Message:

disp('Segmentation is Complete.');

% Step 8: The Function to Process the Images:

function process_images(images, label, main_output_directory, SIZE, outline_tumor)
    for i = 1:length(images)
        try

            % Step 8.1: Skip the Hidden and System Files:

            if images(i).name(1) == '.'
                continue;
            end

            % Step 8.2: Display the Name of the Current File for Debugging:

            disp(['Processing the ' label ' Image: ' images(i).name]);

            % Step 8.3: Construct the Full File Path:

            file_path = fullfile(['C:\Users\yatis\OneDrive\Desktop\HAP 797\Project\Dataset\' label '\'], images(i).name);

            % Step 8.4: Load the Image:

            img = load_image(file_path, SIZE);

            % Step 8.5: Create a Binary Mask based on a Simple Threshold:

            binary_mask = imbinarize(rgb2gray(img), graythresh(rgb2gray(img)));

            % Step 8.6: Invert the Binary Mask:

            binary_mask = ~binary_mask;

            % Step 8.7: If the "outline_tumor" is True, then Apply the Morphological Operations:

            if outline_tumor
                se = strel('disk', 5);
                binary_mask = imclose(binary_mask, se);
                binary_mask = imfill(binary_mask, 'holes');
            end

            % Step 8.8: Create the Output Directory if it does not Exist:

            output_directory = fullfile(main_output_directory, label);
            if ~exist(output_directory, 'dir')
                mkdir(output_directory);
            end

            % Step 8.9: Save the Binary Mask:

            imwrite(binary_mask, fullfile(output_directory, [label '_' num2str(i) '_Mask.png']));
        catch exception

            % Step 8.10: Display the Error Message, if any, and Continue to Process the Other Images:

            disp(['Error in Processing the Image: ' file_path]);
            disp(['Error Message: ' exception.message]);

        end
    end
end

% Step 9: The Function to Load and Resize the Image:

function img = load_image(image, SIZE)
    img = imresize(im2double(imread(image)), [SIZE, SIZE]);
end

% Step 10: The Function to Manually Process the Images:

function process_images_manually(images, label, main_output_directory, SIZE)
    for i = 1:length(images)
        try

            % Step 10.1: Skip the Hidden and System Files:

            if images(i).name(1) == '.'
                continue;
            end

            % Step 10.2: Display the Name of the Current File for Debugging:

            disp(['Processing the ' label ' Image: ' images(i).name]);

            % Step 10.3: Construct the Full File Path:

            file_path = fullfile(['C:\Users\yatis\OneDrive\Desktop\HAP 797\Project\Dataset\' label '\'], images(i).name);

            % Step 10.4: Load the Image:

            img = load_image(file_path, SIZE);

            % Step 10.5: Display the Image:

            figure;
            imshow(img);
            title(['Manually Outline the Tumor Region in ' label ' Image: ' images(i).name]);

            % Step 10.6: Allow the User to Draw Multiple Freehand ROIs:

            h = imfreehand('Closed', false);

            % Step 10.7: Create a Binary Mask from the Drawn ROIs:

            binary_mask = createMask(h);

            % Step 10.8: Close the Figure:

            close;

            % Step 10.9: Create the Output Directory if it does not Exist:

            output_directory = fullfile(main_output_directory, label);
            if ~exist(output_directory, 'dir')
                mkdir(output_directory);
            end

            % Step 10.10: Save the Binary Mask:

            imwrite(binary_mask, fullfile(output_directory, [label '_' num2str(i) '_Mask.png']));
        catch exception

            % Step 10.11: Display the Error Message, if any, and Continue to Process the Other Images:

            disp(['Error in Processing the Image: ' file_path]);
            disp(['Error Message: ' exception.message]);

        end
    end
end

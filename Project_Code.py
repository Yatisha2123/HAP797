# This Program is to Clean the Raw Data and Transfer it to the Dataset Folder, for the Final Project Submission.

# Step 1: Import the Required Libraries:

import os
import shutil

# Step 2: Define Function to Copy the PNG Files from the Source Directory to a Destination Directory:

def copy_png_files(src, dest):
    for root, dirs, files in os.walk(src):
        for file in files:
            if file.endswith(".png") and not file.endswith("_Mask.png"):
                source_path = os.path.join(root, file)
                dest_folder = os.path.join(dest, os.path.basename(os.path.dirname(source_path)))
                dest_path = os.path.join(dest_folder, file)

                if not os.path.exists(dest_folder):
                    os.makedirs(dest_folder)

                shutil.copyfile(source_path, dest_path)
                print(f"Copied: {file} to {os.path.basename(os.path.dirname(source_path))}")

# Step 3: Define Function to Count the Number of PNG Images in Each Subdirectory of the Main Directory:

def count_images(main_dir, subdirectories):
    for subdir in subdirectories:
        subdir_path = os.path.join(main_dir, subdir)
        if os.path.exists(subdir_path):
            images = [file for file in os.listdir(subdir_path) if file.endswith(".png")]
            num_images = len(images)
            print(f"Number of Images in {subdir}: {num_images}")
        else:
            print(f"The directory {subdir} does not exist.")

# Step 4: Define Function to Count the Total Number of PNG Images in All Subdirectories of the Main Directory:

def count_total_images(main_dir, subdirectories):
    total_images = 0
    for subdir in subdirectories:
        subdir_path = os.path.join(main_dir, subdir)
        if os.path.exists(subdir_path):
            images = [file for file in os.listdir(subdir_path) if file.endswith(".png")]
            total_images += len(images)
        else:
            print(f"The directory {subdir} does not exist.")
    return total_images

# Step 5: Execute the Main Code:

if __name__ == "__main__":

    # Step 5.1: Define the File Paths:
    
    source_dir = "C:\\Users\\yatis\\OneDrive\\Desktop\\HAP 797\\Project\\Raw Data"
    destination_dir = "C:\\Users\\yatis\\OneDrive\\Desktop\\HAP 797\\Project\\Dataset"

    # Step 5.2: Ensure that the Destination Directory Exists, otherwise Create the File:
    
    if not os.path.exists(destination_dir):
        os.makedirs(destination_dir)

    # Step 5.3: Copy the PNG Files into the Normal, Benign and Malignant Directories:
    
    copy_png_files(source_dir, destination_dir)

    # Step 5.4: Count the Number of Images in Each Subdirectory:
    
    main_dir = "C:\\Users\\yatis\\OneDrive\\Desktop\\HAP 797\\Project\\Dataset"
    subdirectories = ["Normal", "Benign", "Malignant"]
    count_images(main_dir, subdirectories)

    # Step 5.5: Count the Total Number of Images in All Subdirectories:
    
    total_images_count = count_total_images(main_dir, subdirectories)
    print(f"Total Number of Images in All Subdirectories: {total_images_count}")

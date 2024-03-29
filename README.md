
README

Project: Red Traffic Light Detection

Description:

This project aims to detect red traffic lights in videos, during MSc at ENSTA Paris. The process involves analyzing each frame of the video to identify red traffic lights accurately. Initially, the video is segmented into individual frames, and then various color and pixel spaces are explored to determine the one that best separates the red color. Strategies are implemented to minimize false positives, considering characteristics such as the stationary nature of traffic lights, their typical placement at the horizon, and their rounded shape.

Features:

Video segmentation into individual frames.
Analysis of different color and pixel spaces to optimize red color detection.
Implementation of strategies to minimize false positives, considering traffic light characteristics.
Training performed on a single video due to limitations.
Some false positives may occur.
Requirement of additional images to verify persistence.

Instructions for Use:

Provide the video file to be analyzed for red traffic light detection.
Execute the program to initiate the segmentation and analysis process.
Review the results for detected traffic lights and verify accuracy.
If necessary, adjust parameters or implement additional strategies to minimize false positives.
Consider additional training with more diverse datasets for improved performance.

Limitations:

Training performed on a single video may limit the model's generalization ability.
Occasional false positives may occur due to variations in lighting conditions or other factors.
Additional images are required to validate the persistence of detected traffic lights.

Future Improvements:

Incorporate machine learning techniques for more robust detection.
Expand the training dataset to improve model performance.
Implement real-time detection capabilities for practical applications.

Contributing:Thomas Niel and myself.
Contributions to improving the project are welcome. Please submit pull requests or reach out to [contact information] for collaboration.

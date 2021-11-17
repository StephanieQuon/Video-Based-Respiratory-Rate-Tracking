# Motion-Based Respiratory Rate Tracking for Infants in Low Resource Settings

**ELEC 499 - Electrical Engineering Undergraduate Thesis** 

Background: Each year, about four million infants worldwide die of severe illnesses in their first month. Chances of survival greatly increase if critical conditions are promptly treated. However, recognizing early warning signs can be difficult, especially in low-resource settings lacking monitoring technology. Therefore, we need accessible, reliable, and low-cost devices that can help identify sick infants.

Objective: The objective of this project was to develop a computer algorithm that automatically measures respiratory rate from videos of infants captured using a smartphone. This algorithm was designed to work from videos containing motion artifacts and taken in varied lighting conditions.

Methods: In a study, 59 videos were captured from infants <3 months of age at Kamuzu Central Hospital in Malawi, East Africa. To facilitate respiratory rate tracking, 5 small (<0.5 cm) yellow stickers were applied on the infant’s forehead (x1), chest (x2), abdomen (x2). The algorithm, implemented in MATLAB, used a combination of signal processing, computer vision, and machine learning techniques to extract respiratory rate. This algorithm was trained to automatically identify stickers with >15,000 labelled images. Accuracy was determined by comparing algorithm output values to visually determined respiratory rate.

Results: The algorithm succeeded in video stabilization, automatically tracking sticker positions, and accurately determining respiratory rate from vertical and horizontal sticker movement. 

Conclusion: The preliminary results from this algorithm show we have a feasible method of accurately measuring respiratory rate under real-life video acquisition conditions in low-resource settings. To formally determine the accuracy of the algorithm, it will be tested on additional videos. The algorithm will also be extended to recognize abnormal breathing patterns, such as paradoxical breathing and apnea.


# To use this code
Requirements: MATLAB R2020a, video with body clearly in frame (suggested minimum 10 seconds, named input_video.mp4) 

**Step 1: Stabilize the video** 
1. Download stabilze.m, and put it into the same directory in MATLAB along with the video 
3. Open stabilize.m and run the script, wait until it finishes 

**Step 2: Semantic Segmentation** 
1. Download final_tracking_alg.m and open the script in MATLAB
2. Drag your video file to the same folder the .m file is located
3. Press "run", estimates should print in the MATLAB terminal 


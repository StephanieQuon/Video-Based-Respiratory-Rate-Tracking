## ELEC 499A Electrical Engineering Undergraduate Thesis: Smartphone Video-Based Respiratory Rate Tracking for Infants

Innovative digital health technologies present an opportunity to create affordable, sustainable, and scalable monitoring technology to expand access to care in low-income and middle-income countries. This study aims to develop a computer algorithm that automatically measures respiratory rate from videos of infants captured using a smartphone. Given the gaps identified in previous research, this project focuses specifically on using smartphone video data taken in environments that contain lighting variations, with handheld videos containing movement artifacts. For this study, 57 videos were captured from 39 infants <3 months of age at Kamuzu Central Hospital in Malawi, East Africa. To facilitate respiratory rate tracking, 5 small paper stickers were applied on the infant’s skin. Using MATLAB, algorithms were developed to identify stickers on the infants’, track sticker movement from respiratory rate, and estimate breath count. This study indicated that non-contact respiratory rate monitoring for infants could be an effective method of accurately estimating respiratory rate using smartphone videos with lighting variations and movement artifacts. However, given the high accuracy and reliability required for effective monitoring tools, the current methods developed require further development to be successful. Overall, the results of this study aligned with previous research, as lighting variation and movement artifacts presented as major technical challenges. 

Full paper available [here](https://drive.google.com/file/d/1evjSCbb4h4yJbcWMRPWwbopwXDUDVz9E/view?usp=sharing)

### To use this code
Requirements: MATLAB R2020a or later version, video with body clearly in frame named input_video.mp4 (recommended minimum 10 seconds)

**Step 1: Stabilize the video** 
1. Download stabilize.m, and put it into the same directory in MATLAB along with the video 
3. Open stabilize.m and run the script, wait until it finishes 

**Step 2: Run the desired tracking algorithm** 

***Algorithm: Select Stickers + Sticker Tracking***
* The use of this algorithm requires 4 stickers be placed on the person's chest and 1 placed on their forehead
1. Download select_sticker_tracking.m and open the script in MATLAB.
2. Drag your video file to the same folder the .m file is located.
3. Press "run", estimates should print in the MATLAB terminal and figures should open.
4. When the MATLAB figure window opens, it will prompt the selection of a region of interest. Left click to draw a box starting at the corner, and drag and release to form the box around each sticker. Select the boxes in the following order: (1) forehead sticker, (2) top left chest sticker, (3) top right chest sticker, (4) bottom left chest sticker, (5) bottom right chest sticker. 

***Algorithm: Automatic Sticker Detection + Sticker Tracking*** 
* The use of this algorithm requires 4 yellow stickers be placed on the person's chest and 1 placed on their forehead
1. Download automatic_sticker_tracking.m and open the script in MATLAB. Download trained_model_sticker.xml to the same directory of select_sticker_tracking.m.
2. Drag your video file to the same folder the .m file is located.
3. Press "run", estimates should print in the MATLAB terminal and figures should open.
4. When the MATLAB figure window opens, it will prompt the selection of a region of interest. Left click to draw a box starting at the corner, and drag and release to form a box around the chest region of the person in the video. 

**Step 3: Run the signal quality index** 
1. Download final_breathcount.m and open the script in MATLAB.
2. Press "run", estimates should print in the MATLAB terminal.

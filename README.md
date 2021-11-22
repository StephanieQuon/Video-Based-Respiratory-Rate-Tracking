# Motion-Based Respiratory Rate Tracking for Infants in Low Resource Settings

**ELEC 499 - Electrical Engineering Undergraduate Thesis** 

[add abstract]


# To use this code
Requirements: MATLAB R2020a or later version, video with body clearly in frame named input_video.mp4 (recommended minimum 10 seconds)

**Step 1: Stabilize the video** 
1. Download stabilze.m, and put it into the same directory in MATLAB along with the video 
3. Open stabilize.m and run the script, wait until it finishes 

**Step 2: Run your desired algorim** 

***Algorithm: Select Chest + Optical Flow***
1. Download select_optical_flow.m and open the script in MATLAB
2. Drag your video file to the same folder the .m file is located
3. Press "run", estimates should print in the MATLAB terminal 

***Algorithm: Automatic Chest Detection + Optical Flow***
1. Download automatic_optical_flow.m and open the script in MATLAB
2. Drag your video file to the same folder the .m file is located
3. Press "run", estimates should print in the MATLAB terminal 

***Algorithm: Select Stickers + Sticker Tracking***
* The use of this algorithm requires 4 stickers be placed on the person's chest and 1 placed on their forehead
1. Download select_sticker_tracking.m and open the script in MATLAB
2. Drag your video file to the same folder the .m file is located
3. Press "run", estimates should print in the MATLAB terminal 

***Algorithm: Automatic Sticker Detection + Sticker Tracking*** 
* The use of this algorithm requires 4 yellow stickers be placed on the person's chest and 1 placed on their forehead
1. Download automatic_sticker_tracking.m and open the script in MATLAB
2. Drag your video file to the same folder the .m file is located
3. Press "run", estimates should print in the MATLAB terminal 


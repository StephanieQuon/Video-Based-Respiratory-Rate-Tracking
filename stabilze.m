%% TAKEN FROM: www.mathworks.com/help/vision/ug/video-stabilization-using-point-feature-matching.html

%% ------------------------------- Setup ----------------------------------
vidStable('id_CSS027_1 copy.mp4', 'CSS027_1_stb');

%% --------------------------- Stabilize Video ----------------------------

function vidStable(videoinputname, videooutputname)

videoBW = VideoReader(videoinputname);
videoCL = VideoReader(videoinputname);

outputvideo = VideoWriter(videooutputname, 'MPEG-4');
open(outputvideo);

read(videoBW, 1);
hVPlayer = vision.VideoPlayer; 

movMean = rgb2gray(im2single(readFrame(videoBW)));
imgB = movMean;
imgBp = imgB;
correctedMean = imgBp;
ii = 2;
Hcumulative = eye(3);

while hasFrame(videoBW)
    imgA = imgB; 
    imgAp = imgBp; 
    imgB = rgb2gray(im2single(readFrame(videoBW)));
    imgBColour = readFrame(videoCL);
    movMean = movMean + imgB;

    H = cvexEstStabilizationTform(imgA,imgB);
    HsRt = cvexTformToSRT(H);
    Hcumulative = HsRt * Hcumulative;
    imgBp = imwarp(imgB,affine2d(Hcumulative),'OutputView',imref2d(size(imgB)));
    imgVideo = imwarp(imgBColour,affine2d(Hcumulative),'OutputView',imref2d(size(imgB)));

    step(hVPlayer, imfuse(imgAp,imgBp,'ColorChannels','red-cyan'));
    correctedMean = correctedMean + imgBp;
    
    writeVideo(outputvideo, imgVideo);
end

release(hVPlayer);
close(outputvideo);
end

%% ------------------------ Supporting Functions --------------------------
function H = cvexEstStabilizationTform(leftI,rightI,ptThresh)
if nargin < 3 || isempty(ptThresh)
    ptThresh = 0.1;
end

pointsA = detectMinEigenFeatures(leftI, 'MinQuality', ptThresh);
pointsB = detectMinEigenFeatures(rightI, 'MinQuality', ptThresh);

[featuresA, pointsA] = extractFeatures(leftI, pointsA);
[featuresB, pointsB] = extractFeatures(rightI, pointsB);

indexPairs = matchFeatures(featuresA, featuresB);
pointsA = pointsA(indexPairs(:, 1), :);
pointsB = pointsB(indexPairs(:, 2), :);

tform = estimateGeometricTransform(pointsB, pointsA, 'affine');
H = tform.T;
end

function [H,s,ang,t,R] = cvexTformToSRT(H)

R = H(1:2,1:2);
t = H(3, 1:2);

ang = mean([atan2(R(2),R(1)) atan2(-R(3),R(4))]);
s = mean(R([1 4])/cos(ang));
R = [cos(ang) -sin(ang); sin(ang) cos(ang)];
H = [[s*R; t], [0 0 1]'];
end



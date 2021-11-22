video = 'input_video_stb.mp4';
vid = VideoReader(video);
nframes = vid.NumFrames;
nstickers = 5;

vertsignal = zeros(nframes - 1, nstickers);
horisignal = zeros(nframes - 1, nstickers);

video_obj = VideoWriter('KLTvideo', 'MPEG-4');
open(video_obj);

t = 1;

objectFrame = readFrame(vid);
figure; imshow(objectFrame); 

forehead = round(getPosition(imrect));
FHpoints = detectMinEigenFeatures(rgb2gray(objectFrame),'ROI',forehead);

tracker = vision.PointTracker('MaxBidirectionalError',1);
initialize(tracker,FHpoints.Location,objectFrame);
r = 1;
while hasFrame(vid)
      frame = readFrame(vid);
      [points,validity] = tracker(frame);
      out = insertMarker(frame,points(validity, :),'+');
      vertsignal(r, t) = points(1,1);
      horisignal(r, t) = points(1,2);
      writeVideo(video_obj, out);
      r = r + 1;
end
t = t + 1;

vid = VideoReader(video);
objectFrame = readFrame(vid);
figure; imshow(objectFrame); 

topleft = round(getPosition(imrect)); 
TLpoints = detectMinEigenFeatures(rgb2gray(objectFrame),'ROI',topleft);

tracker = vision.PointTracker('MaxBidirectionalError',1);
initialize(tracker,TLpoints.Location,objectFrame);
r = 1;
while hasFrame(vid)
      frame = readFrame(vid);
      [points,validity] = tracker(frame);
      out = insertMarker(frame,points(validity, :),'+');
      vertsignal(r, t) = points(1,1);
      horisignal(r, t) = points(1,2);
      writeVideo(video_obj, out);
      r = r + 1;
end
t = t + 1;

vid = VideoReader(video);
objectFrame = readFrame(vid);
figure; imshow(objectFrame); 

topright = round(getPosition(imrect));
TRpoints = detectMinEigenFeatures(rgb2gray(objectFrame),'ROI',topright);

tracker = vision.PointTracker('MaxBidirectionalError',1);
initialize(tracker,TRpoints.Location,objectFrame);
r = 1;
while hasFrame(vid)
      frame = readFrame(vid);
      [points,validity] = tracker(frame);
      out = insertMarker(frame,points(validity, :),'+');
      vertsignal(r, t) = points(1,1);
      horisignal(r, t) = points(1,2);
      writeVideo(video_obj, out);
      r = r + 1;
end
t = t + 1;

vid = VideoReader(video);
objectFrame = readFrame(vid);
figure; imshow(objectFrame); 

bottomleft = round(getPosition(imrect));
BLpoints = detectMinEigenFeatures(rgb2gray(objectFrame),'ROI',bottomleft);

tracker = vision.PointTracker('MaxBidirectionalError',1);
initialize(tracker,BLpoints.Location,objectFrame);
r = 1;
while hasFrame(vid)
      frame = readFrame(vid);
      [points,validity] = tracker(frame);
      out = insertMarker(frame,points(validity, :),'+');
      vertsignal(r, t) = points(1,1);
      horisignal(r, t) = points(1,2);
      writeVideo(video_obj, out);
      r = r + 1;
end
t = t + 1;

vid = VideoReader(video);
objectFrame = readFrame(vid);
figure; imshow(objectFrame); 

bottomright = round(getPosition(imrect));
BRpoints = detectMinEigenFeatures(rgb2gray(objectFrame),'ROI',bottomright);

tracker = vision.PointTracker('MaxBidirectionalError',1);
initialize(tracker,BRpoints.Location,objectFrame);
r = 1;
while hasFrame(vid)
      frame = readFrame(vid);
      [points,validity] = tracker(frame);
      out = insertMarker(frame,points(validity, :),'+');
      vertsignal(r, t) = points(1,1);
      horisignal(r, t) = points(1,2);
      writeVideo(video_obj, out);
      r = r + 1;
end
t = t + 1;

close(video_obj);

plot_verticalsignalraw = vertsignal;
plot_horizontalsignalraw = horisignal;

plot_VSfhRem = zeros(nframes - 1, 4);
plot_VSfhRem(:,1) =  vertsignal(:,2) - vertsignal(:,1);
plot_VSfhRem(:,2) =  vertsignal(:,3) - vertsignal(:,1);
plot_VSfhRem(:,3) =  vertsignal(:,4) - vertsignal(:,1);
plot_VSfhRem(:,4) =  vertsignal(:,5) - vertsignal(:,1);

plot_HSfhRem = zeros(nframes - 1, 4);
plot_HSfhRem(:, 1) = horisignal(:,2) - horisignal(:,1);
plot_HSfhRem(:, 2) = horisignal(:,3) - horisignal(:,1);
plot_HSfhRem(:, 3) = horisignal(:,4) - horisignal(:,1);
plot_HSfhRem(:, 4) = horisignal(:,5) - horisignal(:,1);

plot_VSaddist = zeros(nframes - 1, 2) ;
plot_VSaddist(:,1) = plot_VSfhRem(:,1) + plot_VSfhRem(:,2);
plot_VSaddist(:,2) = plot_VSfhRem(:,3) + plot_VSfhRem(:,4);

plot_HSaddist = zeros(nframes - 1, 2) ;
plot_HSaddist(:,1) = plot_HSfhRem(:,1) + plot_HSfhRem(:,2);
plot_HSaddist(:,2) = plot_HSfhRem(:,3) + plot_HSfhRem(:,4);

% Vertical signal - Raw
rawVerticalSignal = figure;
figure(rawVerticalSignal)
plot(plot_verticalsignalraw)
ylabel('X-Coordinate of Sticker'); xlabel('Frame Number');
title('X-Coordinate of Sticker vs. Frame Number - Raw Data');
legend('Forehead','Top Left','Top Right', 'Bottom Left', 'Bottom Right', 'location','best');

% Vertical signal - Forehead removed and smoothed
fhRemovedSmoothedVerticalSignal = figure;
figure(fhRemovedSmoothedVerticalSignal)

smoothedverticalT = smooth(plot_VSaddist(:,1), 15);
smoothedverticalB = smooth(plot_VSaddist(:,2), 15);
pks = findpeaks(smoothedverticalT, 1, 'MinPeakProminence', 1);
breaths_horizontal_left = numel(pks)
pks = findpeaks(smoothedverticalB, 1, 'MinPeakProminence', 1);
breaths_horizontal_right = numel(pks)

hold on
plot(plot_VSaddist(:,1), 'color', '#D95319')
plot(plot_VSaddist(:,2), 'color', '#0072BD')
plot(smoothedverticalT, 'color', 'k', 'LineWidth', 1.5) 
plot(smoothedverticalB, 'color', 'k', 'LineWidth', 1.5) 
findpeaks(smoothedverticalT, 1, 'MinPeakProminence', 1)
findpeaks(smoothedverticalB, 1, 'MinPeakProminence', 1)
hold off

ylabel('Horizontal Movement of Sticker'); xlabel('Frame Number');
title(['Horizontal Movement of Sticker vs. Frame Number - ' ...
    'Forehead Signal Removed, Sides Added, Smoothed'])
legend('Left','Right','location','best');

% Horizontal signal - Raw 
rawHorizontalSignal = figure;
figure(rawHorizontalSignal)
plot(plot_horizontalsignalraw)
ylabel('Y-Coordinate of Sticker')
xlabel('Frame Number')
title('Y-Coordinate of Sticker vs. Frame Number - Raw Data')
legend('Forehead','Top Left','Top Right', 'Bottom Left', 'Bottom Right', 'location','best');

% Horizontal signal - Forehead removed and smoothed
fhRemovedSmoothedVerticalSignal = figure;
figure(fhRemovedSmoothedVerticalSignal)

smoothedhorizontalL = smooth(plot_HSaddist(:,1), 15);
smoothedhorizontalR = smooth(plot_HSaddist(:,2), 15);
pks = findpeaks(smoothedhorizontalL, 1, 'MinPeakProminence', 1);
breaths_vertical_top = numel(pks)
pks = findpeaks(smoothedhorizontalR, 1, 'MinPeakProminence', 1);
breaths_vertical_bottom = numel(pks)

hold on
plot(plot_HSaddist(:,1), 'color', '#D95319')
plot(plot_HSaddist(:,2), 'color', '#0072BD')
plot(smoothedhorizontalL, 'color', 'k', 'LineWidth', 1.5) 
plot(smoothedhorizontalR, 'color', 'k', 'LineWidth', 1.5) 
findpeaks(smoothedhorizontalL, 1, 'MinPeakProminence', 1)
findpeaks(smoothedhorizontalR, 1, 'MinPeakProminence', 1)
hold off

ylabel('Vertical Movement of Sticker')
xlabel('Frame Number')
title(['Vertical Movement of Sticker vs. Frame Number - ' ...
    'Forehead Signal Removed, Sides Combined, Smoothed'])
legend('Top','Bottom','location','best');
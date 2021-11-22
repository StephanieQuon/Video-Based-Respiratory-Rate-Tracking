insertvideo = 'input_video_stb.mp4';
filename = 'trackingvideo';
nstickers = 5;
outrange = 10;

vid = VideoReader(insertvideo);
detector = vision.CascadeObjectDetector('trained_model.xml');
nframes = vid.NumFrames - 3;

vertsignal = zeros(nframes, nstickers);
horisignal = zeros(nframes, nstickers);

channel1Min = 128.000;
channel1Max = 355.000;
channel2Min = 0.000;
channel2Max = 97.000;
channel3Min = 63.000;
channel3Max = 204.000;

vf = readFrame(vid);
bbox = step(detector, vf);
[rows, cols] = size(bbox);
[centres, radii] = imfindcircles(vf, [10 20], 'ObjectPolarity', 'bright', ...
   'Method', 'twostage', 'Sensitivity', .95, 'EdgeThreshold', .25);

detectedImg = insertObjectAnnotation(vf, 'rectangle', bbox, 'sticker');
imshow (detectedImg);

circle2Coords = zeros(size(centres,1), 3);
circle2Coords(:,1) = centres(:,1);
circle2Coords(:,2) = centres(:,2);
circle2Coords(:,3) = radii(:,1);

detectedImg = insertObjectAnnotation(vf,'circle',circle2Coords, 'sticker', ...
    'LineWidth', 2, 'Color', 'cyan');imshow (detectedImg);

detectedImg = insertObjectAnnotation(vf, 'rectangle', bbox, 'sticker');
imshow (detectedImg);
viscircles(centres, radii);

RGB = vf;
I = rgb2ycbcr(RGB);
sliderBW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
   (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
   (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
BW = sliderBW;
maskedRGBImage = RGB;
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;
imshow(maskedRGBImage)

bboxcutX = zeros(1, rows * 6);
temp = 1;
for n = 1 : rows
    bboxcutX(1,temp) = bbox(n,1);
        temp = temp + 1;
    bboxcutX(1,temp) = bbox(n,1) + bbox(n,3);
        temp = temp + 1;
    bboxcutX(1,temp) = bbox(n,1) + bbox(n,3);
        temp = temp + 1;
    bboxcutX(1,temp) = bbox(n,1);
        temp = temp + 1;
    bboxcutX(1,temp) = bbox(n,1);
        temp = temp + 1;
    bboxcutX(1,temp) = NaN;
        temp = temp + 1;
end

bboxcutY = zeros(1, rows * 6);
temp = 1;
for n = 1 : rows
    bboxcutY(1,temp) = bbox(n,2);
        temp = temp + 1;
    bboxcutY(1,temp) = bbox(n,2);
        temp = temp + 1;
    bboxcutY(1,temp) = bbox(n,2) + bbox(n,4);
        temp = temp + 1;
    bboxcutY(1,temp) = bbox(n,2) + bbox(n,4);
        temp = temp + 1;
    bboxcutY(1,temp) = bbox(n,2);
        temp = temp + 1;
    bboxcutY(1,temp) = NaN;
        temp = temp + 1;
end

circleCoords = zeros(1, 3);
numCircles = size(centres, 1);
in = inpolygon(centres(:, 1), centres(:, 2), bboxcutX, bboxcutY);

plot(bboxcutX, bboxcutY)
axis equal
hold on
plot(centres(:, 1), centres(:, 2), 'ko')
hold off

stickersfound = 1;
for nC = 1 : numCircles
    if in(nC, 1) == 1
        circleCoords(stickersfound, 1) = centres(nC, 1);
        circleCoords(stickersfound, 2) = centres(nC, 2);
        circleCoords(stickersfound, 3) = radii(nC, 1);
        stickersfound = stickersfound + 1;
    end
end

r = 1;
circlefinalCoords = zeros(1,3);
for t = 1 : size(circleCoords, 1)
    if BW(round(circleCoords(t, 2)), round(circleCoords(t, 1))) == 1
        circlefinalCoords(r, 1) = circleCoords(r, 1);
        circlefinalCoords(r, 2) = circleCoords(r, 2);
        circlefinalCoords(r, 3) = circleCoords(r, 3);
        r = r + 1;
    end
end

circlefinalCoords = sortrows(circlefinalCoords, 2)
r = 1;
for c = 1 : 5
   horisignal(r,c) = circlefinalCoords(c,1);
   vertsignal(r,c) = circlefinalCoords(c,2);
end

detectedImg = insertObjectAnnotation(vf,'circle', circlefinalCoords, 'sticker');
imshow (detectedImg);

video_obj = VideoWriter(filename, 'MPEG-4');
open(video_obj);

while hasFrame(vid)

    vf = readFrame(vid);
    bbox = step(detector, vf);
    [rows, cols] = size(bbox);
    sort(bbox, 2);

   [centres, radii] = imfindcircles(vf, [10 17], 'ObjectPolarity', 'bright', ...
        'Sensitivity', .95, 'EdgeThreshold', .28);

    bboxcutX = zeros(1, rows * 6);
    temp = 1;
    for n = 1 : rows
        bboxcutX(1,temp) = bbox(n,1);
            temp = temp + 1;
        bboxcutX(1,temp) = bbox(n,1) + bbox(n,3);
            temp = temp + 1;
        bboxcutX(1,temp) = bbox(n,1) + bbox(n,3);
            temp = temp + 1;
        bboxcutX(1,temp) = bbox(n,1);
            temp = temp + 1;
        bboxcutX(1,temp) = bbox(n,1);
            temp = temp + 1;
        bboxcutX(1,temp) = NaN;
            temp = temp + 1;
    end

    bboxcutY = zeros(1, rows * 6);
    temp = 1;
    for n = 1 : rows
        bboxcutY(1,temp) = bbox(n,2);
            temp = temp + 1;
        bboxcutY(1,temp) = bbox(n,2);
            temp = temp + 1;
        bboxcutY(1,temp) = bbox(n,2) + bbox(n,4);
            temp = temp + 1;
        bboxcutY(1,temp) = bbox(n,2) + bbox(n,4);
            temp = temp + 1;
        bboxcutY(1,temp) = bbox(n,2);
            temp = temp + 1;
        bboxcutY(1,temp) = NaN;
            temp = temp + 1;
    end

    circleCoords = zeros(nstickers, 3);
    numCircles = size(centres, 1);
    in = inpolygon(centres(:, 1), centres(:, 2), bboxcutX, bboxcutY);

    stickersfound = 1;
    for nC = 1 : numCircles
        if in(nC, 1) == 1
            circleCoords(stickersfound, 1) = centres(nC, 1);
            circleCoords(stickersfound, 2) = centres(nC, 2);
            circleCoords(stickersfound, 3) = radii(nC, 1);
            stickersfound = stickersfound + 1;
        end
    end

    r = r+1;
    if rows > nstickers
        rows = nstickers;
    end

    for c = 1 : nstickers

        difHori = 5000;
        difVert = 5000;
        for intR = 1 : rows
           if circleCoords(intR, 1) < horisignal(r - 1, c) + outrange  && ...
              circleCoords(intR, 1) > horisignal(r - 1, c) - outrange  && ...
              circleCoords(intR, 2) < vertsignal(r - 1, c) + outrange  && ...
              circleCoords(intR, 2) > vertsignal(r - 1, c) - outrange  && ...
              circleCoords(intR, 1) + horisignal(r - 1, c) < difHori   && ...
              circleCoords(intR, 2) + vertsignal(r - 1, c) < difVert
                  horisignal(r,c) = circleCoords(intR,1);
                  difHori = horisignal(r - 1, c) + circleCoords(intR,1);
                  vertsignal(r,c) = circleCoords(intR,2);
                  difVert = vertsignal(r - 1, c) + circleCoords(intR,2);
           end
        end

        if vertsignal(r,c) == 0
            vertsignal(r,c) = vertsignal(r - 1, c);
        end

        if horisignal(r,c) == 0
            horisignal(r,c) = horisignal(r - 1, c);
        end

    end

    detectedImg = insertObjectAnnotation(vf,'circle',circleCoords, 'sticker', ...
       'LineWidth', 2, 'Color', 'cyan');
    imshow (detectedImg);
    writeVideo(video_obj, detectedImg);

    if r > (nframes - 2)
        break
    end

end

close(video_obj);


plot_verticalsignalraw = vertsignal;
plot_horizontalsignalraw = horisignal;

plot_VSfhRem = zeros(nframes, 4);
plot_VSfhRem(:,1) =  vertsignal(:,2) - vertsignal(:,1);
plot_VSfhRem(:,2) =  vertsignal(:,3) - vertsignal(:,1);
plot_VSfhRem(:,3) =  vertsignal(:,4) - vertsignal(:,1);
plot_VSfhRem(:,4) =  vertsignal(:,5) - vertsignal(:,1);

plot_HSfhRem = zeros(nframes, 4);
plot_HSfhRem(:, 1) = horisignal(:,2) - horisignal(:,1);
plot_HSfhRem(:, 2) = horisignal(:,3) - horisignal(:,1);
plot_HSfhRem(:, 3) = horisignal(:,4) - horisignal(:,1);
plot_HSfhRem(:, 4) = horisignal(:,5) - horisignal(:,1);

plot_VSaddist = zeros(nframes, 2) ;
plot_VSaddist(:,1) = plot_VSfhRem(:,2) + plot_VSfhRem(:,3);
plot_VSaddist(:,2) = plot_VSfhRem(:,4) + plot_VSfhRem(:,5);

plot_HSaddist = zeros(nframes, 2) ;
plot_HSaddist(:,1) = plot_HSfhRem(:,2) + plot_HSfhRem(:,3);
plot_HSaddist(:,2) = plot_HSfhRem(:,4) + plot_HSfhRem(:,5);

% Vertical signal - Raw
rawVerticalSignal = figure;
figure(rawVerticalSignal)
plot(plot_verticalsignalraw)
ylabel('Y-Coordinate of Sticker'); xlabel('Frame Number');
title('Y-Coordinate of Sticker vs. Frame Number - Raw Data');

% Vertical signal - Forehead removed and smoothed
fhRemovedSmoothedVerticalSignal = figure;
figure(fhRemovedSmoothedVerticalSignal)

smooothedvertical = smooth(plot_VSaddist, 15);
pks = findpeaks(smoothedvertical, 1, 'MinPeakProminence', 1);
breaths_vert = numel(pks)

hold on
plot(plot_VSaddist, 'color', '#D95319')
plot(smooothedvertical, 'color', 'k', 'LineWidth', 1.5)
findpeaks(smoothedvertical, 1, 'MinPeakProminence', 1)
hold off

ylabel('Vertical Movement of Sticker'); xlabel('Frame Number');
title(['Vertical Movement of Sticker vs. Frame Number - ' ...
    'Forehead Signal Removed, Sides Added, Smoothed'])
legend('Top','Bottom','location','best');

% Horizontal signal - Raw
rawHorizontalSignal = figure;
figure(rawHorizontalSignal)
plot(plot_horizontalsignalraw)
ylabel('X-Coordinate of Sticker')
xlabel('Frame Number')
title('X-Coordinate of Sticker vs. Frame Number - Raw Data')

% Horizontal signal - Forehead removed and smoothed
fhRemovedSmoothedVerticalSignal = figure;
figure(fhRemovedSmoothedVerticalSignal)

smooothedhorizontal = smooth(plot_HSaddist, 15);
pks = findpeaks(smooothedhorizontal, 1, 'MinPeakProminence', 1);
breaths_hori = numel(pks)

hold on
plot(plot_HSaddist, 'color', '#D95319')
plot(smooothedhorizontal, 'color', 'k', 'LineWidth', 1.5)
findpeaks(smoothedhorizontal, 1, 'MinPeakProminence', 1)
hold off

ylabel('Horizontal Movement of Sticker')
xlabel('Frame Number')
title(['Horizontal Movement of Sticker vs. Frame Number - ' ...
    'Forehead Signal Removed, Sides Combined, Smoothed'])
legend('Top','Bottom','location','best');

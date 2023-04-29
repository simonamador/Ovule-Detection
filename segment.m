% This is a function for ovule detection on a frame.

function [frame] = segment(img)
    orig = img; %Saves the original frame
    img = rgb2gray(img); %Turns the image to black and white
    m = fspecial('average',5); %Creates an average filter kernel
    %Apply kernel 4 times
    for i =1:4
        img = imfilter(img,m);
    end

    SE = strel('disk',10); %Creates a disk form SE
    %Applies erosion, done to increase size of ovules in frame, as well as
    %making them more circle-like, which will make detection easier.
    img = imerode(img,SE);
    %Conducts 10 closings, aiming to remove small holes in image while
    %strenghtening the ovules in frame.
    for i = 1:10
        img = imdilate(img,SE);
        img = imerode(img,SE);
    end    
      
    %Augment contrast to the maximum, in order to make ovule detection
    %easier
    img = img*(255/max(img(:)));
    %Apply canny border detection, which is best at detecting most borders
    %in an image
    img = edge(img,'Canny');
    
    %Generate new frame figure as final
    final = figure('visible','off');
    imshow(orig); %Input original frame for new frame construction
    
    %Detect ovules in image as circle detection, for a radius which varies
    %between 2-20 and 12-32 pixels long, finds circles with a high
    %sensitivty and low edge threshold to find as many as posible (downside
    %being it may detect noise as ovules), then draws the circles in the
    %input image
    for r=2:1:12
        [centers, radii] = imfindcircles(img, [r r+10],...
            'Sensitivity', 0.999,...
            'EdgeThreshold',0.01,...
            'ObjectPolarity', "dark"...
            );
        total_circles = size(radii,2);
        if total_circles > 0
            centersStrong5 = centers(1:total_circles,:); 
            radiiStrong5 = radii(1:total_circles);
            viscircles(centersStrong5, radiiStrong5,'EdgeColor','r');     
        end
    end
    
    %Saves figure as image
    F = getframe(final);
    frame = frame2im(F);
end
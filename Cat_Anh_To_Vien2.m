function Cat_Anh_To_Vien2(video_name, line, excel_file,folder_name,image_name)    
    tic;     
    strel_number = 2;
    NumTrainingFrames = 100;

    video_info = VideoReader(video_name);
    videoReader = vision.VideoFileReader(video_name);
    num_frames = video_info.NumberOfFrames;   
        
    foregroundDetector = vision.ForegroundDetector('NumGaussians', 3, ...
    'NumTrainingFrames', NumTrainingFrames);  % detect foreground
    blobAnalysis = vision.BlobAnalysis('BoundingBoxOutputPort', true, ...
        'AreaOutputPort', false, 'CentroidOutputPort', false, ...
        'MinimumBlobArea', 350);    
                                                     
    videoPlayer = vision.VideoPlayer('Name', 'Detected Cars');
    videoPlayer.Position(3:4) = [video_info.Width,video_info.Height+50];
    videoPlayer2 = vision.VideoPlayer('Name', 'foreground');
    videoPlayer2.Position(3:4) = [video_info.Width,video_info.Height+50];

    se = strel('square', strel_number);
    count = 0;
    count_frame = 0;
    saveArray(1,3) = 0;
    mkdir(folder_name);
for i = 1:num_frames
 
    frame = step(videoReader); % read the next video frame
    count_frame = count_frame + 1;
    
    % Detect the foreground in the current video frame
    foreground = step(foregroundDetector, frame);
    
    if strel_number>0
    filteredForeground = imopen(foreground, se);
    else filteredForeground = fg;
    end
    
    bbox = step(blobAnalysis, filteredForeground);
    result = insertShape(frame, 'Rectangle', bbox, 'Color', 'green');    
    
    result = insertShape(result, 'Line', line, 'Color', 'yellow');
    
        if (size(bbox) ~= 0)
        
        % Get size of the bbox
        sizebbox = size(bbox);
        
        % Run one by one bbox
            for k = 1: sizebbox(1)
            
                toa_do_x_mid = bbox(k,1)+ bbox(k,3)/2;
                toa_do_y_top = bbox(k,2)+ bbox(k,4)/2;  
            
                             
                if  (toa_do_y_top > (line(1,2)-5))&&(toa_do_y_top < (line(1,2)+5))&&(toa_do_x_mid>line(1,1))&&(toa_do_x_mid<line(1,3))             
                    count = count +1;
                    angle = atan2(double(bbox(k,4)+1),double(bbox(k,3)+1))*180/pi;
                    saveArray(count,:,:) = [count bbox(k,3)+1 bbox(k,4)+1];                    
                    
                    fr_save = insertShape(frame, 'Rectangle', [bbox(k,1) bbox(k,2) bbox(k,3)+1 bbox(k,4)+1], 'Color', 'red');
                    fr_save=insertShape(fr_save, 'Line', [bbox(k,1) bbox(k,2) bbox(k,1)+bbox(k,3) bbox(k,2)+bbox(k,4)], 'Color', 'red');
                    frame_save = imcrop(fr_save, [bbox(k,1) bbox(k,2) bbox(k,3) bbox(k,4)]);
                    
                    imwrite(frame_save,[folder_name '\frame'  int2str(count), '.jpg']);
                end
            end
        end
        
        pos = [line(1,1)-80 line(1,2)-10];
        result = insertText(result, pos, 'Total: ', 'BoxOpacity', 1, ...
        'TextColor','black','BoxColor', 'red', 'FontSize', 12);
    
        pos_2 = [line(1,1)-40 line(1,2)-10];
        text_str = num2str(count,'%0.0f');
        result = insertText(result, pos_2,text_str, 'BoxOpacity', 1, ...
            'TextColor','black','BoxColor', 'red', 'FontSize', 12);

    step(videoPlayer, result);
    step(videoPlayer2, foreground);
    
 end
 release(videoReader);   
 data = saveArray;
% Remove zero rows
data( all(~data,2), : ) = [];
% Remove zero columns
data( :, all(~data,1) ) = [];
title={'Width', 'Height', 'Angle'};
xlswrite(excel_file,title);
xlswrite(excel_file,data,1,'A2');
Ve_Vien_Len_Do_Thi(saveArray, image_name);
toc;
%  array=xlsread('testdata2.xlsx')
% Ve_Vien_Len_Do_Thi(array);
% print('-djpeg','-r500','my_image');
end
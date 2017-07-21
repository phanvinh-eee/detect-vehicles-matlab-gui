function Ve_Vien_Len_Do_Thi(Array, image_name)
figure_pixel = figure;  
[row col] = size(Array);
color = round(rand(row,3));

for i = 1:row    
    if Array(i,2)>0
    h(i) = rectangle('Position', [-Array(i,2)/2, -Array(i,3)/2, Array(i,2), Array(i,3)], 'EdgeColor', 'r', 'LineWidth',1);
    %line([-Array(i,2)/2 Array(i,2)/2], [Array(i,3)/2 -Array(i,3)/2], 'LineWidth',1,'Color',[0 0.4 0.8]);
%     h(i) = rectangle('Position', [80 - Array(i,1)/2, 80 - Array(i,2)/2, Array(i,1), Array(i,2)], 'EdgeColor', color(i, :,:), 'LineWidth',2);
    end
end
for i = 1:row    
    if Array(i,2)>0
    %h(i) = rectangle('Position', [-Array(i,2)/2, -Array(i,3)/2, Array(i,2), Array(i,3)], 'EdgeColor', 'r', 'LineWidth',1);
    line([-Array(i,2)/2 Array(i,2)/2], [Array(i,3)/2 -Array(i,3)/2], 'LineWidth',1,'Color',[0 0.4 0.8]);
%     h(i) = rectangle('Position', [80 - Array(i,1)/2, 80 - Array(i,2)/2, Array(i,1), Array(i,2)], 'EdgeColor', color(i, :,:), 'LineWidth',2);
    end
end
image_name=strcat(image_name,'.jpg');
line([0 0], [-70 70], 'LineWidth',1,'Color',[0 1 0]);
line([-70 70],[0 0] , 'LineWidth',1,'Color',[0 1 0]);
saveas(figure_pixel, image_name);  % here you save the figure
end
function my_plot()
    % 全局参数
    lineWidth = 1.5; 
    axisFontSize = 9;      % 坐标轴刻度字号
    labelFontSize = 10;    % xlabel/ylabel字号
    legendFontSize = 9;    % legend字号
    fontName = 'Times New Roman'; % 论文常用字体
    legendLabels = {'$y = x$', '$y = x^2$', '$y = \sqrt{x}$', '$y = \log(x+1)$'};
    plotTitle = 'Function Comparison';
    outputDir = 'figs/';
    fileName = 'myplot.pdf';
    styles = {'-','--','-.',':'};
    markers = {'o','^','s','d','p'}; % 圆, 三角, 方, 菱形, 五角
    colors = lines(4); % 默认4种区分色，Matlab自带

    textWidth_cm = 16.50764;
    width_cm = textWidth_cm*0.8;
    height_cm = 6.5;

    % LaTeX 渲染设置
    set(0,'defaultTextInterpreter','latex'); 
    set(groot, 'defaultAxesTickLabelInterpreter','latex');
    set(groot, 'defaultLegendInterpreter','latex');

    % 读入数据
    x = linspace(0, 2, 401);
    Y = [x;
         x.^2;
         sqrt(x);
         log(x+1)];

    if ~exist(outputDir, 'dir')
        mkdir(outputDir);
    end

    fig = figure;
    set(fig, 'Units', 'centimeters', 'Position', [2, 2, width_cm, height_cm]);
    box on; set(gca,'LineWidth',1)
    
    hold on
    for i = 1:size(Y,1)
        y = Y(i,:);
        plot(x, y, ...
            'LineWidth', lineWidth, ...
            'LineStyle', styles{i}, ...
            'Marker', markers{i}, ...
            'MarkerIndices', 1:50:length(x), ...
            'MarkerSize', 5, ...
            'Color', colors(i, :), ...
            'MarkerFaceColor', colors(i, :)); % 填充色
    end
    hold off
    
    % 设置坐标轴字体和字号
    set(gca, 'FontName', fontName, 'FontSize', axisFontSize, 'LineWidth', 1);

    % 坐标轴标签
    xlabel('$x$','Interpreter','latex', 'FontSize', labelFontSize, 'FontName', fontName);
    ylabel('$y$','Interpreter','latex', 'FontSize', labelFontSize, 'FontName', fontName);

    % 图例
    legend(legendLabels, ...
        'Location', 'northwest', ...
        'Interpreter', 'latex', ...
        'FontSize', legendFontSize, ...
        'FontName', fontName);

    % 标题（一般论文图不建议加标题，如需加可保留，字号与label一致或略小）
    title(plotTitle, 'Interpreter', 'latex', 'FontSize', labelFontSize, 'FontName', fontName);

    exportgraphics(fig, [outputDir fileName], 'ContentType', 'vector');
    % close(fig);
end












% function my_plot()
%     % 全局参数
%     lineWidth = 1.5;
%     fontSize = 12;
%     fontName = 'Arial';
%     legendLabels = {'$y = x$', '$y = x^2$', '$y = \sqrt{x}$', '$y = \log(x+1)$'};
%     plotTitle = 'Function Comparison';
%     outputDir = 'figs/';
%     fileName = 'myplot.pdf';
%     styles = {'-','--','-.',':'};
%     markers = {'o','^','s','d','p'}; % 圆, 三角, 方, 菱形, 五角
%     colors = lines(4); % 默认4种区分色，Matlab自带
% 
%     % 单栏
%     width_cm = 8.5;
%     height_cm = width_cm*3/4;
%     % % 双栏
%     % width_cm = 14;  
%     % height_cm = 7; % 7～8cm 
% 
%     % LaTeX 渲染设置
%     set(0,'defaultTextInterpreter','latex'); 
%     set(groot, 'defaultAxesTickLabelInterpreter','latex');
%     set(groot, 'defaultLegendInterpreter','latex');
% 
%     % 读入数据
%     x = linspace(0, 2, 401);
%     Y = [x;
%          x.^2;
%          sqrt(x);
%          log(x+1)];
% 
%     if ~exist(outputDir, 'dir')
%         mkdir(outputDir);
%     end
% 
%     fig = figure;
%     set(fig, 'Units', 'centimeters', 'Position', [2, 2, width_cm, height_cm]);
%     box on; set(gca,'LineWidth',0.5)
% 
%     hold on
%     for i = 1:size(Y,1)
%         y = Y(i,:);
%         plot(x, y, ...
%             'LineWidth', lineWidth, ...
%             'LineStyle', styles{i}, ...
%             'Marker', markers{i}, ...
%             'MarkerIndices', 1:50:length(x), ...
%             'MarkerSize', 5, ...
%             'Color', colors(i, :), ...
%             'MarkerFaceColor', colors(i, :)); % 填充色
%     end
%     hold off
%     set(gca, 'FontName', fontName, 'FontSize', fontSize)
%     xlabel('$x$','Interpreter','latex');
%     ylabel('$y$','Interpreter','latex');
%     legend(legendLabels, 'Location', 'northwest', 'Interpreter', 'latex');
%     title(plotTitle, 'Interpreter', 'latex');
%     exportgraphics(fig, [outputDir fileName], 'ContentType', 'vector');
%     % close(fig);
% end
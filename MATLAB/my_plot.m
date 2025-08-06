function my_plot()
    % 主参数
    x = linspace(0, 2, 401);
    Y = [x;
         x.^2;
         sqrt(x);
         log(x+1)];

    % 线型参数
    lineWidth = 1.5;
    fontName = 'Times New Roman';
    styles = {'-','--','-.',':'};
    markers = {'o','^','s','d'};
    colors = lines(4);

    % inset参数结构体
    insetopt.x_min    = 0.5;
    insetopt.x_max    = 0.6;
    insetopt.pos      = [0.13, 0.63, 0.30, 0.32]; % 左上角
    insetopt.lineWidth= lineWidth;
    insetopt.styles   = styles;
    insetopt.markers  = markers;
    insetopt.colors   = colors;
    insetopt.fontName = fontName;
    insetopt.fontSize = 8;
    insetopt.showYTick= false;

    set(0,'defaultTextInterpreter','latex'); 
    set(groot, 'defaultAxesTickLabelInterpreter','latex');
    set(groot, 'defaultLegendInterpreter','latex');

    fig = figure;
    set(fig, 'Units', 'centimeters', 'Position', [2, 2, 13, 7]);

    % --------- 主图 -------------
    axMain = axes('Position', [0.13 0.15 0.74 0.75]);
    hold(axMain,'on');
    for i = 1:4
        plot(axMain, x, Y(i,:), ...
            'LineWidth', lineWidth, ...
            'LineStyle', styles{i}, ...
            'Marker', markers{i}, ...
            'MarkerIndices', 1:50:length(x), ...
            'MarkerSize', 5, ...
            'Color', colors(i,:), ...
            'MarkerFaceColor', colors(i,:));
    end
    hold(axMain,'off');
    xlabel(axMain,'$x$','FontName',fontName);
    ylabel(axMain,'$y$','FontName',fontName);
    legend(axMain,{'$y=x$','$y=x^2$','$y=\sqrt{x}$','$y=\log(x+1)$'}, ...
        'Interpreter','latex','Location','southoutside','Orientation','horizontal');
    box(axMain,'on');

    % --------- 调用 inset 函数 -------------
    my_inset(axMain, x, Y, insetopt);

    % --------- 可选导出 -------------
    % exportgraphics(fig, 'figs/myplot_with_inset.pdf', 'ContentType', 'vector');
end



function axInset = my_inset(axMain, x, Y, insetOpt)
    % 必须字段
    x_min = insetOpt.x_min;
    x_max = insetOpt.x_max;
    insetPos = insetOpt.pos;

    % 可选字段
    if isfield(insetOpt, 'lineWidth'), lineWidth = insetOpt.lineWidth; else, lineWidth = 1.5; end
    if isfield(insetOpt, 'styles'),    styles = insetOpt.styles; else, styles = {'-','--','-.',':' }; end
    if isfield(insetOpt, 'markers'),   markers = insetOpt.markers; else, markers = {'o','^','s','d'}; end
    if isfield(insetOpt, 'colors'),    colors = insetOpt.colors; else, colors = lines(size(Y,1)); end
    if isfield(insetOpt, 'fontName'),  fontName = insetOpt.fontName; else, fontName = 'Times New Roman'; end
    if isfield(insetOpt, 'fontSize'),  fontSize = insetOpt.fontSize; else, fontSize = 8; end
    if isfield(insetOpt, 'showYTick'), showYTick = insetOpt.showYTick; else, showYTick = false; end

    % 提取区间
    idx = (x >= x_min) & (x <= x_max);
    y_all = Y(:,idx); y_min = min(y_all(:)); y_max = max(y_all(:));

    % --------- 主图画虚线框 -------------
    hold(axMain, 'on');
    rectPos = [x_min y_min x_max-x_min y_max-y_min];
    rectangle(axMain,'Position',rectPos,'EdgeColor','k','LineStyle','--','LineWidth',1);
    hold(axMain, 'off');

    % --------- inset子图 -------------
    fig = ancestor(axMain,'figure');
    axInset = axes('Position', insetPos);
    hold(axInset,'on');
    for i = 1:size(Y,1)
        plot(axInset, x(idx), Y(i,idx), ...
            'LineWidth', lineWidth, ...
            'LineStyle', styles{mod(i-1,length(styles))+1}, ...
            'Marker', markers{mod(i-1,length(markers))+1}, ...
            'MarkerIndices', 1:5:sum(idx), ...
            'MarkerSize', 4, ...
            'Color', colors(i,:), ...
            'MarkerFaceColor', colors(i,:));
    end
    hold(axInset,'off');
    set(axInset,'FontName',fontName,'FontSize',fontSize,'Box','on');
    xlim(axInset,[x_min x_max]);
    ylim(axInset,[y_min y_max]);
    set(axInset,'XTick', [x_min, (x_min+x_max)/2, x_max]);
    if showYTick
        set(axInset, 'YTickMode', 'auto');
    else
        set(axInset, 'YTick', []);
    end

    % --------- 连线 -------------
    drawnow;
    axMainPos = get(axMain,'Position');
    axMainXLim = get(axMain,'XLim');
    axMainYLim = get(axMain,'YLim');
    % 主图虚线框左下、右上
    normX1 = (x_min-axMainXLim(1)) / diff(axMainXLim) * axMainPos(3) + axMainPos(1);
    normY1 = (y_min-axMainYLim(1)) / diff(axMainYLim) * axMainPos(4) + axMainPos(2);
    normX2 = (x_max-axMainXLim(1)) / diff(axMainXLim) * axMainPos(3) + axMainPos(1);
    normY2 = (y_max-axMainYLim(1)) / diff(axMainYLim) * axMainPos(4) + axMainPos(2);
    % inset左下、右上
    normX3 = insetPos(1);
    normY3 = insetPos(2);
    normX4 = insetPos(1)+insetPos(3);
    normY4 = insetPos(2)+insetPos(4);

    annotation(fig,'line', [normX1 normX3], [normY1 normY3], 'Color', 'k', 'LineWidth', 1)
    annotation(fig,'line', [normX2 normX4], [normY2 normY4], 'Color', 'k', 'LineWidth', 1)
end


% function my_plot()
%     % 全局参数
%     lineWidth = 1.5; 
%     boxLineWidth = 0.5;
%     axisFontSize = 9;      % 坐标轴刻度字号
%     labelFontSize = 10;    % xlabel/ylabel字号
%     legendFontSize = 9;    % legend字号
%     fontName = 'Times New Roman'; % 论文常用字体
%     legendLabels = {'$y = x$', '$y = x^2$', '$y = \sqrt{x}$', '$y = \log(x+1)$'};
%     plotTitle = 'Function Comparison';
%     outputDir = 'figs/';
%     fileName = 'myplot.pdf';
%     styles = {'-','--','-.',':'};
%     markers = {'o','^','s','d','p'}; % 圆, 三角, 方, 菱形, 五角
%     colors = lines(4); % 默认4种区分色，Matlab自带
% 
%     textWidth_cm = 16.50764;
%     width_cm = textWidth_cm*0.8;
%     height_cm = 6.5;
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
%     box on; set(gca,'LineWidth',1)
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
% 
%     % 设置坐标轴字体和字号
%     set(gca, 'FontName', fontName, 'FontSize', axisFontSize, 'LineWidth', boxLineWidth);
% 
%     % 坐标轴标签
%     xlabel('$x$','Interpreter','latex', 'FontSize', labelFontSize, 'FontName', fontName);
%     ylabel('$y$','Interpreter','latex', 'FontSize', labelFontSize, 'FontName', fontName);
% 
%     % 图例
%     legend(legendLabels, ...
%         'Location', 'northwest', ...
%         'Interpreter', 'latex', ...
%         'FontSize', legendFontSize, ...
%         'FontName', fontName);
% 
%     % 标题（一般论文图不建议加标题，如需加可保留，字号与label一致或略小）
%     title(plotTitle, 'Interpreter', 'latex', 'FontSize', labelFontSize, 'FontName', fontName);
% 
%     exportgraphics(fig, [outputDir fileName], 'ContentType', 'vector');
%     % close(fig);
% end












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
function my_plot()
    % 全局参数
    lineWidth = 1.5;
    fontSize = 12;
    fontName = 'Arial';
    legendLabels = {'$\sin x$', '$\cos x$', '$\sin 2x$', '$\cos 2x$'};
    plotTitle = 'Title';
    outputDir = 'figs/';
    fileName = 'myplot.pdf';
    styles = {'-','--','-.','-','--'};
    % 单栏
    width_cm = 8.5; % 8
    height_cm = 6;
    % % 双栏
    % width_cm = 14;  
    % height_cm = 7; % 7～8cm    


    % LaTeX 渲染设置
    set(0,'defaultTextInterpreter','latex'); 
    set(groot, 'defaultAxesTickLabelInterpreter','latex');
    set(groot, 'defaultLegendInterpreter','latex');

    % 读入数据
    x = 0:0.01:4;
    Y = [sin(x);cos(x);sin(2*x);cos(2*x)];

    fig = figure;
    set(fig, 'Units', 'centimeters', 'Position', [2, 2, width_cm, height_cm]);
    box on; set(gca,'LineWidth',0.5)
    
    hold on
    for i = 1:size(Y,1)
        y = Y(i,:);
        plot(x,y,'LineWidth',lineWidth,'LineStyle',styles{i});
    end
    hold off
    set(gca, 'FontName', fontName, 'FontSize', fontSize)
    xlabel('Time');
    ylabel('Values');
    legend(legendLabels, 'Location', 'best');
    title(plotTitle);
    exportgraphics(fig, [outputDir fileName], 'ContentType','vector');
    %close(fig);
end


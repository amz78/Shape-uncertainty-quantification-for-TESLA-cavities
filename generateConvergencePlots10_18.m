clear all; close all

% directory with the csv files
dataFolder = 'data/convergencePlotData_deg/';

t = tiledlayout(2,2,'TileSpacing','tight','Padding','tight');

plot_groups = 9;
custom_colormap = hsv(plot_groups); 
colormap(custom_colormap);
%%
nexttile

hold on
for group =1:plot_groups
    filename = fullfile(dataFolder, ['E_Lambda_group', num2str(group), '.csv']);

    % Read data from CSV file
    data = readmatrix(filename);
    x = data(:, 1);
    y = data(:, 2);
    
    % Plot data in Log-Log-mode
    loglog(x, y, '-x', 'DisplayName', ['ES ', num2str(group+9)]);
    crtl = gca; set(crtl,'xscale','log','yscale','log')
    xlabel("Scaling parameter t"), ylabel("error")
end
plot(x,5E-5*x.^2,':','Color','k','DisplayName','O(t^2)')
legend('Location', 'best');
title('Expected Value of Eigenvalues');

%%
nexttile

hold on
for group =1:plot_groups
    filename = fullfile(dataFolder, ['E_u_group', num2str(group), '.csv']);

    % Read data from CSV file
    data = readmatrix(filename);
    x = data(:, 1);
    y = data(:, 2);
    
    % Plot data in Log-Log-mode
    loglog(x, y, '-x', 'DisplayName', ['ES ', num2str(group+9)]);
    crtl = gca; set(crtl,'xscale','log','yscale','log')
    xlabel("Scaling parameter t"), ylabel("error")
end
plot(x,1E-3*x.^2,':','Color','k','DisplayName','O(t^2)')
legend('Location', 'best');
title('Expected Value of Eigenspaces');

%%
nexttile

hold on
for group =1:plot_groups
    filename = fullfile(dataFolder, ['Cov_Lambda_group', num2str(group), '.csv']);

    % Read data from CSV file
    data = readmatrix(filename);
    x = data(:, 1);
    y = data(:, 2);
    
    % Plot data in Log-Log-mode
    loglog(x, y, '-x', 'DisplayName', ['ES ', num2str(group+9)]);
    crtl = gca; set(crtl,'xscale','log','yscale','log')
    xlabel("Scaling parameter t"), ylabel("error")
end
plot(x,5E-6*x.^3,':','Color','k','DisplayName','O(t^3)')
legend('Location', 'best');
title('Variances of Eigenvalues');

%%
nexttile

hold on
for group =1:plot_groups
    filename = fullfile(dataFolder, ['Cov_u_group', num2str(group), '.csv']);

    % Read data from CSV file
    data = readmatrix(filename);
    x = data(:, 1);
    y = data(:, 2);
    
    % Plot data in Log-Log-mode
    loglog(x, y, '-x', 'DisplayName', ['ES ', num2str(group+9)]);
    crtl = gca; set(crtl,'xscale','log','yscale','log')
    xlabel("Scaling parameter t"), ylabel("error")
end
plot(x,1E-2*x.^3,':','Color','k','DisplayName','O(t^3)')
legend('Location', 'best');
title('Variances of Eigenspaces');
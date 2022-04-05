%% Compare Different MPC
% 1： Sample time to 0.1 Prediction horizon 10 Control horizon 2
% 2： Sample time to 0.1 Prediction horizon 100 Control horizon 20
% 3： Sample time to 0.2 Prediction horizon 10 Control horizon 2
% 4： Sample time to 0.4 Prediction horizon 25 Control horizon 5
close all;

GetSimResult('MPC_1');
GetSimResult('MPC_2');
GetSimResult('MPC_3');
GetSimResult('MPC_4');

% Load
load MPC_1;
load MPC_2;
load MPC_3;
load MPC_4;
% Plot
PlotData(MPC1,  'MPC1');
PlotData(MPC2,  'MPC2');
PlotData(MPC3,  'MPC3');
PlotData(MPC4,  'MPC4');
%% Subfunction
function GetSimResult(Name)
    if ~exist([Name '.mat'], 'file')
        SystemName = ['MassSpring' Name];
        open_system(SystemName);
        sim(SystemName);
        close_system(SystemName);
    end
end

function PlotData(Name, strName)
    figure
    % Input u1
    subplot(221);
    plot(Name.u1.Time, Name.u1.Data);
    title([strName ' Control Variable u1']);
    xlabel('Time [s]');
    % Input u2
    subplot(222);
    plot(Name.u2.Time, Name.u2.Data);
    title([strName ' Control Variable u2']);
    xlabel('Time [s]');
    % Output y1
    subplot(223);
    plot(Name.y1.Time, Name.y1.Data(:, 1), 'b-', Name.y1.Time, Name.y1.Data(:, 2), 'r--');  
    title([strName ' Output y1']);
    legend('Reference from model', 'Measured');
    xlabel('Time [s]');
    % Output y2
    subplot(224);
    plot(Name.y2.Time, Name.y2.Data(:, 1), 'b-', Name.y2.Time, Name.y2.Data(:, 2), 'r--');
    title([strName ' Output y2']);
    legend('Reference from model', 'Measured');
    xlabel('Time [s]');
end
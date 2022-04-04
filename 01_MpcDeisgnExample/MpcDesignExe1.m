%% Init
clc
clear all
close all
%% Model Define- Idealiza model which can not obtain in real world
% parameter
m1 = 1;
m2 = 1.2;
k1 = 1;
k2 = 1.3;

% state space matrix
A = [0           1  0           0;
     -(k1+k2)/m1 0  k2/m1       0;
     0           0  0           1;
     k2/m2       0  -(k1+k2)/m2 0];
B = [0    0;
     1/m1 0;
     0    0;
     0    1/m2];
C = [1 0 0 0;
     0 0 1 0];
D = [0 0;
     0 0];

% Continuous time SS model
Continuous_Plant_Model = ss(A, B, C, D);
Continuous_Plant_Model.InputName = {'u1', 'u2'};
Continuous_Plant_Model.InputUnit = {'N', 'N'};
Continuous_Plant_Model.OutputName = {'y1', 'y2'};
Continuous_Plant_Model.OutputUnit = {'m', 'm'};
save Continuous_Plant_Model
%% Model Simulation
open_system('MechanicalMassSpringContinousTime');
sim('MechanicalMassSpringContinousTime');
close_system('MechanicalMassSpringContinousTime');
% Result
subplot(221)
plot(u1_in(:,1), u1_in(:, 2), 'linewidth', 2);
xlabel('Time [s]');
legend('u1');
grid on;
subplot(222)
plot(u2_in(:,1), u2_in(:, 2), 'linewidth', 2);
xlabel('Time [s]');
legend('u2');
grid on;
subplot(223)
plot(y1_cont(:, 1), y1_cont(:, 2), 'linewidth', 2);
xlabel('Time [s]');
legend('y1');
grid on;
subplot(224)
plot(y2_cont(:, 1), y2_cont(:, 2), 'linewidth', 2);
xlabel('Time [s]');
legend('y2');
grid on;

%% Model Identification- using simulation data
stp_sz = 0.1;
Nstart = 5;

MeasuredOutputs = [y1_cont(Nstart:end, 2) y2_cont(Nstart:end, 2)];
ManipipulateVariables = [u1_in(Nstart:end, 2) u2_in(Nstart:end, 2)];

MeasuredOutputs_Init = MeasuredOutputs(1, :);
ManipipulateVariables_Init = ManipipulateVariables(1, :);

% Force response to start from zero conditions
MeasuredOutputs_InitZeroCondition = MeasuredOutputs - repmat(MeasuredOutputs_Init, length(MeasuredOutputs), 1);
ManipipulateVariables_InitZeroCondition = ManipipulateVariables - repmat(ManipipulateVariables_Init, length(ManipipulateVariables), 1);

% Prepare data
data = iddata(MeasuredOutputs_InitZeroCondition, ManipipulateVariables_InitZeroCondition, stp_sz);

% Identify System
SystemOrder = 4;
sys1 = n4sid(data, SystemOrder, 'Form', 'canonical', 'DisturbanceModel', 'None', 'InputDelay', [0 0], 'InitialState', 'Zero');
sys2 = pem(data, sys1, 'InitialState', 'Zero');

% Compare
opt = compareOptions('InitialCondition', 'Z');
[Y, fit, x0] = compare(data, sys2);
Y_1 = Y.OutputData(:, 1);
Y_2 = Y.OutputData(:, 2);

% Result
figure
subplot(211)
plot(0:stp_sz:stp_sz*(length(Y_1)-1), MeasuredOutputs_InitZeroCondition(:, 1), 'LineWidth', 2);
grid on;
hold on;
plot(0:stp_sz:stp_sz*(length(Y_1)-1), Y_1, '--r', 'LineWidth', 2);
legend('y1 measured', 'y1 System Identification');
title(['System ID Order ' num2str(SystemOrder)]);
xlabel('Time [s]');

subplot(212)
plot(0:stp_sz:stp_sz*(length(Y_2)-1), MeasuredOutputs_InitZeroCondition(:, 2), 'LineWidth', 2);
grid on;
hold on;
plot(0:stp_sz:stp_sz*(length(Y_2)-1), Y_2, '--r', 'LineWidth', 2);
legend('y2 measured', 'y2 System Identification');
title(['System ID Order ' num2str(SystemOrder)]);
xlabel('Time [s]');
save Continuous_Plant_Id_Model sys2

%% Mpc with real Plant
open_system('MassSpringMPC');
sim('MassSpringMPC');

subplot(221)
plot(u1_mpc(:,1), u1_mpc(:, 2), 'linewidth', 2);
xlabel('Time [s]');
legend('u1');
grid on;
subplot(222)
plot(u2_mpc(:,1), u2_mpc(:, 2), 'linewidth', 2);
xlabel('Time [s]');
legend('u2');
grid on;
subplot(223)
plot(y1_ref(:, 1), y1_ref(:, 2), 'linewidth', 2);
hold on
plot(y1_feb(:, 1), y1_feb(:, 2), 'linewidth', 2);
xlabel('Time [s]');
legend('y1');
grid on;
subplot(224)
plot(y2_ref(:, 1), y2_ref(:, 2), 'linewidth', 2);
hold on
plot(y2_feb(:, 1), y2_feb(:, 2), 'linewidth', 2);
xlabel('Time [s]');
legend('y2');
grid on;
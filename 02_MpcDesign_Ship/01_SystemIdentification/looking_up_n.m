function [sys,x0,str,ts] = looking_up_n(t,x,u,flag)
%   Copyright 1990-2002 The MathWorks, Inc.
%
% Dispatch the flag. The switch function controls the calls to 
% S-function routines at each simulation stage of the S-function.
%
switch flag,
  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  % Initialize the states, sample times, and state ordering strings.
  case 0
    [sys,x0,str,ts]=mdlInitializeSizes;

  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  % Return the outputs of the S-function block.
  case 3
    sys=mdlOutputs(t,x,u);

  %%%%%%%%%%%%%%%%%%%
  % Unhandled flags %
  %%%%%%%%%%%%%%%%%%%
  % There are no termination tasks (flag=9) to be handled.
  % Also, there are no continuous or discrete states,
  % so flags 1,2, and 4 are not used, so return an empty
  % matrix 
  case { 1, 2, 4, 9 }
    sys=[];

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Unexpected flags (error handling)%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Return an error message for unhandled flag values.
  otherwise
    error(['Unhandled flag = ',num2str(flag)]);

end

% end timestwo

%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts] = mdlInitializeSizes()

sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;

% sizes.NumOutputs     = 1;  % dynamically sized
sizes.NumOutputs     = 8;  % dynamically sized
sizes.NumInputs      = 7;  % dynamically sized
sizes.DirFeedthrough = 1;   % has direct feedthrough
sizes.NumSampleTimes = 1;

sys = simsizes(sizes);
str = [];
x0  = [];
ts  = [-1 0];   % inherited sample time

% end mdlInitializeSizes

%
%=============================================================================
% mdlOutputs
% Return the output vector for the S-function
%=============================================================================
%
function sys = mdlOutputs(t,x,u)
% load thrust_torque.mat
Vpr=u(1);
npr=u(2);
raw=u(3);
Dpr=u(4);
npr_previous=u(5);
dt=u(6);
t=u(7);

bettas_CT=[0 5.37 16.73 33.6 44.63 60.82 73.22 80.46 86.3 92.15 100.41 ...
    110.74 119 124.16 132.76 139.99 148.93 158.21 162.34 165.43 167.5 ...
    170.25 176.79 182.99 191.93 200.53 210.85 218.07 226.33 232.51 ... 
    239.74 243.17 249.02 254.52 256.92 258.64 264.16 267.61 275.18 ...
    283.44 291.69 297.2 304.08 312.68 324.05 333.35 338.17 343.34 347.47 351.6 355.73 360 ];
    
 CTs=[0.32 0.29 0.19 0.01 -0.16 -0.46 -0.7 -0.77 -0.7 -0.63 -0.63 -0.69 ...
 -0.74 -0.75 -0.66 -0.57 -0.48 -0.37 -0.27 -0.24 -0.23 -0.23 -0.24 -0.25 -0.17...
 -0.1 0.02 0.12 0.24 0.35 0.47 0.55 0.66 0.8 0.86 0.86 0.73 0.62 0.59 0.63 0.69...
 0.75 0.8 0.75 0.64 0.54 0.47 0.34 0.27 0.31 0.34 0.33  ];  
bettas_CQ=[0 5.39 17.77 34.97 50.79 58.7 64.55 68.33 73.49 85.2 93.11 ...
     102.75 119.96 131.32 144.76 156.12 162.32 169.55 172.65 179.53 191.92 ...
     206.73 216.72 229.81 238.76 244.97 249.79 253.23 258.74 262.17 272.15 ...
     283.85 289.36 296.24 308.97 319.28 334.08 345.08 351.28 360  ];
 CQs=-0.1.*[-0.08 -0.07 0.02 0.18 0.37 0.49 0.6 0.65 0.68 0.59 0.57 0.59 0.54 0.45 ...
     0.28 0.19 0.14 0.07 0.06 0.09 0.02 -0.11 -0.24 -0.44 -0.62 -0.74 -0.84 -0.86 ...
     -0.78 -0.72 -0.67 -0.63 -0.62 -0.64 -0.5 -0.36 -0.21 -0.13 -0.08 -0.08  ];

 

%croping the value of the acceleration of npr by its saturation limits
npr_dot=(npr-npr_previous)/dt;
if npr_dot>0.05
    npr_dot=0.05;
elseif npr_dot<-0.05
    npr_dot=-0.05;
end
% if t~=0    
%     npr=npr_previous+npr_dot*dt
% end

if npr<0
    npr=0;
elseif npr>30
    npr=30;
end

npr_new=npr;
betta=atan2(1.4*pi*npr*Dpr,Vpr);
CT=interp1(bettas_CT,CTs,betta,'linear');
CQ=interp1(bettas_CQ,CQs,betta,'linear');
Vr=sqrt(Vpr^2+(0.7*pi*npr*Dpr)^2);
Tpr=pi/8*CQ*raw*Vr^2*Dpr^3;
Fth_deliv=pi/8*CT*raw*Vr^2*Dpr^2;
sys=[npr_new Tpr  Fth_deliv betta betta CQ CT npr_dot];

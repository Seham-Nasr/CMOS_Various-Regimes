%elec04f19.m
VDD=5; VtN=1; VtP=-1; KN=1e-3; KP=1e-3;
KNP=[KN KP]; VtNP=[VtN VtP];
Kg=2; % To plot the graphs
[VIL,VIH,VOL,VOH,Vm,VIT1,VOT1,VIT2,VOT2,VLH,NML,NMH,PDavg]=...
CMOS_inverter(KNP,VtNP,VDD,Kg);
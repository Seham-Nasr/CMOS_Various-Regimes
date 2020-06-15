
% To solve Example 
VDD=2; RD=1e4; Kp=5e-3; Vt=1; % Circuit and NMOS device parameters
[VIL,VIH,VOL,VOH,VM,VIT,VOT,VLH,NML,NMH,PDavg]= NMOS_inverter(Kp,Vt,RD,VDD);
function [VIL,VIH,VOL,VOH,VM,VIT,VOT,VLH,NML,NMH,PDavg,vo1,iD1]=...
NMOS_inverter(Kp,Vt,RD,VDD,vi1)
% Analyze an NMOS inverter consisting of an NMOS and RD between VDD and D
% to find the output vo1 to an input vi1 and plot its VTC
% Vt = Threshold (Pinch-off ) voltage, Kp = mu*Cox*(W/L)
% vo1: Output voltage(s) for input voltage(s) vi=vi1
% iD1: Drain current(s) for input voltage(s) vi=vi1
% Copyleft: Won Y. Yang, wyyang53@hanmail.net, CAU for academic use only
if nargin<5, vi1=0; end
dvi=1e-3; vis=[0:dvi:VDD]; % Full range of the input vi
VOT=(sqrt(2*Kp*RD*VDD+1)-1)/Kp/RD; % Boundary between sat/triode
VIT=VOT+Vt; % Eq.(4.1.30)
[vos,iDs]=vo_iD_NMOS_inverter(Kp,Vt,RD,VIT,VDD,vis);
[VIL,VIH,VOL,VOH,VM,NML,NMH,VL,PDavg]= ...
find_pars_of_inverter(vis,vos,iDs,VDD);
VH=VDD; % The highest output voltage
if nargin>4&sum(vi1>0&vi1<=VDD)>0 % If you want vo for vi1
for i=1:length(vi1)
[dmin,imin] = min(abs(vis-vi1(i)));
vo1(i)=vos(imin); iD1(i)=iDs(imin);
end
else
vo1=vos; iD1 = iDs;
end
fprintf("\n VIL=%6.3f, VIH=%6.3f, VOL=%6.3f, VOH=%6.3f, VM=%6.3f,VIT=%6.3f, VOT=%6.3f, VOE=%6.3f", VIL,VIH,VOL,VOH,VM,VIT,VOT);
fprintf("\n Noise Margin: NM_L=%6.3f and NM_H=%6.3f", NML,NMH);
fprintf("\n Output signal swing: VOL(%6.2f )~VOH(%6.2f ) = %6.2f[V]",VOL,VOH,VOH-VOL);
fprintf("\n Average power dissipated=%10.3e[mW]\n", PDavg*1e3);
% Plot the VTC curve
plot(vis,vos, [VIL VM VIH],[VOH VM VOL],'ro')
hold on, plot([Vt VIT VH],[VH VOT VL],'r^')
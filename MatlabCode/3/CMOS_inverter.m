function [VIL,VIH,VOL,VOH,Vm,VIT1,VOT1,VIT2,VOT2,VLH,NML,NMH,PDavg]=...
CMOS_inverter(KNP,VtNP,VDD,Kg)
% To find all the parameters of a CMOS inverter.
% KNP = [KN'(WN/LN) KP'(WP/LP)]
% VtNP = [VtN VtP]: Threshold (Pinch-off ) voltages of NMOS/PMOS
% Copyleft: Won Y. Yang, wyyang53@hanmail.net, CAU for academic use only
if nargin<4, Kg=0; end
if numel(KNP)>1, KN=KNP(1); KP=KNP(2); else KN=KNP; KP=KNP; end
if numel(VtNP)>1, VtN=VtNP(1); VtP=VtNP(2); else VtN=VtNP;
VtP=-VtNP; end
Kr2=KN/KP; Kr=sqrt(Kr2); % Ratio between conduction parameters of Mn and Mp
VOL=0; VOH=VDD; VH=VOH; % The lowest/highest output voltage
Vm=(VDD+VtP+Kr*VtN)/(1+Kr); % Eq.(4.1.65)
VIT2=Vm; VOT2=Vm-VtP; VIT1=Vm; VOT1=Vm-VtN; % Boundary points of Region III
dv=0.001; vis=[0:dv:VDD]; % Input voltage range
for n=1:length(vis)
vi=vis(n);
if vi<VtN, iDs(n)=0; vos(n)=VDD; % Mn OFF, Mp in ohmic region (Region I)
elseif vi<=Vm % Mn/Mp are saturation/ohmic region (Region II)
B=2*(VtP-vi); C=Kr2*(vi-VtN)^2+VDD*(2*(vi-VtP)-VDD); %Eq.(4.1.66)
vos(n)=(-B+sqrt(max(B^2-4*C,0)))/2; iDs(n)=KN/2*(vi-VtN)^2;
elseif vi<=VDD+VtP % Mp/Mn=saturation/triode (Region IV)
B=2*(VtN-vi); C=(VDD-vi+VtP)^2/Kr2; % Eq.(4.1.69)
vos(n)=(-B-sqrt(max(B^2-4*C,0)))/2; iDs(n)=KP/2*(VDD-vi+VtP)^2;
else iDs(n)=0; vos(n)=0; % Mn in triode region, Mp OFF (Region V)
end
% Here, Region III (Mp/Mn: sat) doesn't have to be taken care of
% since at most only a single value of vi=Vm can belong to that region.
end
[VIL,VIH,VOL,VOH,VM,NML,NMH,VL,PDavg]= ...
find_pars_of_inverter(vis,vos,iDs,VDD);
if Kg>0
subplot(221)
plot(vis,vos), hold on
plot([VIL VM VIH],[VOH VM VOL],'ro', [VtN VH],[VH VL],'r^')
title('VTC of a CMOS inverter')
subplot(222)
plot(vis,iDs), title('Drain current of the CMOS inverter'), grid on
end

VDD=12; R1=4e3; R2=8e3; RD=2e3; RS=10e3; % Circuit parameters
Kp=2e-5; Vt=1; % FET parameters
VGG=VDD*R2/(R1+R2);
vGSs=[0:1e-3:VGG]; % Range of vGS for which iD and load line are plotted.
iDs=Kp/2*(vGSs-Vt).^2; % iD-vGS characteristic in the saturation mode
iDs_load_line = (VGG-vGSs)/RS; % Load line
[vmin,imin] = min(abs(iDs-iDs_load_line)); % Find the intersection Q
IDQ=iDs(imin), VGSQ=vGSs(imin), VDSQ=VDD-(RD+RS)*IDQ % Q-point
subplot(221)
plot(vGSs,iDs, vGSs,iDs_load_line,'r', VGSQ,IDQ,'mo')
subplot(222)
vDSs=[0:1e-3:VDD]; vOVs=0:5;
for i=1:length(vOVs)
vGS = Vt + vOVs(i);
iDs = iD_NMOS_at_vDS_vGS(vDSs,vGS,Kp,Vt); % iD-vDS characteristic
plot(vDSs,iDs), hold on
text(0.85*VDD,max(iDs)+5e-6,['vGS=' num2str(vGS) '[V]'])
end
% Boundary between ohmic/saturation regions by Eq.(4.1.14)
plot(vDSs,Kp/2*vDSs.^2,'g:')
plot(vDSs,iD_NMOS_at_vDS_vGS(vDSs,VGSQ,Kp,Vt),'m', VDSQ,IDQ,'mo')
plot([0 VDD],(VDD-[0 VDD])/(RD+RS),'m'), % Load line
axis([0 VDD 0 27e-5])
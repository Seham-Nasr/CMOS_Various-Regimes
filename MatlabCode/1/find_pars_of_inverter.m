function [VIL,VIH,VOL,VOH,VM,NML,NMH,VL,Pavg]=...
find_pars_of_inverter(vis,vos,is,Vs,VH)
if nargin<5, VH=Vs; end % Highest output voltage
dvs=abs(diff(vis)); dv=min(dvs(find(dvs>1e-6)));
[pks,locs]=findpeaks(1./abs(diff([vos(1) vos])+dv));
[pks,inds]=sort(pks,'descend'); inds1=locs(inds(1:2));
[VLH,inds2]=sort(vis(inds1)); % Points with slope=-1
VIL=VLH(1); VIH=VLH(2); VOH=vos(inds1(inds2(1))); VOL=vos(inds1(inds2(2)));
NML = VIL-VOL; NMH = VOH-VIH; % Eq.(3.1.64)
[em,imin]=min(abs(vis-vos)); VM=vis(imin); % Midpoint
[em,imin]=min(abs(vis-VH)); VL=vos(imin); % Virtual lowest output
Pavg=Vs*mean([max(is) min(is)]); % Average power for on-off periods
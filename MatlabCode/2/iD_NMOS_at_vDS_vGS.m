function iD=iD_NMOS_at_vDS_vGS(vDS,vGS,Kp,Vt,lambda)
if nargin<5, lambda=0; end
vGD=vGS-vDS; ON=(vGS>Vt); SAT=(vGD<=Vt)&ON; TRI=(vGD>Vt)&ON;
iD=Kp*(1+lambda*vDS).*(((vGS-Vt).*vDS-vDS.^2/2).*TRI ...
+(vGS-Vt).^2/2.*SAT); 
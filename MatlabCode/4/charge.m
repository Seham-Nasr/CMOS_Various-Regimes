function [io,ID1,v,Ro,Vomin]= ...
FET4_current_mirror_Wilson(Kp,Vt,lambda,R,V12)
% To analyze a 4-FET (double) Wilson current mirror like Fig.4.15
% with R (resistor) or I (current source)
% If 0<R<1, R will be regarded as a current source I=R with with R=inf.
% Copyleft: Won Y. Yang, wyyang53@hanmail.net, CAU for academic use only
V1=V12(1); if length(V12)>1, V2s=V12(2:end); else V2s=V12; end
if length(Kp)<4, Kp=repmat(Kp(1),1,4); end
iDvGS_GDs=@(vGS,Kp,Vt)Kp/2*(vGS-Vt).^2.*(1+lambda*vGS); %GD shorted
options=optimset('Display','off','Diagnostics','off');
n0=1; % To determine the index of V2s closest to V1
for n=1:length(V2s)
V2=V2s(n); if n>1&(V2-V1)*(V2s(n-1)-V1)<=0, n0=n; end
if R>=1|R==0, RL=R;
eq=@(v)[(iDvGS_GDs(v(3)-v(2),Kp(3),Vt)-...
iD_NMOS_at_vDS_vGS(v(2),v(1),Kp(1),Vt,lambda))*1e4; % Eq.(4.1.31a)
(iD_NMOS_at_vDS_vGS(V2-v(1),v(3)-v(1),Kp(4),Vt,lambda)- ...
iDvGS_GDs(v(1),Kp(2),Vt))*1e4; % Eq.(4.1.31b)
V1-v(3)-R*iDvGS_GDs(v(3)-v(2),Kp(3),Vt)]; % Eq.(4.1.31c)
else I=R; RL=inf;
eq=@(v)[iDvGS_GDs(v(3)-v(2),Kp(3),Vt)- ...
iD_NMOS_at_vDS_vGS(v(2),v(1),Kp(1),Vt,lambda); %Eq.(4.1.31a)
iD_NMOS_at_vDS_vGS(V2-v(1),v(3)-v(1),Kp(4),Vt,lambda)- ...
iDvGS_GDs(v(1),Kp(2),Vt); % Eq.(4.1.31b)
I-iDvGS_GDs(v(3)-v(2),Kp(3),Vt)]*1e4; % Eq.(4.1.31c)
end
v0=[V1/4 V1/2 2/3*V1]; % Initial guess for v=[v(1) v(2) v(3)]
v=fsolve(eq,v0,options); vs(n,:)=v;
ID1=iDvGS_GDs(v(3)-v(2),Kp(3),Vt);
io(n)=iD_NMOS_at_vDS_vGS(V2-v(1),v(3)-v(1),Kp(4),Vt,lambda);
end
Io=io(n0); V2=V2s(n0); v=vs(n0,:); % Values of io, V2, vs when V2=V1
gm1=2*ID1/(v(1)-Vt); ro1=1/lambda/ID1;
gm2=2*Io/(v(1)-Vt); ro2=1/lambda/Io;
gm3=2*Io/(v(3)-v(2)-Vt); ro3=1/lambda/ID1;
gm4=2*Io/(v(3)-v(1)-Vt); ro4=1/lambda/Io;
if RL==inf, Ro=ro4+1/gm2+gm4*ro4*(gm1/gm2*ro1+1/gm2);
else Ro=ro4+(1+gm4*ro4*(gm1*ro1*RL/(ro1+RL+1/gm3)+1))/gm2;
% Eq.(4.1.33)
end
Vomin=v(3)-Vt; % Minimum output voltage by Eq.(4.1.34)
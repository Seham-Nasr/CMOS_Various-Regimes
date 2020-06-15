function [vo,iD]=vo_iD_NMOS_inverter(Kp,Vt,RD,VIT,VDD,vi)
for n=1:length(vi)
if vi(n)<=Vt, vo(n)=VDD; iD(n)=0; % Cutoff region
elseif vi(n)<=VIT % Saturation region
iD(n)=Kp/2*(vi(n)-Vt).^2; vo(n)=VDD-RD*iD(n); % Eq.(4.1.35)
else % Triode region
a=Kp*RD/2; b=-(Kp*RD*(vi(n)-Vt)+1); c=VDD;
vo(n) = (-b-sqrt(b^2-4*a*c))/2/a; % Eq.(4.1.36)
iD(n) = (VDD-vo(n))/RD;
end
end
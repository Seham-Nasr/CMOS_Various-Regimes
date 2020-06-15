function express_L_filter(X1s,X2s,wc,type)
for n=1:length(X1s)
   X1=imag(X1s(n)); X2=imag(X2s(n));
   if ~(X1==0|X2==0)
if X1>0
L1=X1/wc*1e6; 
fprintf(['L' num2str(type) '-type impedance matcher with L1=%8.3e[uH]'],L1);
else 
C1=-1e9/X1/wc;
fprintf(['L' num2str(type) '-type impedance matcher with C1=%8.3e[nF]'],C1);
     end
     if X2>0, L2=X2/wc*1e6; fprintf(' and L2=%8.3e[uH]\n',L2);
      else  C2=-1e9/X2/wc; fprintf(' and C2=%8.3e[nF]\n',C2);
     end
   end
end

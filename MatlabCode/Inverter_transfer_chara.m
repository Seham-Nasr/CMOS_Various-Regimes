Vtn = 0.7; 
Vtp = -0.7;
Kn=100; 
Kp=50;
Wn=2;
Wp=4;
Bn = Kn * Wn;
Bp = Kp * Wp;
Yp=0.05; Yn=0.04;
Vdd=5;
y=zeros(1,5/0.005+1);
i=1;
for V=(0:0.005:5);
    if (V>=0)&&(V<0.7)
        y(i)= Vdd;
    elseif (V>=0.7) && (V< y(i-1)-0.7)
        y(i)=V+abs(Vtp)+sqrt((Vdd-abs(Vtp)-V)^2-(Bn/Bp)*(V-Vtn)^2);
    elseif (V>=y(i-1)-0.7)&&(V<y(i-1)+0.7)
        y(i)= ((Bp*(1+Yp*Vdd)* (Vdd-abs(Vtp)-V)^2)-Bn*(V-Vtn)^2)/(Bn*Yn*(V-Vtn)^2+Bp*Yp*(Vdd-abs(Vtp)-V)^2);
    elseif (V >= y(i-1)+0.7)&&(V<4.3)
        y(i)=V-Vtn-sqrt(abs((V-Vtn)^2 -(Bp/Bn)*(Vdd-abs(Vtn)-V)^2));
    elseif (V>=4.3)&& (V<5)
        y(i)=0;
    end
    i=i+1;
end
plot(0:0.005:5,y,'b');
title('CMOS Inverter transmission characteristics');
xlabel('Vin');
ylabel('Vout');
grid on;
axis square; 
    

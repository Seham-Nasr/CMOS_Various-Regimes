Vtn=0.7;Vtp=-0.7;
Kn=100;Kp=50;
yp=0.05;yn=0.04;
Vdd=6;
y=zeros(1,5/0.005+1);z=zeros(1,5/0.005+1);m=zeros(1,5/0.005+1);
i=1;j=1;k=1;

for V=(0:0.005:5)
    WLRn=2;WLRp=4;
    Bn=Kn*WLRn;Bp=Kp*WLRp;
    if(V>=0)&&(V<0.7)
        y(i)=Vdd;
    elseif(V>=0.7)&&(V<y(i-1)-0.7)
        y(i)=V+abs(Vtp)+sqrt((Vdd-abs(Vtp)-V)^2-(Bn/Bp)*(V-Vtn)^2);
    elseif(V>=y(i-1)-0.7)&&(V<y(i-1)+0.7)
        y(i)=((Bp*(1+yp*Vdd)*(Vdd-abs(Vtp)-V)^2)-Bn*(V-Vtn)^2)/(Bn*yn*(V-Vtn)^2+Bp*yp*(Vdd-abs(Vtp)-V)^2);
    elseif(V>=y(i-1)+0.7)&&(V<4.3)
        y(i)=V-Vtn-sqrt(abs((V-Vtn)^2-(Bp/Bn)*(Vdd-abs(Vtn)-V)^2));
    elseif(V>=4.3)&&(V<5)
        y(i)=0;
    end
    i=i+1;
end
for V=(0:0.005:5)
    WLRn=3;WLRp=4;
    Bn=Kn*WLRn;Bp=Kp*WLRp;
    if(V>=0)&&(V<0.7)
        z(j)=Vdd;
    elseif(V>=0.7)&&(V<z(j-1)-0.7)
        z(j)=V+abs(Vtp)+sqrt((Vdd-abs(Vtp)-V)^2-(Bn/Bp)*(V-Vtn)^2);
    elseif(V>=z(j-1)-0.7)&&(V<z(j-1)+0.7)
        z(j)=((Bp*(1+yp*Vdd)*(Vdd-abs(Vtp)-V)^2)-Bn*(V-Vtn)^2)/(Bn*yn*(V-Vtn)^2+Bp*yp*(Vdd-abs(Vtp)-V)^2);
    elseif(V>=z(j-1)+0.7)&&(V<4.3)
        z(j)=V-Vtn-sqrt(abs((V-Vtn)^2-(Bp/Bn)*(Vdd-abs(Vtn)-V)^2));
    elseif(V>=4.3)&&(V<5)
        z(j)=0;
    end
    j=j+1;
end
for V=(0:0.005:5)
    WLRn=5;WLRp=4;
    Bn=Kn*WLRn;Bp=Kp*WLRp;
    if(V>=0)&&(V<0.7)
        m(k)=Vdd;
    elseif(V>=0.7)&&(V<m(k-1)-0.7)
        m(k)=V+abs(Vtp)+sqrt((Vdd-abs(Vtp)-V)^2-(Bn/Bp)*(V-Vtn)^2);
    elseif(V>=m(k-1)-0.7)&&(V<m(k-1)+0.7)
        m(k)=((Bp*(1+yp*Vdd)*(Vdd-abs(Vtp)-V)^2)-Bn*(V-Vtn)^2)/(Bn*yn*(V-Vtn)^2+Bp*yp*(Vdd-abs(Vtp)-V)^2);
    elseif(V>=m(k-1)+0.7)&&(V<4.3)
        m(k)=V-Vtn-sqrt(abs((V-Vtn)^2-(Bp/Bn)*(Vdd-abs(Vtn)-V)^2));
    elseif(V>=4.3)&&(V<5)
        m(k)=0;
    end
    k=k+1;
end
plot(0:0.005:5,y,'k',0:0.005:5,z,'b',0:0.005:5,m,'r');
title('CMOS Inverter: Voltage Transfer Characteristics');
xlabel('Vin');ylabel('Vout');
legend('Bp/Bn=1','Bp/Bn=1.5','Bp/Bn=2.5','location','NorthEast');
grid on;
axis square;
clear all;
close all;
clc

%Initializing values
r1 = 1.4;                   %Stator resistance
x1 = 6.875;                 %Stator reactance
r2 = 7.46;                  %Rotor resistance
x2 = 6.875;                 %Rotor reactance
xm = 379.1;                 %Magnetization branch reactance
rc = 1146;
v1 = 400;                   %Phase voltage

ns = 1800;                  %Synchronous speed (rpm)
ws = 188.5;                 %Synchronous speed (rad/s)

%Creating many slips between 0 and 1 and starting from
%0.001 to avoid program crashing

k = [0:1:50];
s = k/50;     
s(1) = 0.001;
nm =(1-s)*ns;      


%Original circuit
for i = 1:51
    z1 = r1 + j*x1;
    zp = (rc*j*xm)/(rc+j*xm);
    z2(i) = r2/s(i) + j*x2;
    ztotal(i) = z1 + (z2(i)*zp)/(z2(i)+zp);
    i1(i) = 400 / ztotal(i);
    ztotal_abs(i) = abs(ztotal(i));
    ztotal_theta(i) = angle(ztotal(i));
    theta_cos(i) = cos(ztotal_theta(i));
    p_ph(i) = v1 * abs(i1(i)) * theta_cos(i);
    i2(i) = 400 / z2(i);
    i2_abs(i) = abs(i2(i));
    p_el(i) = 3* p_ph(i);
    p_ag(i) = 3*(abs(i2(i))^2)* r2/s(i);
    p_mech(i) = (1-s(i))*p_ag(i);
    eff(i) = p_mech(i)/p_el(i); 
end


%Plot the torque speed characteristic
figure()
plot(nm,eff,'LineWidth',1.0);
xlabel('Speed (rpm)');
ylabel('n');
title('Efficiency-speed characteristic');
grid on;






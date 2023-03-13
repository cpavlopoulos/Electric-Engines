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
    e1(i) = v1 - i1(i)*(r1+j*x1);
    t_em1(i) = (3*(real(e1(i))^2) *(r2/s(i))) / (ws * (( r2/s(i) )^2 + (x2)^2));
    
end

%Shifted parallel part circuit
for n = 1:51
    t_em2(n) = ( 3 * v1^2 * r2 /s(n)) / (ws * ((r1 + r2/s(n) )^2 +(x1 +x2)^2 ));
end

%Plot the torque speed characteristic
figure()
plot(nm,t_em1,'g','LineWidth',1.0);
hold on;
plot(nm,t_em2,'m','LineWidth',1.0);
xlabel('Speed (rpm)');
ylabel('Torque (nm)');
title('Torque-speed characteristic');
legend('Equivalent circuit A', 'Equivalent Circuit B');
grid on;

for c = 1:51
    z1 = r1 + j*x1;
    zp = (rc*j*xm)/(rc+j*xm);
    z2(c) = r2/s(c) + j*x2;
    ztotal(c) = z1 + (z2(c)*zp)/(z2(c)+zp);
    i1a(c) = v1 / abs(ztotal(c));
end

for y = 1:51
    zs(y) = r1 + j*x1 + r2/s(y) + j*x2;
    zp = (rc*j*xm)/(rc+j*xm);
    ztotal2(y) = (zs(y)*zp)/(zs(y)+zp);
    i1b(y) = v1 / abs(ztotal2(y));
end

%Plot the current speed characteristic

figure()
plot(nm, i1a,'g','LineWidth',1.0);
hold on 
plot(nm, i1b,'m','LineWidth',1.0);
xlabel('Speed (rpm)');
ylabel('Stator current (A)');
title('Stator current-speed characteristic');
legend('Equivalent circuit A', 'Equivalent Circuit B');
grid on;

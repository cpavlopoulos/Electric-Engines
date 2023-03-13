clear all
close all
clc

%Initializing values
r1 = 1.4;                   %Stator resistance
x1 = 6.875;                 %Stator reactance
r2 = 7.46/0.06;                  %Rotor resistance
x2 = 6.875;                 %Rotor reactance
xm = 379.1;                 %Magnetization branch reactance
rc = 1146;

z1 = r1 + j*x1;
zp = (rc*j*xm)/(rc+j*xm);
z2 = r2 + j*x2;

ztotal = z1 + (z2*zp)/(z2+zp)

za = abs(ztotal)

i1 = 400 / ztotal

i1a = abs(i1)

i2 = 400 / z2

i2a = abs(i2)

icm = i1 - i2

icma = abs(icm)


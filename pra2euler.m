% Práctica 2, simulado péndulo simple

clc
clear 
close all

%Simulación práctica de péndulo
% Lectura base de datos
datos = readtable("datos_final - Sheet2.csv");
% Extrayendo colmuna con promedios
volt =table2array(datos(:,17));
% Vector tiempo
tiempo = (1:length(volt))';

% Grados a partir del voltaje en bits
theta = ((volt*90)/volt(end))-90;
theta = (deg2rad(theta))';

% Solución por método de Euler 
% Parámetros :
h = 1e-2;
tfin = length(theta)*h;
N = ceil((tfin-h)/h);
%t = h +(0:N)*h;
% vector que corresponda con el tamaño de los datos obtenidos
% experimentalmente (solo así medio salió)
t = (1:89)';
g = 9.81;
m = 0.061;
l = 0.24;

% coeficiente de fricción (kf)
% Por optimización daba cosas muy raras xd
dtheta = diff(theta)/h; %primera derivada theta
ddtheta = diff(dtheta)/h; %segunda derivada theta

% Ajustando tamaño de vectores 
thetai = theta(1:length(ddtheta));
dtheta = dtheta(1:length(ddtheta)); 

kf = (-m*ddtheta - (g/l)*m*sin(thetai))/(dtheta)

%Condiciones iniciales
theta1o = deg2rad(108);
theta2o = deg2rad(0);

% Resolución por Euler
thet1 = [theta1o zeros(1,N-1)];
thet2 = [theta2o zeros(1,N-1)];

for n = 1 : N
    thet1(n+1) = thet1(n) + h*(thet2(n));
    thet2(n+1) = thet2(n) + h*((-g/l)*sin(thet1(n)) - (kf/m)*thet2(n));
end
plot(t, thet1)
title('Sistema simulado')

% Comparación de datos simulados y experimentales 
plot(tiempo, theta)
title('Datos experimentales contra simulados')
xlabel('Tiempo') 
ylabel('Radianes')
hold on
plot(t, thet1)

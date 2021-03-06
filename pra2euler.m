clc
clear 
close all

%Simulación práctica de péndulo

datos = readtable("datos_final - Sheet2.csv");

volt =table2array(datos(:,17));
tiempo = (1:length(volt))';


% Obteniendo grados a partir del voltaje en bits
theta = ((volt*90)/volt(end))-90;
theta = (deg2rad(theta))';

% Solución por método de Euler 
h = 7e-2;
tfin = length(theta)*h;
N = ceil((tfin-h)/h);
%t = h +(0:N)*h;
t = (1:89)';
g = 9.81;
m = 0.061;
l = 0.24;

%Condiciones iniciales
theta1o = deg2rad(108);
theta2o = deg2rad(0);

%encontrando el coeficiente de fricción (kf)
thetap = diff(theta)/h; %primera derivada numerica de theta
thetapp = diff(thetap)/h; %segunda derivada númerica de theta

%se reacomoda el tamaño de los vectores al tamaño de thetapp, pues el vector es -2 veces más chico que theta
theta_i = theta(1:length(thetapp));
thetap = thetap(1:length(thetapp)); 

kf = (-m*thetapp - (g/l)*m*sin(theta_i))/(thetap);
kf= kf + 0.04;
% Resolución por Euler
thet1 = [theta1o zeros(1,N-1)];
thet2 = [theta2o zeros(1,N-1)];

for n = 1 : N
    thet1(n+1) = thet1(n) + h*(thet2(n));
    thet2(n+1) = thet2(n) + h*((-g/l)*sin(thet1(n)) - (kf/m)*thet2(n));
end

%rmse = sqrt(mean((theta-thet1).^2));

plot(tiempo, theta, 'DisplayName','Experimentales')
title('Datos experimentales vs simulados')
xlabel('tiempo') 
ylabel('radianes')
hold on
plot(t, thet1, 'DisplayName','Simulados')
hold off
lgd = legend;
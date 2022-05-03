%% Main 
clc
%clear

%% Main 
close all 
freqexp = 0.001;
simuld = thet1; %varName2 es el voltaje
sdVar = std(theta);

tiempo = transpose(1:length(theta));



figure    
    plot(theta)
    hold on
    plot(simuld)
    legend('Experimentales','simulación')
    title('Experimentales vs simulación')


EXPVSIM(theta,simuld,tiempo, freqexp) %VarName1 es el tiempo 




%% Filtrado
% newfiltered = gaussf(theta);
% figure;
% plot(newfiltered)
% title('newfilter')

nf = imgaussfilt(theta);
figure
plot(theta)
hold on
plot(nf);
legend('Con ruido', 'Filtrados')
title('Datos filtrados vs datos con ruido (Gauss)')


%Moving average filter 

g = maf(theta, 2);
figure
plot(theta)

hold on 
plot(g)
legend('Con ruido', 'Filtrados')
title('Datos filtrados y datos con ruido (MAF)') %Se mueve la gráfica



%% Llamada de datos experimentales y proceso de filtrado
%   Pasos:
%   1. Método de algún filtro 
%   2. Método para llamar los datos y aplicar el filtro 
%

function datafilter = DATAFILTER(datos, stdev,samplfreq)
dt = 1/samplfreq;

g = fspecial("gaussian",[1 dt],stdev);
plot(datos)
title('Datos originales');
g=fspecial('gaussian',[1 dt],stdev);
figure;
plot(g);
title('Gaussiana');
y=conv(datos,g);
figure;
plot(datos,'b');
hold on;
plot(y,'r','linewidth',2);
legend('Señal con ruido','Señal sin ruido');



end
%% Moving - Average Filter 
function movavg = maf(data, winsize)
b = (1/winsize)*ones(1, winsize);
a = 1;

movavg = filter(b,a,data);

end



%% Comparación entre los datos experimentales y los valores obtenidos mediante **simulación**
%   Pasos: 
%   1. Recuperar función benchmark
%   2. Método para graficar datos experimentales vs simulación
%       2.1 Generar método con argumentos: epData, simulData o
%       simulFunction
%       2.2 Llamar función de benchmarck 
%       2.3 Mostrar criterios integrales y estadísticos 





function expvsim = EXPVSIM(expdata,simuldata,time ,samplfreq)
    dt = 1/samplfreq;
    
    expvsim = benchmark(simuldata,expdata, time,dt);

end
%% filtro 
%Otra alternativa 

function gaussfilter = gaussf(data)
    gausx = zeros(length(data),0);
    for i = 1 : length(data)
        gausx(i) = (1/(sqrt(2*pi)*std(data)))*exp((-data(i)^2)/(2*std(data)^2));
        
    end
    gaussfilter = gausx;
end



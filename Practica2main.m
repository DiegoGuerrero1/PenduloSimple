%% Main 
clc
%clear
close all 
freqexp = 0.001;
simuld = VarName2;
sdVar = std(VarName2);
for i = 1:(length(VarName2)/2)
    simuld(i) = VarName2(i)-100;
end


EXPVSIM(VarName2,simuld,VarName1, freqexp)
DATAFILTER(VarName2, sdVar ,freqexp)





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
title('Datos aplicando filtro gausiano');
y=conv(datos,g);
figure;
plot(datos,'b');
hold on;
plot(y,'r','linewidth',2);
legend('Señal con ruido','Señal sin ruido');



end

%% Comparación entre los datos experimentales y los valores obtenidos mediante **simulación**
%   Pasos: 
%   1. Recuperar función benchmark
%   2. Método para graficar datos experimentales vs simulación
%       2.1 Generar método con argumentos: epData, simulData o
%       simulFunction
%       2.2 Llamar función de benchmarck 
%       2.3 Mostrar criterios integrales y estadísticos 





function expvsim = EXPVSIM(expdata,simuldata, time, samplfreq)
    dt = 1/samplfreq;
    plot(time,expdata, time, simuldata)
    
    benchmark(simuldata,expdata, time,dt)

end

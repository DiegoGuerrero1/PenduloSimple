function out = benchmark(y,yg,t,dt)
    out.MSE = MSE(y,yg);
    out.RMSE = RMSE(y,yg);
    out.MAE = MAE(y,yg);
    out.MAPE = MAPE(y,yg);
    out.ITAE = ITAE(y,yg,t,dt);
    out.FIT = FIT(yg, y);
end

function mse = MSE(y,yg)
    mse = mean((y-yg).^2);
end

function rmse = RMSE(y,yg)
    rmse = sqrt(MSE(y,yg));
end

function mae = MAE(y,yg)
    mae = mean(abs(y-yg));
end

function mape = MAPE(y,yg)
    mape = 100*mean((y-yg)/length(y));
end

function itae = ITAE(y,yg,t,dt)
    itae = trapz(t.*abs(y-yg))*dt;
end

function fit = FIT(yg, y)
mye = y - mean(y);
ye = y - yg;
arg = norm(ye)/norm(mye);
fit = 100*(1-arg);
end
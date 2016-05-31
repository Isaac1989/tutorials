t0=0; T=2;          %given data
u0=[-3 ; -2; 2];     

options = odeset('AbsTol',tol,'RelTol',tol);

f=@(t,X)[X(2);X(3);4*(t^2)+8*t-10-4*X(1)-4*X(2)-X(3)]; %RHS of system of ODE

[time,U]=ode113(f,[t0,T],u0); %solving ODE


%plots of graphs
plot(time,U(:,1),'o-');         
hold on
TS=@(t) -sin(2*t) + t.^2 -3;

plot(time, TS(time));

xlabel('time')
ylabel('U') 
title('appro solution to true soluton v(t)=-sin(2*t) + t.^2 -3')
legend('Estimate','True solution','Location','Northwest')

maxerror = max(abs(U(:,1)-TS(time)))
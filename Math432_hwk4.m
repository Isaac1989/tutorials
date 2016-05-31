%This file is to stimulate Forward Euler for a system of equations
K1=3;
K2=1;
init=[3;4;2];
pos=-3:1:3;
for i=1:length(pos)
k=1/(17+pos(i));
T=[0,2];

f= @(U,t) [-K1*U(1)*U(2)+ K2*U(3);...
          -K1*U(1)*U(2)+ K2*U(3);...
          K1*U(1)*U(2)-K2*U(3)];
      
      
[t,sol]=FE(init,f,T,k);
figure()
plot(t,sol(:,1),'ro-')
hold on
plot(t,sol(:,2),'g-o')
hold on 
plot(t,sol(:,3),'b','LineWidth',3)
xlabel('time')
ylabel('level of concentration')
title(sprintf('step size=%f',k))
%legend('A','B','C','Position',[0,2,2,2])
legend('A','B','C','Location','eastoutside')

hold off
end

%%
K1=300;
K2=1;
init=[3;4;2];
k=2/1000;
T=[0,2];

f= @(U,t) [-K1*U(1)*U(2)+ K2*U(3);...
          -K1*U(1)*U(2)+ K2*U(3);...
          K1*U(1)*U(2)-K2*U(3)];
      
     
[t,sol]=FE(init,f,T,k);
figure()
plot(t,sol(:,1),'ro-')
hold on
plot(t,sol(:,2),'g-o')
hold on 
plot(t,sol(:,3),'b','LineWidth',3)
xlabel('time')
ylabel('level of concentration')
legend('A','B','C','Location','eastoutside')
hold off
title(sprintf('step size=%f',k))


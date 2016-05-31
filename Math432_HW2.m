x=linspace(0,1, 6);
h=x(2)-x(1);
fac=1/(h^2);
L=[-2 1 0 0 0;1 -2 1 0 0; 0 1 -2 1 0; 0 0 1 -2 1;0 0 h/2 -2*h 1.5*h];

f=@(x) x;

F=[f(x(2))-fac;f(x(3));f(x(4));f(x(5));1];

A=fac*L;

U=A\F;
U1=zeros(1,length(x));
U1(1)=1;
for k=2:6
    U1(k)=U(k-1);
end

plot(x,U1)
title('approximated solution of u"(x)=x with BC u(0)=du(1)=1')
hold on
xlabel('nodes')

ylabel('U')

axis([-0.2 1.5 0.8 2])

eigen=eig(A);

%--------------------------------------------------

g=@(x) (x.^3)./6 + 0.5.*x +1;
plot(x,g(x),'-o')
legend('approximated soln','True solution')

Global_error=U1-g(x)
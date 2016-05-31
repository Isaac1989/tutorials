% Isaac Oduro
% Math432
%Homework 1
%Question #3c

hvals = logspace(-1,-4,13);
ED2u = []; 
uptrue= -4*cos(2);

% table headings:
disp(' ')
disp('       h           error[D^2(U(x))] ')
disp('   ')


for i=1:length(hvals)
   h = hvals(i);
   % approximations to u"(1):
   xpts = 1 + h*(-2:2)';
   D4u = fdcoeffF(2,1,xpts) * (cos(2*xpts)+1);
   % errors:
   ED2u(i) = D4u - uptrue;

   % print line of table:
   disp(sprintf('%13.4e   %13.4e ',...
                 h,ED2u(i)))
end

% plot errors:
clf
loglog(hvals,abs(ED2u),'o-')
axis([1e-5 1e-0 1e-12 1e-3])
title('A plot of Error vs mesh size')
xlabel('h')
ylabel('Error')

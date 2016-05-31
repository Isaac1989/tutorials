%AUTHOR: ISAAC ODURO
%MATH441
%PROJECT 3

%THE CODES BELOW STIMULATE THE DISCRETE AND CONTINUOUS 
%DISTRIBUTIONS USING THE discreteSampler and continuousSampler RESPECTIVELY
%DISCRETE DISTRIBUTION: BINOMIAL AND HYPERGEOMETRIC
%CONTINUOUS DISTRIBUTION: NORMAL, EXPONENTIAL AND RAYLEIGH

%You can run the this file for the results or each section for
%independ results


%%STIMULATING BINOMIAL DISTRIBUTION
%----------------------------------------------------------
rng(6)

%Definition of distribution
%-------------------------
Binomial=@(p,n,k)....
(factorial(n)/(factorial(n-k)*factorial(k)))*(p^k)...
*((1-p)^(n-k));
%-------------------------

%Computing probabilities
N=10;
E=(0:N)';
P=NaN(N,1);
s=0.5;
for k=1:N+1
    P(k)=Binomial(s,N,E(k));
end

%Computing CDF of binomial
%-------------------------
bpc=zeros(N,1);
bpc(1)=P(1);
for k=2:N+1
    bpc(k)=bpc(k-1)+P(k);
end

%--------------------------------------------------
%CDF OF BINOMIAL
%---------------
figure
plot(E,bpc,'--mo')
title('Cdf of Binomial distribution')
hold on
plot(E,binocdf(E,N,s),'r*')
legend('Estimated BinoCDF','True BinoCDF','location','southeast')
%---------------------------------------------------

%Histogram of sample
%------------------------------
sampleSize=[10 100 1000 10000];
figg=figure;
set(figg,'name','Binomial distribution' )
for k=1:4
    Bsample=discreteSampler(E,P,sampleSize(k));  %discrete sampling
    subplot(2,2,k)
    plot(0:N,P,'gs','Markersize',10)
    hold on
    
    numOfBins=N;
    [binCount,binCenters]=hist(Bsample,numOfBins);
    [rows,cols]=size(binCenters);
    binWidth=(binCenters(cols)-binCenters(cols-1));
    histArea=binWidth*sum(binCount);
    plot(binCenters,1/histArea*binCount,'*')
    hold off
    if k==2
       legend('Binomial Distribution','Sample Distr. of Binomial','Location'...
          ,'southoutside')
    end
    title(['sample size ',num2str(sampleSize(k))])
end


%% STIMULATION OF HYPERGEOMETRIC DISTRIBUTION
%-----------------------------------------------------------

%Definition of distribution
%-----------------------------
%N=1,2,3...   K=1,2,...N     n=1...N
rng(6)
hypergeometric=@(N,K,n,k)... 
( (factorial(K)/(factorial(K-k)*factorial(k)))*...
   (factorial(N-K)/(factorial(N-K-n+k)*factorial(n-k))))/...
  (factorial(N)/(factorial(N-n)*factorial(n)));


%Compute probabilities
N=50;
n=10;
K=20;
E=(0:n)';
P=NaN(n,1);
for k=1:n+1
    P(k)=hypergeometric(N,K,n,E(k));
end

%Computing CDF of Hypergeometric
Hpc=zeros(n,1);
Hpc(1)=P(1);
for k=2:n+1
    Hpc(k)=Hpc(k-1)+P(k);
end

%CDF OF HYPERGEOMETRIC
%---------------------------------------------
figure
plot(E,Hpc,'-rs','Markersize',10)
title('CDF of Hypergeometric')
hold on
plot(E,hygecdf(E,N,K,n),'go')
legend('estimated cdf hypergeometric','True Hypergeometric CDF',...
    'location','southeast')

fig=figure;
set(fig,'name','hypergeometric distribution')
sampleSize=[10 100 1000 10000];

%Histogram of sample
%-------------------
for m=1:4
    numOfBins=n;
    Hsample=discreteSampler(E,P,sampleSize(m));
    subplot(2,2,m)
    plot(E,P,'rs','Markersize',10)
    hold on
    [binCount,binCenters]=hist(Hsample,numOfBins);
    [rows,cols]=size(binCenters);
    binWidth=(binCenters(cols)-binCenters(cols-1));
    histArea=binWidth*sum(binCount);
    plot(binCenters,1/histArea*binCount,'*')
    title(['Hypergeometric: ','Sample size',num2str(sampleSize(m))])
    if m==2
      legend('Hypergeometric Distribution','Sample of hypergeometric','Location'...
          ,'southoutside')
    end
    
    hold off
    
end



%% STIMULATION OF NORMAL DISTRIBUTION
%-----------------------------------------
rng(6)

%Definition of distribution
%----------------------------
Normal=@(x,mu,sigma) (1/sqrt(2*pi*sigma.^2)).*exp(-0.5.*((x-mu)/sigma).^2);
%-----------------------------------------

mu=0;  sigma=1;
sampleSizes=[10, 100, 1000,10000];
E = linspace(-10, 10, 1000);
%-----------------------------------------------

%Histogram for sampleSizes
f=figure;
set(f,'name','Samples from the Standard Normal distribution' )
for j=1:4
    [Nsample,cdf]=continuousSampler(E,Normal,sampleSizes(j),[0 1]);
    if j==1
         numOfBins=5;
    elseif j==2
        numOfBins=20;
    elseif j==3
        numOfBins=50;
    else
        numOfBins=100;
    end
        
    subplot(2,2,j)

    plot(E,Normal(E,mu,sigma),'r--','LineWidth',3)
    hold on

    %using MATLAB'S built-in sampler
    MNsample=randn(sampleSizes(j),1);

    %PLOT OF BUILT IN SAMPLE
    %========================
    %Gets bin centers and heights
    [binCount,binCenters]=hist(MNsample,numOfBins);

    %Gets total number of bin centers
    [rows,cols]=size(binCenters);

    %Calculate the bin width
    binWidth=(binCenters(cols)-binCenters(cols-1));

    %Calculate the area histogram
    histArea=binWidth*sum(binCount);

    %plot normalized histrogram
    plot(binCenters,1/histArea*binCount,'ko')
    hold on

    %PLOT OF SAMPLE FROM CUSTOM SAMPLER
    %=================================
    %Gets bin centers and heights
    [binCount,binCenters]=hist(Nsample,numOfBins);

    %Gets total number of bin centers
    [rows,cols]=size(binCenters);

    %Calculate the bin width
    binWidth=(binCenters(cols)-binCenters(cols-1));

    %Calculate the area histogram
    histArea=binWidth*sum(binCount);

    %plot normalized histrogram
    plot(binCenters,1/histArea*binCount,'g*')
    hold off
    if j==2
    legend('Gaussian distribution','randn sample','custom sample'...
        ,'location','Southoutside')
    end
    title(['Sample Size',num2str(sampleSizes(j))])
end
%-------------------------------------------------
%CDF OF NORMAL DISTRIBUTION
Ncdf=@(x,mu,sig) 0.5.*(1+ erf((x-mu)./sig*sqrt(2)));
fig=figure;
set(fig,'name','Cumulative Distribution of Normal')
plot(E,cdf,'m-','LineWidth',2)
hold on 
plot(E,Ncdf(E,0,1),'--gs','Markersize',5)
legend('Estimated CDF','True cdf','location','Southeast')
title('Cdf of Normal Standard')
%-------------------------------------------------

%% STIMULATING EXPONENTIAL DISTRIBUTION
rng(6)
sampleSizes=[10,100,1000,10000];  a=10   ;
exponential=@(x,lambda) lambda.*exp(-lambda.*x).*(x>=0) + 0*(x<0);
E=linspace(0,a,1000);
s=0.5;
%Histogram for sampleSizes
f=figure;
set(f,'name','Samples from the Exponential distribution' )
for j=1:4
    [Esample,cdf]=continuousSampler(E,exponential,sampleSizes(j),s);
    if j==1
        numOfBins=5;
    elseif j==2
        numOfBins=20;
    elseif j==3
        numOfBins=50;
    else
        numOfBins=100;
    end
    subplot(2,2,j)
    plot(E,exponential(E,s))
    hold on

    %Gets bin centers and heights
    [binCount,binCenters]=hist(Esample,numOfBins);

    %Gets total number of bin centers
    [rows,cols]=size(binCenters);

    %Calculate the bin width
    binWidth=(binCenters(cols)-binCenters(cols-1));

    %Calculate the area histogram
    histArea=binWidth*sum(binCount);

    %plot normalized histrogram
    plot(binCenters,1/histArea*binCount,'*')
    title(['sample size=',num2str(sampleSizes(j))])
    if j==2
        legend('Exponential Distribution','Sample Distribution','location',...
            'southoutside')
    end
end

%-----------------------------------------------------------
%EXPONENTIAL CDF
%-----------------------------------------------------------
ft=@(x,s)1-exp(-s.*x);
fig=figure;
set(fig,'name','Cumulative Distribution of Exponential')
plot(E,cdf,'m-','LineWidth',2)
hold on 
plot(E,ft(E,0.5),'--gs','Markersize',5)
legend('Estimated CDF','True cdf','location','Southeast')
title(['Exponential Cdf for s= ',num2str(s)])
%------------------------------------------------------------



%% STIMULATING RAYLEIGH DISTRIBUTION
rng(6)

%function definition
rayleigh= @(x,s) ((x./s^2).*exp(-0.5.*(x/s).^2)).*(x>=0)+0.*(x<0);

sampleSizes=[10,100,1000,10000];
s=0.5;         %rayleigh parameter
a=10;
E=(linspace(0,a,1000))';
y=rayleigh(E,s);
%------------------------------------------------------------


%Histogram of sampleSizes

f1=figure;
set(f1,'name','Rayleigh distribution parmeter=0.5' )
for j=1:4
    [Rsample,cdf]=continuousSampler(E,rayleigh,sampleSizes(j),s);
    if j==1
        numOfBins=5; %number of bins
    elseif j==2
        numOfBins=20;
    elseif j==3
        numOfBins=50;
    else 
        numOfBins=100;
    end
    subplot(2,2,j)
    %Plot Rayleigh distribution
    plot(E,y,'k--')
    hold on

    %Gets bin centers and heights
    [binCount,binCenters]=hist(Rsample,numOfBins);

    %Gets total number of bin centers
    [rows,cols]=size(binCenters);

    %Calculate the bin width
    binWidth=(binCenters(cols)-binCenters(cols-1));

    %Calculate the area histogram
    histArea=binWidth*sum(binCount);

    %plot normalized histrogram
    plot(binCenters,1/histArea*binCount,'*')

    title(['Sample size = ',num2str(sampleSizes(j))])
    if j==2
       legend('Rayleigh distribution','sample distribution','location'...
           ,'southwestoutside') 
    end
end



%CUMULATIVE DISTRIBUTION:Rayleigh
%------------------------------------------------------------
trueCdf=@(x) 1-exp(-0.5.*(x/s).^2);

fig=figure;
set(fig,'name','Cumulative Distribution of Rayleigh')
plot(E,cdf,'k-','LineWidth',2)
hold on 
plot(E,trueCdf(E),'ro','LineWidth',1)
legend('Estimated CDF','True cdf','location','Southeast')
title(['Rayleigh Cdf for ',num2str(s)])




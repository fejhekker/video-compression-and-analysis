clear all; close all;
[X,Y]=meshgrid([-5:0.1:5]);
%plot the grid
figure
imagesc(X)
colorbar
figure
imagesc(Y)
colorbar

%hyperparameters
theta=-pi/4;
f0=0.2;
gamma=0.4;
eta=0.4;
%calculataion
x2=Y*cos(theta)+X*sin(theta);
y2=-Y*sin(theta)+X*cos(theta);
g=(f0/(pi*gamma*eta))*exp(-(f0^2*x2.^2/gamma^2)-(f0^2*y2.^2/eta^2)).*exp(1i*2*pi*f0*x2);
%plot gabor
figure
imagesc(real(g))
colorbar
figure
imagesc(imag(g))
colorbar
figure
surf(X,Y,real(g),'EdgeColor','black')
figure
surf(X,Y,imag(g),'EdgeColor','black')

%filter bank
k=4; %amount of orientations
f0=0;
gtotal=zeros(101,101);
htotal=zeros(101,101);
eta=(2*k/pi^2)*sqrt(-log(1/sqrt(2)));
gamma=eta;
l=0;
figure
for j=1:3
    theta=0;
    f0=0.5/eta+(j-1)/eta;
    for i=1:k
        theta=i*0.25*pi;
        v0=f0*sin(theta);
        u0=f0*cos(theta);
        x2=Y*cos(theta)+X*sin(theta);
        y2=-Y*sin(theta)+X*cos(theta);
        l=l+1;
        g=(f0/(pi*gamma*eta))*exp(-(f0^2*x2.^2/gamma^2)-(f0^2*y2.^2/eta^2)).*exp(1i*2*pi*f0*x2);
        subplot(3,4,l)
        imagesc(real(g))
        colorbar
        h(l,:,:)=2*pi*gamma*eta*exp(-2*pi^2*((x2-u0).^2*gamma^2+(y2-v0).^2*eta^2));
        %h(l,:,:)=exp(-(pi^2/f0^2)*(gamma^2*(x2-f0)^2+eta^2*y2^2));
    end
end

figure
for l=1:12
    hold on
    contour(reshape(h(l,:,:),101,101))
end

% 
% figure
% imagesc(real(gtotal))
% colorbar
% figure
% imagesc(imag(gtotal))
% colorbar


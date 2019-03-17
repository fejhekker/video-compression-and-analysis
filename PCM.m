clear all; close all;
%hyper parameters
K=11;
stepsize=255/K;

%load the test picture
lena=double(imread('lena.pgm')); 
original=lena;

vector=lena(:);
sigma_x=var(vector);
sigma_q=0;
pd=fitdist(vector,'normal');

%odd uniform quantizer
for i=1:numel(lena) %loop over all the elements in the lena matrix
    qindex=idivide(lena(i),int8(stepsize)); %rounded to the nearest interger
    if qindex>K
        qindex=K;
    end
    lena(i)=qindex*stepsize;
end

for x=0:255
    q=floor(x/stepsize+0.5)*stepsize;
    sigma_q= sigma_q+(x-q).^2*pdf(pd,x);
end
SNR=10*log10(sigma_x^2/sigma_q^2);

%show the new picture
lena=mat2gray(lena);
figure
imshow(lena)


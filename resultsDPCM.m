clear all; close all;
lena=double(imread('lena.pgm'));
original=lena;
SNRplot=[];
Klist=[];
total=[];
for n=1:1:8
    run("DPCM") 
    SNRplot=[SNRplot SNR];
    Klist=[Klist 2^n];
    total=[total, new];
end

figure
plot(SNRplot,Klist)
xlabel("SNR [dB]")
ylabel("# quantizer levels")

%show the new picture
total=mat2gray(total);
figure
imshow(total);
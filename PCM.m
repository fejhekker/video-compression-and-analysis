stepsize=255/K;

%load the test picture
if pic=="lena"
    lena=double(imread('lena.pgm'));
    original=lena;
else
    peppers=double(imread('peppers.pgm')); 
    original=peppers;
end

if noise=="on"
    rand=-25+randi(50,512,512);
else
    rand=zeros(512,512);
end
%even uniform quantizer
for i=1:numel(original) %loop over all the elements in the lena matrix
    qindex=idivide((original(i)+rand(i)),int8(stepsize)); %quantize
    new(i)=(qindex+0.5)*stepsize; %get new values
end
new=double(reshape(new,[512,512]));%shape it back into the original form

if noise=="on"
    new=new-rand;
end

SNR=snr(original,new-original);


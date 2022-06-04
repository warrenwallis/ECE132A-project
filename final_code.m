%Problem 1
load projectIQ.mat;
F_s = 16;
rolloff = 0.5;
n = 2^20;
[p1,power] = pwelch(yrx(1:n),[],[],1024,F_s,'centered');
semilogy(power,p1);
title('Power Spectrum');
xlabel('Freq (Hz)');
ylabel('Power');

%Problem 2
P = [2 4 8];
n = 2^15; 
power = P(1);
figure(2)
frqs = (-n/2:(n/2)-1)'*F_s/n

semilogy(frqs/power,fftshift(abs(fft(yrx(1:n).^power))));
title('FFT Power of 2');
xlabel('Freq (Hz)'); 
ylabel('Magnitude');


figure(3)
power = P(2);
frqs = (-n/2:n/2-1)*F_s/n;
semilogy(frqs/power,fftshift(abs(fft(yrx(1:n).^power))));
title('FFT Power of 4');
xlabel('Freq (Hz)'); 
ylabel('Magnitude');

figure(4)
power = P(3);
frqs = (-n/2:n/2-1)*F_s/n;
semilogy(frqs/power,fftshift(abs(fft(yrx(1:n).^power))));
title('FFT Power of 8');
xlabel('Freq (Hz)'); 
ylabel('Magnitude');
frEst = 0.002;


%Problem 3
F_s = 16;
hrrc = rrc((-6:1/F_s:6)',rolloff,1)/F_s;
plot(hrrc)
title('HRRC');

%Problem 4
H = hrrc .* hrrc;
y_direction = yrx .* exp(-2i*pi*frEst*(0:length(yrx)-1)'/F_s);
yrre = conv(H,y_direction);
for k = 1:F_s
    plot(yrre(k:F_s:n),'.');   
    title(['k is ',num2str(k)])
    axis('square');
end


%Problem 5
%DVB-S2 constellation

%Problem 6
N = 2^20; 
fd = 6; 
preambleSig = conv(upsample([-1;1;-1;1;-1;1;-1;1;-1;1],F_s),hrrc,"full");
preambleSig = preambleSig(fd*F_s+1:end-fd*F_s);
plot(real(xcorr(yderot(1:N),preambleSig)))
figure (7)

% Deleteing Offest. 
PhaseOffset = -27;
pfo = comm.PhaseFrequencyOffset(PhaseOffset); 
yreoff = pfo(y_direction); 
yrre = conv(H, yreoff);

n= 2^16;
for k = 1:F_s
    plot(yrre(k:F_s:n),'.');   
    title(['k is ',num2str(k)])
    axis('square');
end

%Problem 7
n = 2^15; 
frqs = (-n/2:n/2-1)*16/n;
semilogy(frqs,fftshift(abs(fft(abs(yrx2(1:n))))));
title('Spectral Line');


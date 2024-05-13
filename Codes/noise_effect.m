
clc
close all, clear all

global state  c_cell  seed; 
global interval ; % for plotting
global word fraction  ;

state =0;
word = 18 ; 
fraction = 8 ; 

%....................Adding noise.............

tap = {1,2,6,py.tuple({2,6})} ;
seed = [0 0 0 0 0 0 0 1] ;
c_cell = NLFSR(seed,tap) ;

[val,time] = plotATM('I01m');
covered = inject ( val , 'Hi :) my name is Arian ') ;
stego = permutation(covered);

stg_dec =  Q2dec(stego,word - fraction,fraction) ;
stg_dec1 = medfilt1(stg_dec,4);
% stg_dec1 = awgn(stg_dec,30);

for i=1:12
    p1(i) = ((sum((stg_dec1(i,:)-stg_dec(i,:)).^2))/(sum(stg_dec1(i,:).^2)))^0.5;
    p2(i) = psnr(stg_dec1(i,:), stg_dec(i,:));
    p3(i) =  ssim(stg_dec1(i,:), stg_dec(i,:));
end

mean(p1)
mean(p2)
mean(p3)
% variance = 10^(-snr/10)
% for kk  = 1:12
%     stg_dec1(kk,:) = (stg_dec1(kk,:) - min(stg_dec1(kk,:)))/(max(stg_dec1(kk,:))-min(stg_dec1(kk,:)));
%     stg_dec(kk,:) = (stg_dec(kk,:) - min(stg_dec(kk,:)))/(max(stg_dec(kk,:))-min(stg_dec(kk,:)));
% 
%     subplot(12,2,2*kk-1)
% 	plot(xx, stg_dec1(kk,:)) ;
% 	xlabel('sec')  ; 
% 
% 	subplot(12,2,2*kk)
% 	subplot(12,2,2*kk,[0.1 0.1 0.5 0.5] ) 
% 	subaxis(12,2,1, 'Spacing',1, 'Padding', 0, 'Margin', 0);
% 	plot(xx,stg_dec(kk,:)) ;
% 	 
% 	xlabel('sec')  ; 
% 
% 
% end

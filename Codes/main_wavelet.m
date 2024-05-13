fvgefgggggggg
clc
clear all, close all

global state  c_cell  seed; 
global interval ; % for plotting
global word fraction  ;
%global channel_size  ; 

channel_size = 12;
word = 18 ; 
fraction = 8 ; 
state =0;
fs = 250;

[vall,time] = plotATM('I01m');
% selected = [1:8 10:12];
selected = [1:12];
val = vall(selected,:);
for i= 1:channel_size
    val(i,:) = (val(i,:) - min(val(i,:)))/(max(val(i,:))-min(val(i,:)));
end

mod_val = []; len = [];
[qrs_pos] = pantompkins_qrs(val(1,:),fs);
for i=1:length(qrs_pos)-1
    temp = val(:,qrs_pos(i)+20:qrs_pos(i+1)-20);
    len = [len size(temp,2)];
    mod_val = [mod_val temp];
end
   
%<<<<<<<<<<<<<<<<<<<<<<<<<<<<<making stego >>>>>>>>>>>>>>>>>>>>>>>>>>>>
tap = {1,2,6,py.tuple({2,6})} ;
seed = [0 0 0 0 0 0 0 1] ;
c_cell = NLFSR(seed,tap) ;

for i= 1:channel_size
    [A(i,:),D(i,:)] = dwt(mod_val(i,:),'db1');
end

modified_val = [A];
covered = inject ( modified_val , 'Hi :)') ;
stego = permutation(covered)   ;
% msg = Extmss(stego,23)

cvrd_dec = Q2dec(covered,word -fraction,fraction);
stg_dec =  Q2dec(stego,word - fraction,fraction);
% stg_dec = awgn(stg_dec,30);

original_coef = [A];
watermarked_coef = [stg_dec];
for i = 1:channel_size
    pprd(i) = ((sum((modified_val(i,:)-stg_dec(i,:)).^2))/(sum(modified_val(i,:).^2)))^0.5;
end
% mean(pprd)
% std(pprd)

for i= 1:channel_size
    stg_dec1(i,:) = idwt(stg_dec(i,:),D(i,:),'db1');
%     stg_dec1(i,:) = idwt(stg_dec(i,1:length(stg_dec)/2),stg_dec(i,length(stg_dec)/2+1:length(stg_dec)/2),'db1');
end

start = 0;
stg_dec2 = mod_val(:,1:qrs_pos(1)-1);
for i=1:length(qrs_pos)-1
    i
    temp1 = mod_val(:,qrs_pos(i):qrs_pos(i)+19);
    temp2 = mod_val(:,qrs_pos(i+1)-19:qrs_pos(i+1)-1);  
    stg_dec2 = [stg_dec2 temp1 stg_dec1(:,start+1:start+len(i)) temp2];
    start = start + len(i);
end
stg_dec2 = [stg_dec2 mod_val(:,qrs_pos(length(qrs_pos)):end)];


% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<plotting >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% for kk  = 1:channel_size
% 	subplot(12,2,2*kk-1)
%   val(kk,:) = (val(kk,:) - min(val(kk,:)))/(max(val(kk,:))-min(val(kk,:)));
% 	plot(val(kk,:)) ;
% 
% 	subplot(12,2,2*kk)
%   stg_dec2(kk,:) = (stg_dec2(kk,:) - min(stg_dec2(kk,:)))/(max(stg_dec2(kk,:))-min(stg_dec2(kk,:)));
% 	plot(stg_dec2(kk,:)) ;
% end
% subplot(12,2,1);
% title('ECG signal ') ;
% 
% subplot(12,2,2);
% title('watermarked signal ') ;

for i=1:channel_size
    p1(i) = ((sum((val(i,:)-stg_dec1(i,:)).^2))/(sum(val(i,:).^2)))^0.5;
    p2(i) = psnr(val(i,:), stg_dec1(i,:));
    p3(i) =  ssim(val(i,:), stg_dec1(i,:));
end

mean(p1)
% std(p1)

mean(p2)
% std(p2)

mean(p3)
% std(p3)

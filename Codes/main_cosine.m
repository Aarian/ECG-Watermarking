
clc
clear all, close all

global state  c_cell  seed; 
global interval ; % for plotting
global word fraction;
%global channel_size; 

fs = 250;
channel_size = 11;
word = 18 ; 
fraction = 8 ; 
state =0;

[vall,time] = plotATM('I03m');
% selected = [1:11];
selected = [1:8 10:12];
raw_val = vall(selected,:);

for i= 1:channel_size
    raw_val(i,:) = (raw_val(i,:) - min(raw_val(i,:)))/(max(raw_val(i,:))-min(raw_val(i,:)));
end

val = []; len = [];
[qrs_pos] = pantompkins_qrs(raw_val(1,:),fs);
for i=1:length(qrs_pos)-1
    temp = raw_val(:,qrs_pos(i)+20:qrs_pos(i+1)-20);
    len = [len size(temp,2)];
    val = [val temp];
end


%<<<<<<<<<<<<<<<<<<<<<<<<<<<<<making stego >>>>>>>>>>>>>>>>>>>>>>>>>>>>
tap = {1,2,6,py.tuple({2,6})} ;
seed = [0 0 0 0 0 0 0 1] ;
c_cell = NLFSR(seed,tap) ;

for i= 1:channel_size
%     val(i,:) = (val(i,:) - min(val(i,:)))/(max(val(i,:))-min(val(i,:)));
    [modified_val(i,:)] = dct(val(i,:));
end
covered = inject ( modified_val , 'Hi :) my name is Arian ') ;
stego = permutation(covered);

cvrd_dec = Q2dec(covered,word -fraction,fraction);
stg_dec =  Q2dec(stego,word - fraction,fraction);
stg_dec = awgn(stg_dec,30);

for i= 1:channel_size
    plot(stg_dec(i,:))
    stg_dec1(i,:) = idct(stg_dec(i,:));
end

start = 0;
stg_dec2 = raw_val(:,1:qrs_pos(1)-1);
for i=1:length(qrs_pos)-1
    temp1 = raw_val(:,qrs_pos(i):qrs_pos(i)+19);
    temp2 = raw_val(:,qrs_pos(i+1)-19:qrs_pos(i+1)-1);  
    stg_dec2 = [stg_dec2 temp1 stg_dec1(:,start+1:start+len(i)) temp2];
    start = start + len(i);
end
stg_dec2 = [stg_dec2 raw_val(:,qrs_pos(length(qrs_pos)):end)];

% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<plotting >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
for kk  = 1:channel_size
    subplot(12,2,2*kk-1)
	plot(raw_val(kk,:)) ;

	subplot(12,2,2*kk)
    stg_dec2(kk,:) = (stg_dec2(kk,:) - min(stg_dec2(kk,:)))/(max(stg_dec2(kk,:))-min(stg_dec2(kk,:)));
	plot(stg_dec1(kk,:)) ;
end

for i=1:channel_size
    p1(i) = ((sum((raw_val(i,:)-stg_dec2(i,:)).^2))/(sum(raw_val(i,:).^2)))^0.5;
    p2(i) = psnr(raw_val(i,:), stg_dec2(i,:));
    p3(i) =  ssim(raw_val(i,:), stg_dec2(i,:));
end

mean(p1)
% std(p1)

mean(p2)
% std(p2)

mean(p3)
% std(p3)

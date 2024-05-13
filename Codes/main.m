
clc
clear all, close all

global state  c_cell  seed; 
global interval ; % for plotting
global word fraction  ;
%global channel_size  ; 

fs = 250;
channel_size = 11;
word = 18 ; 
fraction = 8 ; 
state =0;

[vall,time] = plotATM('I01m');
selected = [1:8 10:12];
% selected = [1:11];
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


%<<<<<<<<<<<<<<<<<<<<<<<<<< remove margin in plotiing >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  %  pos = get(gca, 'Position');
  %  pos(1) = 0.055;
  %  pos(3) = 0.9;
  %  set(gca, 'Position', pos)
%set(gca,'Position',[0 0 1 1]) 
%set(gca, 'LooseInset', get(gca,'TightInset'))


%<<<<<<<<<<<<<<<<<<<<<<<<<<<<<making stego >>>>>>>>>>>>>>>>>>>>>>>>>>>>
tap = {1,2,6,py.tuple({2,6})} ;
seed = [0 0 0 0 0 0 0 1] ;
c_cell = NLFSR(seed,tap) ;

covered = inject ( val , 'Hi :) my name is Arian ') ;
stego = permutation(covered)   ;
% msg = Extmss(stego,23)

cvrd_dec = Q2dec(covered,word -fraction,fraction);
raw_stg_dec =  Q2dec(stego,word - fraction,fraction) ;
raw_stg_dec = awgn(raw_stg_dec,30);

start = 0;
stg_dec = raw_val(:,1:qrs_pos(1)-1);
for i=1:length(qrs_pos)-1
    temp1 = raw_val(:,qrs_pos(i):qrs_pos(i)+19);
    temp2 = raw_val(:,qrs_pos(i+1)-19:qrs_pos(i+1)-1);  
    stg_dec = [stg_dec temp1 raw_stg_dec(:,start+1:start+len(i)) temp2];
    start = start + len(i);
end
stg_dec = [stg_dec raw_val(:,qrs_pos(length(qrs_pos)):end)];


% <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<plotting >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% for kk = 1:channel_size
% 	subplot(12,2,2*kk-1)
% %     raw_val(kk,:) = (raw_val(kk,:) - min(raw_val(kk,:)))/(max(raw_val(kk,:))-min(raw_val(kk,:)));
% 	plot(raw_val(kk,:)) ;
% 
% 	subplot(12,2,2*kk)
%     stg_dec(kk,:) = (stg_dec(kk,:) - min(stg_dec(kk,:)))/(max(stg_dec(kk,:))-min(stg_dec(kk,:)));
% 	plot(stg_dec(kk,:)) ;
% end
% subplot(12,2,1);
% title('ECG signal ') ;
% 
% subplot(12,2,2);
% title('watermarked signal ') ;

for i=1:channel_size
    p1(i) = ((sum((raw_val(i,:)-stg_dec(i,:)).^2))/(sum(raw_val(i,:).^2)))^0.5;
    p2(i) = psnr(raw_val(i,:), stg_dec(i,:));
    p3(i) =  ssim(raw_val(i,:), stg_dec(i,:));
end

mean(p1)
% std(p1)

mean(p2)
% std(p2)

mean(p3)
% std(p3)


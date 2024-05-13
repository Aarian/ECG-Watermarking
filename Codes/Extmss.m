function mss= Extmss(stego_sig,mss_len) 
	global channel_size  ;
	global state ;
	state = 0 ;% set NLFSR state to zero 
	[stego_n , stego_m] = size(stego_sig) ; 
	pure_sig = stego_sig ;  
	order =  cell(1,stego_n) ;
	tmp_lst = [] ;
	mss = '' ;
	first_temp = [] ;
	for jj = 1:mss_len
		for ii =  1 :stego_n
			%append(tmp_lst, cvrd_sig{ii,jj}(end)) ;
			%tmp_lst = [tmp_lst,cvrd_sig{ii,jj}(end)] ;
			tmp_lst(end+1) = stego_sig{ii,jj}(end) ;
		end
		first_temp	=  char(tmp_lst) ; 
		[tmp_lst,  order] = shuffle(char(tmp_lst)) ;
		tmp_lst= deshuffle(first_temp,fliplr(order))  ;
		
		for ii =  1 :stego_n
			pure_sig{ii,jj}(end)  = tmp_lst(1,ii) ; 
		end
		k = channel_size-1:-1:0;  % bit position for bits
		w = 2.^k  ;% weight of bits
		mss(end+1)=char((tmp_lst-'0')*(w'));
		tmp_lst = [] ;
		
	end
	pure_sig(:,1:5)
end
%disp('linear lfsr:')
%%[seq,c]  = LFSR([0 0 0 0 1],[5 2] )
%%ee= ['salam','dsdsds','arian']
%disp('NLFSR:')
%%[seq,c]  = NLFSR([0 0 0 1],{1,2,3,py.tuple({2,3})}) % 4 bit nlfsr 
%
%%0,1,8,9,15,(7,18)
%%[seq,c]  = NLFSR([0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
%%1],{1,2,9,10,16,py.tuple({8,19})}) %24bit
%%8bit
%%0,1,5,(1,5)
%[seq,c]  = NLFSR([0 0 0 0 0 0 0 1],{1,2,6,py.tuple({2,6})})
function [stego] = permutation(cvrd_sig) 
	global channel_size  ; 
	[cvrd_n , cvrd_m] = size(cvrd_sig) ; 
	stego = cvrd_sig ;  
	order =  cell(1,cvrd_n) ;
	tmp_lst = [] ;
	for jj = 1:cvrd_m
		for ii =  1 :cvrd_n
			%append(tmp_lst, cvrd_sig{ii,jj}(end)) ;
			%tmp_lst = [tmp_lst,cvrd_sig{ii,jj}(end)] ;
			tmp_lst(end+1) = cvrd_sig{ii,jj}(end) ;
		end
		
		[tmp_lst,  order] = shuffle(char(tmp_lst)) ;
		
		for ii =  1 :cvrd_n
			stego{ii,jj}(end)  = tmp_lst(1,ii) ; 
		end
	tmp_lst = [] ; 	
	end
	
end 
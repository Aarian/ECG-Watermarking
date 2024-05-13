function [cover_sig_cell] = inject (cover_sig , str) % cover sig as binary form
	%ascii_str_bin  = double(str) ;
	ascii_str_bin= cell(1,length(str)); % as cell array 
	global channel_size ; 
	channel_size = 11;
	cover_sig_cell =  dec2fbin(cover_sig)   ;
	 %fixed_size= fi(double(str), 1, channel_size, 0) ; 
	
	%ascii_str_bin  =	 arrayfun(@num2str, dec2bin(fixed_size) , 'UniformOutput', false)  % fixed size 
	
	for i = 1:length(str)
			%ascii_str_bin(i)= arrayfun(@num2str, dec2bin(str(i),channel_size) , 'UniformOutput', false)	;
			ascii_str_bin{i} = dec2bin(str(i),channel_size) ;
	end
	%% injection 
	ascii_str_bin ; 
	disp('befor injection') ; 
	aa=cover_sig_cell (:,1:5) ; 
	
	for jj =  1: length(str)  
		for ii= 1:channel_size
			cover_sig_cell{ii,jj}(end) =  ascii_str_bin {jj} (ii) ;
			%(12) =  ascii_str_bin {jj} (ii);
		end	
	end
	
	%disp(cover_sig_cell {:,1})
	%[xx,yy]=size(cover_sig_cell)
	disp('after injection') ;
	aa=cover_sig_cell (:,1:5) ; 
	%[xx,yy]=size(aa)
	%aa(1)
	%cover_sig_str = arrayfun(@num2str, cover_sig, 'UniformOutput', false) 
	%cover_sig_ = cover_sig 

end
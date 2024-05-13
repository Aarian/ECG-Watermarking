function bin =  dec2fbin(val)   % Qm.n  = 14 bit fraction 18 bit word ////  bin as cell matrix
	global word ;  
	%word= 18  ;
	global fraction ;  
	%fraction = 8  ;
	[n,m] =  size(val) ;
	%fxp =  zeros(n,m) ;
	bin= cell(n,m);
	fxp= 0 ;
	for i =1: n 
		for j = 1: m 
			%bin(n,m) = sfi(val(n,m),18,14) ;
			fxp =  fi(val(i,j), 1, word, fraction) ;
			bin{i,j}=fxp . bin ;
			%bin{i,j} = [] ; 
			%val(n,m)
		end
	end
	
end 
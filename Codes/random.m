function rnd = random(endd,state_reset) %random number in range i 
	global state  seed  c_cell ;
	if(state_reset) state = 0 ; end 
	%state=0 ; 
	%tap = {1,2,6,py.tuple({2,6})} ;
	%seed = [0 0 0 0 0 0 0 1] ;
	[seed_n, seed_m] = size(seed) ;
	%c_cell = NLFSR(seed,tap) ;
	
	%tap = {1,2,3,py.tuple({2,3})} ;
	%seed = [1 1 0 0 1] ;	
 
	
	
	endd_str =  dec2bin(endd) ; 
	
	[row,col] = size (c_cell ) ;
	%bin2dec(c_cell{state+1,1}(end-length(endd_str):end));
	state ;
	if ( 2^seed_m -2 >= state  )
		
		while(bin2dec(c_cell{state+1,1}(end-length(endd_str):end)) > endd)
			state = state+1 ;
		end
		%state 
		rnd = bin2dec(c_cell{state+1,1}(end-length(endd_str):end)) ; 	
		state = state+1 ;
		
	else 
		state = 0;
		rnd = bin2dec(c_cell{state+1,1}(end-length(endd_str):end)) ; 
	end
	
	%A=  num2str(c)  
	%bin2dec(A{1,1})
end
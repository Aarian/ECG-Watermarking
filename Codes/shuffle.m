function [shuffle_arr,order]  =  shuffle(arr)
	j=1;
	temp =0 ;
	[arr_n,arr_m] = size(arr);
	order = cell(1,arr_m) ; 
	for ii =  arr_m-1:-1:1
		ii ;
		j=random(ii,0); 
		% exchng
		temp = arr(1,ii) ; 
		arr(1,ii) = arr(1,j+1)  ;
		arr(1,j+1) = temp ; 
		% --------------------------------
		order{1,arr_m-ii} = py.tuple({ii,j+1}) ; 
	end
	shuffle_arr = arr ;
	order ;

end 
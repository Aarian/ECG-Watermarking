function arr =  deshuffle(shuffle_arr,order)  % order :as py tuple 
	[row,col]=size(order);
	cpy = shuffle_arr ;
	for ii= 1:col
		if(~isempty(order{ii}))
			%_ii=order{ii}(0);
			xx = py.operator.getitem(order{ii},int32(0));
			%_jj=_ii=order{ii}(1);
			yy = py.operator.getitem(order{ii},int32(1));
			% sawp 
			tmp = cpy(xx);
			cpy(xx) =cpy(yy);
			cpy(yy) = tmp ;
		end
		
	end
	arr = cpy ;

end
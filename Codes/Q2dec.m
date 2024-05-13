function y = Q2dec(x,a,b)
% function y = q2dec(x,a,b,format)
% Convert numbers from Qa.b format to decimal
% where 'a' is the number of bits to the left of the binary point not including the sign bit
% and 'b' is the number of bits to the right of the binary point.
% An example of a Q0.15 (also called Q15) number is 1.100 0000 0000 0000 = -1 + 0.5 = -0.5.
% x (string_cell matrix) input in Qa.b format 
% a (scalar) number of bits to the left of the binary point not including the sign bit
%                (Optional, default is 0)
% b (scalar) number of bits to the right of the binary point 
%                (Optional, default is 15)
% y (scalar) output in decimal matrix
% Arian Morteza


[row,col] = size(x) ; 
y= zeros(row,col);

k = a:-1:(-b+1);  % bit position for bits
w = 2.^(k-1)  ;% weight of bits
w(1) = -w(1);	% change weight of sign bit
tmp = [] ; 
%y = zeros(L,1);
for i = 1:row
	for j= 1:col 
		for s = 1 : length(x{i,j})
			tmp = [tmp,x{i,j}(s)-'0' ] ;
		end

	y(i,j) = tmp*w' ; 
	tmp = [] ;
	end
	 % multiply bits by weights and add up 
end
end


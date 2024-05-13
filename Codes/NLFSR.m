function c_cell=NLFSR(seed,tap)
%---------------------
%>>s=[1 1 0 0 1] 
%>>tap={1,2,3,py.tuple(2,3)}  IS cell array == f = x0 ^ x1 ^ x2^ x1.x2 
%  Standard format of tap as input :  put tuple after int values
%>>[seq c] =LFSR(s,t) 
% cell array begin with 1 index but tuple begin with 0 index
%---------------------------
%seq = generated sequence
%c will be matrix containing the states of NLFSR raw wise
% py.operator.getitem(t,int32(py.len(t)-1)) 
n=length(seed);
c(1,:)=seed; % c is binary matrix 
m=length(tap);
for k=1:2^n-2;
    if(isa(tap{2},'double'))
        %disp('b[1]');
        seed(tap{2});
        seed(tap{1});
        seed ; 
        b(1)=xor(seed(n+1-tap{1}), seed(n+1-tap{2})); % b as xor train 
        
    else
        i1 = seed(n+1-py.operator.getitem(tap{2},int32(0))) ; %first element and gate
        %i1= tap{2}(0)
        i2= seed(n+1-py.operator.getitem(tap{2},int32(1))) ; % second element and gate
        b(1)=xor(seed(n+1-tap{1}),and(i1,i2));
    end
    if m>2;
        for i=1:m-2;
            if(isa(tap{(i+2)},'double'))
                b(i+1)=xor(seed(n+1-tap{(i+2)}),b(i)); % b as xor train 
            else
               ref_i1=py.operator.getitem(tap{(i+2)},int32(0));
               i1 = seed(n+1-py.operator.getitem(tap{(i+2)},int32(0)));  %first element and gate
               %disp('i1:-seed' , );
               ref_i2=py.operator.getitem(tap{(i+2)},int32(1));
               i2= seed(n+1-py.operator.getitem(tap{(i+2)},int32(1))); % second element and gate
               %disp('i2:-seed' , py.operator.getitem(tap{i+2},int32(1)))
               b(i+1)=xor(and(i1,i2), b(i) );
            end    

        %b(i+1)=xor(seed(tap(i+2)), b(i)) ;
        end
    end
    for j=1:n-1;
        seed(n+1-j)=seed(n-j);
    end
    seed(1)=b(m-1);
    c(k+1,:)=seed;
    b ;
end
[c_n,c_m] =  size(c) ;
c_cell = cell(c_n,1) ; 
for i  = 1 :c_n
	%c_cell {i,1} =
	%c(i,:)
	str=num2str(c(i,:)) ;   
	str(ismember(str,' ,.:;!')) = [];
	c_cell {i,1} = str ; 
end


seq=c(:,n)';




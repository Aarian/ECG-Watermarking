function[seq c]=LFSR(seed,tap)
%s=initial state of LFSR, you can choose any lenght of LFSR
%Instruction:========== 
%Save LFSR.m in your current directory and type following
%on Command window for simulating 5 bit LFSR with tap [5 2]
%---------------------
%>>s=[1 1 0 0 1] 
%>>t=[5 2]
%>>[seq c] =LFSR(s,t) 
%---------------------------
%seq = generated sequence
%c will be matrix containing the states of LFSR raw wise
% 
%-----------------------------------------------------------
%If any doubt, confusion or feedback please contact me
% NIKESH BAJAJ 
% bajaj.nikkey@gmail.com (+91-9915522564)
% Asst. Professor at Lovely Profesional University
% Masters from Aligarh Muslim University,INDIA 
%--------------------------------------------------
n=length(seed);
c(1,:)=seed;
m=length(tap);
for k=1:2^n-2;
b(1)=xor(seed(tap(1)), seed(tap(2))); % b as xor train 
if m>2;
    for i=1:m-2;
    b(i+1)=xor(seed(tap(i+2)), b(i)) ;
    end
end
for j=1:n-1;
seed(n+1-j)=seed(n-j);
end
seed(1)=b(m-1);
c(k+1,:)=seed;
b ;
end
seq=c(:,n)';




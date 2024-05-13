function [val,x]=stego(Name,stegomat)


infoName = strcat(Name, '.info');
matName = strcat(Name, '.mat');
Octave = exist('OCTAVE_VERSION');
load(strcat('D:\Term8\Project\ECG\',matName));
fid = fopen(strcat('D:\Term8\Project\ECG\',infoName), 'rt');
fgetl(fid);
fgetl(fid);
fgetl(fid);
[freqint] = sscanf(fgetl(fid), 'Sampling frequency: %f Hz  Sampling interval: %f sec');
interval = freqint(2);
fgetl(fid);

if(Octave)
    for i = 1:size(val, 1)
       R = strsplit(fgetl(fid), char(9));
       signal{i} = R{2};
       gain(i) = str2num(R{3});
       base(i) = str2num(R{4});
       units{i} = R{5};
    end
else
    for i = 1:size(val, 1)
      [row(i), signal(i), gain(i), base(i), units(i)]=strread(fgetl(fid),'%d%s%f%f%s','delimiter','\t');
    end
end

gain ;
base ;

fclose(fid);
% .info file end 


val(val==-32768) = NaN;

for i = 1:size(val, 1)
    val(i, :) = (val(i, :) - base(i)) / gain(i);
end

x = (1:size(val, 2)) * interval;
plot(x', val');
val ;  
x;
%for i = 1:length(signal)
%    labels{i} = strcat(signal{i}, ' (', units{i}, ')'); 
%end
%
%legend(labels);
%xlabel('Time (sec)');
%% grid on

end

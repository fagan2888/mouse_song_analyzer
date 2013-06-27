function WriteSonogram (fid,sng,noiseThreshold,freqRange,offset,absB)
%This work is licensed from LabDaemons <info@labdaemons.com> 
%under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
if (nargin < 6)
    absB = abs(sng);
end
index = find(absB >= noiseThreshold);
[row,col] = ind2sub(size(sng),index);
index2 = find(row >= freqRange(1) & row <= freqRange(2));
fwrite(fid,length(index2),'int32');
fwrite(fid,col(index2)+offset,'int32');
fwrite(fid,row(index2),'int16');
index = index(index2);
sng=full(sng);
fwrite(fid,real(sng(index)),'float64');
fwrite(fid,imag(sng(index)),'float64');
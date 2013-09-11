function [dch,sdsng] = specdiscont(sng)
%This work is licensed from LabDaemons <info@labdaemons.com> 
%under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
offset = -3:3;
moff = max(abs(offset));
frange = 1+moff:size(sng,1)-moff;
pow = sum(sng)';
[i,j,s] = find(sng);
nsng = sparse(i,j,s./pow(j),size(sng,1),size(sng,2));
sdsng = zeros(length(offset),size(sng,2)-1);
for i = 1:length(offset)
  dsng = nsng(frange,2:end) - nsng(frange+offset(i),1:end-1);
  sdsng(i,:) = sum(abs(dsng));
end
dch = [min(sdsng),2];
zindx = pow == 0;
dch(zindx) = 2;
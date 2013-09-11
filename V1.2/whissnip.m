function whis = whissnip(sng,header,twhis)
%This work is licensed from LabDaemons <info@labdaemons.com> 
%under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
T = header.nscans/header.scanrate;
twhisc = round(twhis * ((size(sng,2))-1)/T + 1);
nwhis = size(twhis,2);
whis = cell(1,nwhis);
for i = 1:nwhis
  whis{i} = sng(:,twhisc(1,i):twhisc(2,i));
end
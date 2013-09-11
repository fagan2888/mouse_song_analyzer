function iout = IntersectIntervals(i1,i2)
%This work is licensed from LabDaemons <info@labdaemons.com> 
%under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
maxl = max(i1(1),i2(1));
minr = min(i1(2),i2(2));
if (maxl > minr)
  iout = [];
else
  iout = [maxl minr];
end


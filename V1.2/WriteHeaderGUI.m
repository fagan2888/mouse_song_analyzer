function filePosition = WriteHeaderGUI(fid,h)
%This work is licensed from LabDaemons <info@labdaemons.com> 
%under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
magicNum = 992732356;
fwrite(fid,magicNum,'int32');
filePosition.magicNum=ftell(fid);
headersize = 0;
fwrite(fid,headersize,'uint32');
filePosition.headersize=ftell(fid);
type = 0;
type = bitset(type,4);
fwrite(fid,type,'int32');
filePosition.nscans=ftell(fid);
fwrite(fid,h.nscans,'uint32');
filePosition.scanrate=ftell(fid);
fwrite(fid,h.scanrate, 'float32');
filePosition.nfreq=ftell(fid);
fwrite(fid,h.nfreq,'int32');
filePosition.columnTotal=ftell(fid);
fwrite(fid,h.columnTotal, 'float32');
filePosition.threshold=ftell(fid);
fwrite(fid,h.threshold,'float32');
filePosition.tacq=ftell(fid);
fwrite(fid,h.tacq,'int32');
filePosition.freqMin=ftell(fid);
fwrite(fid,h.freqMin,'int32');
filePosition.freqMax=ftell(fid);
fwrite(fid,h.freqMax,'int32');
fcur = ftell(fid);
fseek(fid,4,-1);
fwrite(fid,fcur,'uint32');
fseek(fid,fcur,-1);
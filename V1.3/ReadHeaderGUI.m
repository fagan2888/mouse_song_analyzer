function [header,headersize] = ReadHeaderGUI(file)
%This work is licensed from LabDaemons <info@labdaemons.com> 
%under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
fid = file;
magicNum = fread(fid,1,'int32');
if (magicNum == 992732356)
  headersize = fread(fid,1,'uint32');
  header.headersize = headersize;
  type = fread(fid,1,'int32');
  if (bitget(type,4))
    header.nscans = fread(fid,1,'uint32');
    header.scanrate = fread(fid,1,'float32');
    header.nfreq = fread(fid,1,'int32');
    header.columnTotal = fread(fid,1,'float32');
    header.threshold = fread(fid,1,'float32');
    header.tacq = fread(fid,1,'int32');
    header.freqMin = fread(fid,1,'int32');
    header.freqMax = fread(fid,1,'int32');
  end
  fseek(fid,headersize,-1);
  header.flag = 'WU1';
elseif (magicNum == -991679685)
  error(['File has non-native endian status.  Call FOPEN with the reverse' ...
      ' byte order (see FOPEN help)']);
end
if (ischar(file))
  status = fclose(fid);
  if (status < 0)
    error('File did not close');
  end
end


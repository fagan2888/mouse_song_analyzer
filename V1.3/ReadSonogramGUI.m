 function [sng,header] = ReadSonogramGUI(file)
%This work is licensed from LabDaemons <info@labdaemons.com> 
%under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
  [fid] = fopen(file,'r','l');
  [header,headersize] = ReadHeaderGUI(fid);
  fseek(fid,headersize,-1);
    length = fread(fid,1,'int32');
    col = fread(fid,length,'int32');
    colAccum{1} = col;
    row = fread(fid,length,'int16');
    rowAccum{1} = row;
    realB = fread(fid,length,'float64');
    realAccum{1} = realB;
    imagB = fread(fid,length,'float64'); 
    imagAccum{1} = imagB;
  colAccum = cat(1,colAccum{:});
  rowAccum = cat(1,rowAccum{:});
  realAccum = cat(1,realAccum{:});
  imagAccum = cat(1,imagAccum{:});
  Belements = realAccum + imagAccum*1i;
  sngMat = [rowAccum, colAccum, Belements];
  sng=spconvert(sngMat);
  if (ischar(file))
    status = fclose(fid);
    if (status < 0)
      error('File did not close');
    end
  end
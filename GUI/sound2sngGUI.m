function [sng] = sound2sngGUI(infilename,header,sound,~)
%This work is licensed from LabDaemons <info@labdaemons.com> 
%under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
[~,name] = fileparts(infilename);
outfilename = [name '.sng'];

[fidSng,message] = fopen(outfilename,'w');
    if (fidSng == -1)
        error(message);
    end
  columnOffset = 0;
  freqRange = [1 header.nfreq];
  WriteHeaderGUI(fidSng,header);
  fprintf('\n');
  [sng,~,~]=sparsesng(sound,header.scanrate,header.nfreq,header.threshold);
  WriteSonogram(fidSng,sng,header.threshold,freqRange,columnOffset);
  fprintf('\n');
  status = fclose(fidSng); 

  if (status < 0)
    error('Sng file did not close');
  end
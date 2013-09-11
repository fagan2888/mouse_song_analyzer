function [sng,f,t] = sparsesng(y,Fs,NFFT,thresh,sngparms,options)
%This work is licensed from LabDaemons <info@labdaemons.com> 
%under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.

if (nargin < 6)
    options = [];
  end
  if ~isfield(options,'band')
    options.band = sngparms.freqrange/1000;
  end
  if ~isfield(options,'numoverlap')
    options.numoverlap = NFFT/2;
  end
  fromfile = 0;
  if (ischar(y))
    fromfile = 1;
  end
  if (isnumeric(y) && length(y) == 1)
    fromfile = 1;
    fseek(y,0,'bof');
  end
  tovolts = 1;
  npts = length(y);
  l2 = log2(NFFT);
  if (floor(l2) ~= l2)
    error('NFFT must be a power of 2');
  end
  if (NFFT < options.numoverlap)
    error('Cannot overlap by more than NFFT');
  end
  thewindow = hanning(NFFT)';
  nfreqs = NFFT/2+1;
  nnew = NFFT - options.numoverlap;
  f = linspace(0,Fs/2000,nfreqs);
  bandsig = find(f >= options.band(1) & f <= options.band(2));
  nblocks = floor((npts-options.numoverlap)/nnew);
  indx1 = cell(1,nblocks);
  sng1 = cell(1,nblocks);
  s = zeros(1,NFFT);
  if (fromfile)
    s(nnew+1:end) = tovolts * ReadBinaryData(fid,1,[0 options.numoverlap-1]);
  else
    s(nnew+1:end) = y(1:options.numoverlap);
  end
  for k = 1:nblocks
    s(1:options.numoverlap) = s(nnew+1:end);
    if (fromfile)
      s(options.numoverlap+1:end) = tovolts * ReadBinaryData(fid,1,[0 nnew-1]);
    else
      s(options.numoverlap+1:end) = y(options.numoverlap + ...
                                      ((k-1)*nnew+1:k*nnew));
    end
    st = fft(thewindow .* s,NFFT);
    indx = find(abs(st(bandsig)) > thresh);
    indx1{k} = bandsig(indx);
    sng1{k} = st(bandsig(indx));
  end
  lennz = zeros(1,nblocks);
  for k = 1:nblocks
    lennz(k) = length(indx1{k});
  end
  indx2 = zeros(1,sum(lennz));
  start = 1;
  for k = 1:nblocks
    indx2(start:start+lennz(k)-1) = k;
    start = start+lennz(k);
  end
  sng = sparse(cat(2,indx1{:}),indx2,cat(2,sng1{:}),nfreqs,nblocks);
  t = linspace(0,npts-options.numoverlap,nblocks)/Fs;
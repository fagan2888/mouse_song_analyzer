function setspimg(h,varargin)
%This work is licensed from LabDaemons <info@labdaemons.com> 
%under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
  spdata = get(h,'UserData');
  axu = get(h,'Units');
  set(h,'Units','pixels');
  axpos = get(h,'Position');
  set(h,'Units',axu);
  xlim = get(h,'XLim');
  ylim = get(h,'YLim');
  clim = [xlim;ylim];
  lim = clim;
  uselim = clim;
  tlim = [spdata.xlim;spdata.ylim];
  npix = axpos(3:4);
  if isfield(spdata,'npix')
    npix = spdata.npix;
  end
  outnpix = npix;
  for i = 1:2:length(varargin)
    switch varargin{i}
     case 'XLim',
      index = 1;
     case 'YLim',
      index = 2;
     otherwise,
      error('Field name not recognized');
    end
    val = varargin{i+1};
    lim(index,:) = val;
    uselim(index,:) = IntersectIntervals(val,tlim(index,:));
    outnpix(index) = round(npix(index) * diff(uselim(index,:))/ ...
                           diff(val));
  end
  [ny,nx] = size(spdata.m);
  scalefac = diag(([nx ny] - [1 1])./diff(tlim'),0);
  subrange = round(scalefac * (uselim - repmat(tlim(:,1),1,2))) + 1;
  msub = spdata.m(subrange(2,1):subrange(2,2), ...
           subrange(1,1):subrange(1,2));
  if any(size(msub) > outnpix)
    [i,j,s] = find(msub);
    stretchfac = (outnpix - [1 1]) ./ size(msub);
    if (stretchfac(1) < 1)
      i = round((i-1) * stretchfac(1) + 1);
    end
    if (stretchfac(2) < 1)
      j = round((j-1) * stretchfac(2) + 1);
    end
    msub = sparse(i,j,s,min(outnpix(1),size(msub,1)), ...
                        min(outnpix(2),size(msub,2)));
  end
  imagesc(uselim(1,:),uselim(2,:),msub,'Parent',h);
  set(h,'XLim',lim(1,:),'YLim',lim(2,:));
  if isfield(spdata,'climrank')
    inz = find(msub);
    climrank = max(0,min(spdata.climrank,1));
    if (climrank ~= spdata.climrank)
      warning(101, 'climrank clipped to [0,1]');
    end
    indx = round(climrank*length(inz));
    if (indx > 0)
      snz = sort(msub(inz));
      set(h,'CLim',[0 snz(indx)]);
    end
  end
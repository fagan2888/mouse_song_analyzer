function whistimesplotGUI(sng,header,twhis,handles)
%This work is licensed from LabDaemons <info@labdaemons.com> 
%under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
  f = linspace(0,125000,header.nfreq);
  t = linspace(0,header.nscans/header.scanrate,size(sng,2));
  xlim = [min(t) max(t)];
  ylim = [min(f) max(f)];
  [i,j,s] = find(sng);
  spm = sparse(i,j,log(abs(s)/0.1),size(sng,1),size(sng,2));
  set(handles.sng_axes, 'NextPlot', 'replacechildren', 'UserData', ...
              struct('m',spm,'xlim',xlim,'ylim',ylim,'climrank',0.9));
  colormap(jet(128));
  axis xy;
  setspimg(handles.sng_axes, 'XLim', xlim, 'YLim', ylim);
  sz = size(twhis);
  if (sz(2) == 2 && sz(1) > 2)
    twhis = twhis';
  end
  ylim2 = [0 2];
  plot(handles.twhis_axes,twhis, ones(size(twhis)), 'r');
  set(handles.twhis_axes,'XLim',xlim, 'YLim',ylim2)
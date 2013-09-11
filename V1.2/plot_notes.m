function plot_notes(pitch, refpointsx, notenum, handles)
%This work is licensed from LabDaemons <info@labdaemons.com> 
%under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
if isempty(refpointsx) == 0    
    if notenum > 1
        noteindex1 = refpointsx(notenum-1)+1;
    else
        noteindex1 = 1;
    end
    if notenum == length(refpointsx) + 1
        noteindex2 = length(pitch);
    else
        noteindex2 = refpointsx(notenum)-1;
    end
    notesamples = noteindex1:noteindex2;
    notepitch = pitch(notesamples);  
else
    notepitch = pitch;
end
if length(notepitch) > 1
    xend = length(notepitch);
else
    xend = 1;
end

set(gcf,'CurrentAxes',handles.sngaxes2)
plot(notepitch, '-wo', ...
    'MarkerEdgeColor', 'r', ...
    'MarkerFaceColor', 'r')
ylim([0 125000])
xlim([0 xend])
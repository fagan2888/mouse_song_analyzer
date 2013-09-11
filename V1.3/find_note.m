function [notepitch] = find_note(pitch, refpointsx, notenum)
%This work is licensed from LabDaemons <info@labdaemons.com> 
%under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
if isempty(refpointsx) == 0 
    noteindex1 = 1;
    noteindex2 = refpointsx(notenum);
    if noteindex2 > length(pitch)
        noteindex2 = length(pitch);
    end
    notesamples = noteindex1:noteindex2;
    notepitch = pitch(notesamples); 
else
    notepitch = pitch;
end
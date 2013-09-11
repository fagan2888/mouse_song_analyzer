function [noteMat2] = tag_notes(jumpMat, traceMat, noteMat)
%This work is licensed from LabDaemons <info@labdaemons.com> 
%under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
totalnotes = 0;
for m = 1 : size(traceMat,1)
    refpointsx = jumpMat{m};
    if isempty(refpointsx)
        notenumber = 1;
    else
        notenumber = length(refpointsx)+1;
    end
    totalnotes = totalnotes + notenumber;
end
noteMat2 = cell(2,totalnotes);
noteindex = 1;
for whisnum = 1 : size(traceMat,1)
    pitch=traceMat{whisnum};
    refpointsx =jumpMat{whisnum};
    if isempty(refpointsx) == 0
        for notenum = 1 : length(refpointsx)+1
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
            if noteindex2 > length(pitch)
                noteindex2 = length(pitch);
            end
            notetype1 = noteMat{whisnum,2};
            notetype2 = num2str(notenum);
            notelabel = cat(2,notetype1, notetype2);
            notesamples = noteindex1:noteindex2;
            notepitch = pitch(notesamples);
            noteMat2{1,noteindex} = notelabel;
            noteMat2{2,noteindex} = notepitch;
            noteMat2{3,noteindex} = whisnum;
            noteindex = noteindex + 1;
        end
    else
        notelabel = noteMat{whisnum,2};
        notepitch = pitch;
        noteMat2{1,noteindex} = notelabel;
        noteMat2{2,noteindex} = notepitch;
        noteMat2{3,noteindex} = whisnum;
        noteindex = noteindex + 1;
    end
end
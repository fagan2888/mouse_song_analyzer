function note_data = analyze_notes(noteMat2)
%This work is licensed from LabDaemons <info@labdaemons.com> 
%under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
if isempty(noteMat2)
    return
else
    note_data = cell(size(noteMat2,2), 9);
    for note_num = 1 : size(noteMat2,2)
        note_pitch = noteMat2{2,note_num};
        if isempty(note_pitch) == 0
            note_data{note_num,1} = noteMat2{1,note_num};
            note_data{note_num,2} = length(note_pitch);
            note_data{note_num,3} = min(note_pitch);
            note_data{note_num,4}= mean(note_pitch);
            note_data{note_num,5}= max(note_pitch);
            note_data{note_num,6}= note_pitch(1);
            note_data{note_num,7}= note_pitch(end);
            note_data{note_num,8}= max(note_pitch) - min(note_pitch);
            note_data{note_num,9}= noteMat2{3,note_num};
        else
            note_data{note_num,1} = noteMat2{1,note_num};
            note_data{note_num,2} = [];
            note_data{note_num,3} = [];
            note_data{note_num,4}= [];
            note_data{note_num,5}= [];
            note_data{note_num,6}= [];
            note_data{note_num,7}= [];
            note_data{note_num,8}= [];
            note_data{note_num,9}= noteMat2{3,note_num};
        end
    end
end
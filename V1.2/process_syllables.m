function process_syllables(noteMat, syllTag, animalID, sessionID, min_count)
%This work is licensed from LabDaemons <info@labdaemons.com> 
%under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
syllTags = noteMat(:,2);
a_index = find(strcmp(syllTag,syllTags));
xTag = 'Unclassified';
x_index = find(strcmp(xTag,syllTags));
x_count = length(x_index);
a_count = length(a_index);
a_Name = [animalID '-' sessionID '-' syllTag];
a_Name2 = [a_Name '.csv'];
a_MeanName = [a_Name '-means' '.csv'];
numCols = size(noteMat,2);
means_a = zeros(3,numCols);
if a_count > min_count
    a_Mat = cell(a_count,size(noteMat,2));
    for i = 1 : a_count
        noteNum = a_index(i);
        a_Mat(i,:) = noteMat(noteNum,:);
    end
    a_Cat = cell(1,numCols);
    for i = 2 : numCols
        a_Cat{i} = cat(1,a_Mat{:,i});
    end
    nogaps = isnan(a_Cat{4});
    a_Cat{4}(nogaps) = [];
    for i = 1 : numCols
        if isnumeric(a_Cat{i})
            means_a(1,i) = mean(a_Cat{i});
            means_a(2,i) = median(a_Cat{i});
            means_a(3,i) = std(a_Cat{i});
        end
    end
    cell2csv(a_Name2, a_Mat)
end
    means_a(:,numCols+1) = a_count;
    means_a(:,numCols+2) = length(syllTags) - x_count;
    means_a(:,numCols+3) = (a_count/(length(syllTags) - x_count))*100;
    means_a(:,1:2) = [];
    save(a_MeanName, 'means_a', '-ascii', '-tabs')
clear means_a a_Mat a_Cat a_MeanName a_Name a_Name2 means_a a_count a_Save nogaps noindex amplitudes amplitudeS noteNum nonum
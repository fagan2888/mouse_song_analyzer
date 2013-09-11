function cell2csv(datName,cellArray)
%This work is licensed from LabDaemons <info@labdaemons.com> 
%under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
seperator = ';';
datei = fopen(datName,'w');
for z=1:size(cellArray,1)
    for s=1:size(cellArray,2)
        var = eval('cellArray{z,s}');
        if size(var,1) == 0
            var = '';
        end
        if isnumeric(var) == 1
            var = num2str(var);
        end       
        if islogical(var) == 1
            if var == 1
                var = 'TRUE';
            else
                var = 'FALSE';
            end
        end        
        var = ['"' var '"'];
        fprintf(datei,var);        
        if s ~= size(cellArray,2)
            fprintf(datei,seperator);
        end
    end
    fprintf(datei,'\n');
end
fclose(datei);
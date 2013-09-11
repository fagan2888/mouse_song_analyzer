function [syl] = breakup_s(syl,num,pitch,harm)
pitch_der = diff(pitch);
total_diff = sum(pitch_der);
minp = min(pitch);
maxp = max(pitch);
if isempty(pitch) == 0
    start = pitch(1);
    final = pitch(end);
    if length(pitch) < 15
        syl{num} = 'shrt';
    elseif harm == 1
        syl{num} = 'harm';
    elseif (maxp - minp) < 3000
        syl{num} = 'flat';
    elseif (maxp - start) > 12500 && (maxp - final) > 6250
        syl{num} = 'chev';
    elseif (final - start) > 6250 && (maxp - minp) > 12500 && total_diff > 0
        syl{num} = 'up';
    elseif (start - final) > 6250 && (maxp - minp) > 12500 && total_diff < 0
        syl{num} = 'down';
    else
        syl{num} = 's';
    end
else
    syl{num} = 'unclassified';
end
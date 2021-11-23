%% Count 
array = 1;
breaths = zeros(1, 4);
jump = zeros(1, 4);

for c = 1 : 4
    for r = 1 : 945
         jump(array) = jump(array) + counttable(r,c);
    end
    jump(array) =  jump(array) / 945
    array = array + 1;
end

array = 1;
for c = 1 : 4
    for r = 1 : 945
        if counttable(r,c) > ( (( counttable(r+1,c)+ counttable(r+2,c) + counttable(r+3,c)) / 3) + jump(c)) 
            breaths(array) = breaths(array) + 1;
        end
    end
    array = array + 1;
 end
 
numberofbreaths = (breaths(1) + breaths(2) + breaths(3) + breaths(4))/4




%% REMOVED FROM OTHER 

%% ----------------------------- Count ----------------------------------
array = 1;
breaths = zeros(1, 4);
for c = 2 : 5 
    for r = 2 : ( nframes - 3 )
        if signal(r,c) > ( ( signal(r+1,c)+ signal(r+2,c) + signal(r+3,c) ) / 3 + 3.3 ) 
            breaths(array) = breaths(array) + 1;
        end
    end
    array = array + 1;
 end
 
numberofbreaths = (breaths(1) + breaths(2) + breaths(3) + breaths(4))/4

array = 1;
breaths2 = zeros(1, 4);
for c = 2 : 5 
    for r = 2 : ( nframes - 3 )
        if signalbefore(r,c) > ( ( signalbefore(r+1,c)+ signalbefore(r+2,c) + signalbefore(r+3,c) ) / 3 + 3.3 ) 
            breaths2(array) = breaths2(array) + 1;
        end
    end
    array = array + 1;
 end
 
numberofbreaths2 = (breaths2(1) + breaths2(2) + breaths2(3) + breaths2(4))/4






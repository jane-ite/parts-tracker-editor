function [do_something_else] = lookUp()
% LOOKUP function for the Parts_Tracker_Editor Script
    % looks up and gives description of an existing part within
    % a user specified tracker sheet.

% This function takes no input, as it interacts with the user
% in order to find the part, assembly, or other file that the
% user would like to inspect.

%% Cleanup

clc;

%% Setup and Sheet Validation

fprintf("Make sure the tracker sheet is in the current folder.");
tracker_name = input("\nWhat parts tracker are you looking in? (full name): ", 's');

% checking validity

[status, types] = xlsfinfo(tracker_name); % gets status of alleged sheet 
                                          % and the names of the sheets

if(status ~= "Microsoft Excel Spreadsheet")
    error("Bad file.");
end

check_something_else = true;
options = length(types);

%% What are we looking up
while(check_something_else)
    do_something_else = false;
    
    %% Part Type
    for i = 1:1:options
        fprintf("\n" +string(i) + ' - ' + types(i));
    end
    type_number = input("\nWhat type of part are you looking up? Input the corresponding number: ");
    part_type = string(types(type_number));
    
    % load that sheet
    sheet_IDs = readtable(tracker_name, 'Sheet', part_type, 'Range', 'A:B');
    sheet_IDs = string(table2cell(sheet_IDs));
    
    
    %% Do you know the name
    
    name_known = input("Do you know the name of the file? Y/N: ", 's');
    if(all(name_known == 'Y') || all(name_known == 'y'))
        name = input("Please type the file name (CATEGORY;PART_NAME): ", 's');
        [exists, part_loc, rows_to_take] = findPart(sheet_IDs, name);

        if(~exists)
            fprintf("\nI cannot locate a part of this name, please try again\n");
            do_something_else = true;
        else
            for i = 1:1:rows_to_take
                part_info = string(table2cell(readtable(tracker_name, 'Sheet', part_type, 'Range', part_loc(i), 'PreserveVariableNames', true)));
                fprintf('\n\nPart:          ' + part_info(1) + ";" + part_info(2) + ";" + part_info(3) + part_info(4))
                fprintf('\nLast Updated:  ' + part_info(5));
                fprintf('\nDescription:   ' + part_info(6));
            end
            loop_again = input("\n\nTo look up another part, type Y: ");
            do_something_else = (all(loop_again == "Y") || all(loop_again == "y"));
        end
    
    %% No you don't
    
    else % name unknown
        %this is going to hurt
    end
    
end



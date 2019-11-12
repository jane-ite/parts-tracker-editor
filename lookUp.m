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

[status, types] = xlsfinfo(tracker_name);

if(status ~= "Microsoft Excel Spreadsheet")
    error("Bad file.");
end

check_something_else = true;
options = length(types);

%% What are we looking up
while(check_something_else)
    
    %% Part Type
    for i = 1:1:options
        fprintf("\n" +string(i) + types(i))
    end
    type_number = input("What type of part are you looking up? Input the corresponding number: ");
    part_type = types(type_number);
    
    %% Do you know the name
    
    name_known = input("Do you know the name of the file? Y/N: ");
    if(name_known)
        name = input("Please type the file name (CATEGORY;PART_NAME): ", 's');
        exists, part_info = findPart(tracker_name, part_type, name);
        if(~exists)
            fprintf("\nI cannot locate a part of this name, please try again\n");
            do_something_else = true;
        else
            full_name = part_info(1);
            category = part_info(2);
            version = part_info(3);
            last_updated = [art_info(4);
                description = part_info(5);
                
                fprintf("\n" + part_type + ": " + full_name + ":" +...
                "\n\tCategory: " + category +...
                "\n\tVersion: " + version +...
                "\n\tLast Updated:" +last_updated +...
                "\n\tDescription: " +...
                "\n\t\t" + description);
                
                loop_again = input("\n\nWould you like to look up something else? Y/N");
                do_something_else = (loop_again == "Y" || loop_again == "y");
        end
    
    %% No you don't
    
    else % name unknown
        %this is going to hurt
    end
    
end

    function [exists, part_info] = findPart(tracker_name, part_type, name)
        % FINDPART function for the LOOKUP function of the Parts_Tracker_Editor Script
        % takes the type and name of a desired part, assembly, etc. and
        % finds the part in a specified sheet
        
        % Read in the correct sheet
        current_sheet = readtable(tracker_name, part_type);
    end
end



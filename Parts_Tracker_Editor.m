%% Parts Tracker Editor
% will hopefully take an excel sheet of parts, read the parts,
% and allow for easy searching, updating, and recording of past
% and present edits

% Should be able to
    % Create a new parts tracker sheet
    % Read an existing parts tracker sheet
    % Add new parts
    % Add assemblies and associated parts
    % Remove/Archive unused parts
    % Update status of existing parts
    
%% Clearing Up

close all;
clear;
clc;

%% Interfacing Scripts
% The options/choices for users

% Overall Goal: What is the main thing the user wants to do
overall_goals = ["Look up a part", "Modify an existing sheet", "Create a new sheet", "Multiple things with the same sheet"];
num_goals = length(overall_goals);

%% Determine User Desire:
    
    %% Overall Goal

    fprintf("Welcome to the Parts Tracker Editor, what is your desire?\n");

    for i = 1:1:num_goals
        fprintf( "\t" + string(i) + ": " +  overall_goals(i) + "\n" );
    end

    todays_job = input("Choose one of the options by entering the corresponding number: ");

    % Input Verification
    goal_options = 1:1:num_goals;

    annoyed_count = 0;

    while(~any(goal_options == todays_job) && annoyed_count < 10)

        fprintf("\nInvalid input\n");

        for i = 1:1:num_goals
            fprintf( "\t" + string(i) + ": " +  overall_goals(i) + "\n" );
        end

        todays_job = input("Choose one of the options by entering the corresponding number: ");

        annoyed_count = annoyed_count + 1;

    end

    if(annoyed_count == 10)
        error("Why would you open this program if you won't follow my instructions.\n Please try again once you've learned to follow directions/n")
    end
    %% Specific Goal
    switch todays_job
        case 1 % Look up a part
            lookUp();
        case 2 % Modify a part
            
        case 3 % Create a new sheet
            
        case 4 % multiple things
            fprintf("\nMake sure the tracker sheet is in the current folder.")
            sheetname = input("\nWhat sheet will you be modifying today? (Include full name): ", 's');
    end
    
%% CASE 4: Multiple Things



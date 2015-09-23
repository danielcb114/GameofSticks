%Daniel Brewer
%Date:10/20/14
%Section:201
clear all;
close all;
clc;

%Minimum number of sticks the user can choose to play with
MinimumSticks = 10;
%Maximum number of sticks the user can choose to play with
MaximumSticks = 100;
%How long the intro animation will play before starting the game
IntroLength = 5;
%How long the animated border is for the welcome screen(in characters)
BorderLength = 60;
%How many sticks the AI will play with
SmartSticks = 10;

%calls the opening screen function which displays an animated opening
%screen for the user, that runs for IntroLength seconds and is BorderLength
%characters wide
OpeningScreen(IntroLength,BorderLength);

Playing = true;

while Playing;
    
    
    Done = false;
    
    
    
    %creates a pop-up window for the user to choose who to play. either a
    %untrained computer, or a friend on the same computer.
    GameMode = menu('Game Modes','Play against a friend','Play against the computer', 'Play and train an AI', 'Play against a trained AI');
    
    %uses the game mode variable to branch into the different game
    %functions.
    switch GameMode
        case 1
            %Gets sticks from the user
            while ~Done
                
                %prompts the player to give a number of sticks between 10 and 100
                SticksInput = input('Number of sticks initially (10-100)?: ');
                
                %If sticksinput is equal to its floor, it must be an integer
                if SticksInput >= MinimumSticks && SticksInput <= MaximumSticks && SticksInput == floor(SticksInput)
                    Sticks = SticksInput;
                    Done = true; %ends the loop and the function outputs an amount of sticks on the field.
                else
                    %"Done" will still be false, and the while loop will run again
                    fprintf('Invalid entry. Please try again.\n');
                end
                
            end
            %Play against a friend
            PlayAgainstFriend(Sticks);
            
        case 2
            %Gets sticks from the user
            while ~Done
                
                %prompts the player to give a number of sticks between 10 and 100
                SticksInput = input('Number of sticks initially (10-100)?: ');
                
                %If sticksinput is equal to its floor, it must be an integer
                if SticksInput >= MinimumSticks && SticksInput <= MaximumSticks && SticksInput == floor(SticksInput)
                    Sticks = SticksInput;
                    Done = true; %ends the loop and the function outputs an amount of sticks on the field.
                else
                    %"Done" will still be false, and the while loop will run again
                    fprintf('Invalid entry. Please try again.\n');
                end
                
            end
            %Play against the computer
            PlayAgainstComp(Sticks);
        case 3
            %Play and train an AI
            PlayAndTrain(SmartSticks);
        case 4
            %Play against a trained AI
            PlayTrained(SmartSticks);
    end
    
    %Simple menu to ask the user if they'd like to play again
    Continue = menu('Would you like to play another game?','Yes','No');
    
    % if the continue variable = 2 (indicating "no"), then the program
    % will set Playing equal to false, making the loop cease to repeat
    % after printing a new line.
    if Continue == 2
        Playing = false; %stops the while loop and ends the program.
        fprintf('\n'); %drops down a line for the command window to be usable again
    end
end

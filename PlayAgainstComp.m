function PlayAgainstComp(SticksInput)

%Alex Clarke
%Daniel Brewer
%Date:10/20/14
%Section:201
%Runs the game mode to play against the computer. Calls the computerTurn
%and playerTurn functions
%
% Uses boolean functions within the while loop,having the players (computer
% and human) take sticks until either player loses.
%
% Inputs:
%   -SticksInput: The number of sticks currently on the field, Initially
%   coming from GetSticks function

%Initializes the Finished variable which controls the while loop
Finished = false;

while ~Finished
        
%   Calls the function to prompt player 1 for their turn choice 
    %Passes number of sticks on field to the function, then takes the updated value
    
    %Calls the playerTurn function, passing SticksInput to it, the
    %current number of sticks on the field. gameOver is true if the
    %Player took as many or greater sticks than there were left on the field. SticksInput then gets
    %updated after the Player takes them. 
    [SticksInput,gameOver] = playerTurn(1,SticksInput);
    if gameOver 
       fprintf('Player 1 loses\n');
       Finished = true;
    end
    
    if ~Finished
        %Calls the computerTurn function, passing SticksInput to it, the
        %current number of sticks on the field. gameOver is true if the
        %computer took as many or greater sticks than there were left on the field.
        %SticksInput gets updated with how many sticks are on the field
        %after the computer takes them. 
        [SticksInput,gameOver] = computerTurn(SticksInput);
    else
        %Initializes gameOver so that it can be checked below
        gameOver=0;
    end
    
    
    if gameOver
       fprintf('Computer loses.\n');
       % When gameOver = true, the while loop reads "Finished" and promptly
       % closes.
       Finished = true;
    end
    
end


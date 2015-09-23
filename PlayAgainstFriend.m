function PlayAgainstFriend(SticksInput)

%Alex Clarke
%Daniel Brewer
%Date:10/20/14
%Section:201
%Runs the game mode to play against a friend. Calls playerTurn function
%
% Uses boolean functions within the while loop, having the two *human* players take sticks until either player loses.
%
% Inputs:
%   -SticksInput: The number of sticks currently on the field which
%   initially comes from GetSticks function

%Initializes the Finished variable which controls the while loop
gameOver = false;

while ~gameOver
        
%   Calls the function to prompt player1 for their turn choice 
    %Passes number of sticks on field to the function, then takes the updated value
    
    %Calls the Player1TakeSticks function, passing SticksInput to it, the
    %current number of sticks on the field. PlayerLose is true if the
    %Player took as many or greater sticks than there were left on the field. SticksInput then gets
    %updated after the Player takes them. 
    [SticksInput,gameOver] = playerTurn(1,SticksInput);
    %SticksInput=0;
    %gameOver=true; 
    
    if gameOver 
       fprintf('Player 1 loses\n');
       
    end
    
    if ~gameOver
        %Calls for the second turn to be taken, passing SticksInput to the second player. gameOver is true if the
        %Player 2 took all the sticks on the field.
        %SticksInput gets updated with how many sticks are on the field
        %after player 2 takes them. 
        [SticksInput,gameOver] = playerTurn(2,SticksInput);

    end
    
    
    if gameOver
       fprintf('Player 2 loses.\n');
       % When gameOver = true, the while loop reads "Finished" and promptly
       % closes.
       gameOver = true;
    end
    
end


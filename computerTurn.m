function [remSticks,gameOver] = computerTurn(numSticks)

%Simulaates the turn of a unintelligent computer, i.e. random picks
%Inputs:
%   -SticksInput: How many sticks are currently on the field
%Outputs:
%   -remSticks: How many sticks are left on the field after the computer
%   takes their turn
%   -gameOver: Whether or not the computer made a move resulting in a loss

% prints how many sticks are on the field
fprintf('\nThere are %d sticks on the field.\n',numSticks);
%computer picks a random integer between 1 and three for its selection, or
%fewer if there aren't that many sticks on the field. 

if numSticks < 3;
   SticksPicked = randi([1,numSticks]);
else
    SticksPicked = randi([1,3]);
end

if SticksPicked == numSticks
   gameOver = true;
   remSticks = 0;
else
    gameOver = false;
    remSticks = numSticks - SticksPicked;
end


% prints the amount of sticks that the computer picked so that the player
% knows.
fprintf('The computer selected %d.\n',SticksPicked');

end

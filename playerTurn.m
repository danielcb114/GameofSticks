function [remSticks,gameOver] = playerTurn(player,numSticks)

%Alex Clarke 
%Daniel Brewer
%Date:10/20/14
%Section:201
%
%Lets Player1 take a turn; asks them how many sticks they want, tells them
%how many sticks there are left on the board, and outputs whether or not
%they lost. 
%
%Inputs:
%   -player:Which players turn it is currently(1 or 2)
%   -numSticks: How many sticks are currently on the field
%Outputs:
%   -remSticks: How many sticks are left on the field after Player1
%   takes their turn
%   -gameOver: Whether or not Player1 made a move resulting in a loss

%minimum number of sticks that can be taken
SticksMin = 1;
%maximum number of sticks that can be taken
SticksMax = 3;


%Initialize the boolean variable for the test loop
ValidPick = false;

%initially, the remaining sticks on the field is equal to the number of
%sticks on the board.
remSticks = numSticks;

%Tell the user how many sticks are on the field
fprintf('\nThere are %d sticks on the field.\n',numSticks);

while ~ValidPick
    fprintf('Player %d: ',player);
    SticksPicked = input('How many sticks do you take(1-3)?: ');
    %SticksPicked must be >=1, <=3, and have no decimal component(equal to
    %its floor)
    if SticksPicked >= SticksMin && SticksPicked <=SticksMax && SticksPicked == floor(SticksPicked);
        WithinRange = true;
    else
        %This happens if the user inputs a value that will never be valid
        fprintf('Invalid value. Please select an integer between %d and %d\n',SticksMin,SticksMax);
        WithinRange = false;
    end
    
    if WithinRange 
        if SticksPicked > remSticks
           %This is for if the user selected more sticks than are available
           %on the field
           fprintf('There aren''t that many sticks. Try again.\n');
        elseif SticksPicked == numSticks
            %If the user picks a value equal to exactly how many sticks are
            %on the field, they lose. 
            gameOver = true;
            remSticks = 0;
            ValidPick = true;
        else
            %The game keeps going, the loop exits and the value for sticks
            %is updated here, if the user entered a valid choice for
            %how many sticks they want. 
            gameOver = false;
            remSticks = numSticks - SticksPicked;
            ValidPick = true;
        end
    end      
end

fprintf('You selected %d.\n',SticksPicked);



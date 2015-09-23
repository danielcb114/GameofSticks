function [remSticks,gameOver,SticksPicked] = SmartTurn(Sticks,Hats) %#ok<INUSL>

%{
%Alex Clarke
%Daniel Brewer
%Date:10/20/14
%Section:201
%Has the computer take a turn based on its past experiences
Inputs:
    -CompNumber:The number of the computer(usually 1, could be 2 if playing
    against another)
    -Sticks: The number of sticks currently on the field
Outputs:
    -remSticks:How many sticks are remaining after the computer takes
    its turn
    -gameOver:Whether or not the computer lost
    -SticksPicked:How many sticks the computer picked up

%}


% disp(Sticks)

%disp('debug message:SmartTurn, line 18')
SticksPicked = Hats{1,Sticks}(randi([1,length(Hats{1,Sticks})]));
while SticksPicked > Sticks
    SticksPicked = Hats{1,Sticks}(randi([1,length(Hats{1,Sticks})]));
end

remSticks = Sticks - SticksPicked;
if remSticks == 0
    gameOver = true;
else
    gameOver = false;
end

end
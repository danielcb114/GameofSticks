function PlayAndTrain(SticksInput)

%{
%Daniel Brewer
%Date:10/20/14
%Section:201
Description:Runs a game between the player and a learning AI.
Inputs:
    -Sticks: The number of sticks currently on the field
%}

Sticks = SticksInput;
%How many hats there are
NumHats = 10;
%Create a cell array corresponding to each hat
Hats = cell([1,NumHats]);
%The number of copies of a ball to add each time it results in a win
SuccessBalls = 2;

%Initialize the cell array; i.e., fill each hat with the balls
for i=1:length(Hats)
    Hats{1,i} = [1,2,3];
end

%The number of choices that the computer has made
CompChoiceNumber = 0;
%How many choices are allocated for the computer
NumChoices = 10^1;
%This Matrix records the choices of the computer as play goes on. The first
%column records the sticks on the field when it made its choice(the number of its hat), the second
%records how many sticks it picked up(the ball it grabbed)
CompChoiceRecord = zeros([NumChoices,2]);
%Initialize losing boolean variables for later checking

% While the user still wants to play:
Playing = true;
while Playing
    % run playerturn
    [Sticks, PlayerLose] = playerTurn(1,Sticks);
    
    % run smartturn, update sticks, stickspicked
    if ~PlayerLose
        %increment the choice forward(what row ro use for recording)
        CompChoiceNumber = CompChoiceNumber + 1;
        fprintf('\nThere are %d sticks on the field.\n',Sticks);
        %Record how many sticks there were when the computer made its decision
        CompChoiceRecord(CompChoiceNumber,1) = Sticks;
        %Run the function determining how many sticks the computer will pick
        [Sticks, CompLose, SticksPicked] = SmartTurn(Sticks,Hats);
        %Record how many sticks the computer picked up
        CompChoiceRecord(CompChoiceNumber,2) = SticksPicked;
        fprintf('The computer selected %d.\n',SticksPicked');
    end
    
    
    % If the computer won, add the winning balls to their hats
    if PlayerLose
        %trim choices
        CompChoiceRecord(CompChoiceRecord==0) = [];
        %Correctly resize the matrix after trimming breaks the formatting
        CompChoiceRecord = reshape(CompChoiceRecord,[length(CompChoiceRecord)/2,2]);
        %make sure the computer has had a chance
        %Stop playing
        Playing = false;
        fprintf('Player 1 loses\n');
        if ~isempty(CompChoiceRecord)
            for i=1:size(CompChoiceRecord,1)
                %Select the hat corresponding to the sticks on the field for that
                %choice. Add two balls coresponding to that choice.
                Hats{1,CompChoiceRecord(i,1)} = [Hats{1,CompChoiceRecord(i,1)} repmat(CompChoiceRecord(i,2),[1,SuccessBalls])];
            end
        end
    end
    
    
    % if it lost, remove those balls
    if CompLose
        %Stop playing
        Playing = false;
        fprintf('The computer loses\n');
        %trim choices
        CompChoiceRecord(CompChoiceRecord==0) = [];
        %Correctly resize the matrix after trimming breaks the formatting
        CompChoiceRecord = reshape(CompChoiceRecord,[length(CompChoiceRecord)/2,2]);
        for i=1:size(CompChoiceRecord,1)
            %add a single ball back to replace all the ones you
            %took. I know this is inefficient; and a good argument
            %for better planning.
            Hats{1,Comp1ChoiceRecord(i,1)} = [Hats{1,Comp1ChoiceRecord(i,1)} Comp1ChoiceRecord(i,2)];
        end
    end

    %Ask the user if they want to play another round.
    if ~Playing
        
        PlayAgain = menu('Would you like to play another round with the AI?','Yes','No');
        
        switch PlayAgain
            case 1
                Playing = true;
                %Reset values for the next round
                Sticks = SticksInput;
                CompChoiceRecord = zeros([NumChoices,2]);
            case 2
                Playing = false;
        end
    end
    
end

end
function PlayTrained(SticksInput)

%Daniel Brewer
%Date:10/20/14
%Section:201

Sticks = SticksInput;
%How many hats there are
NumHats = 10;
%How many games to play for training the AI
NumGames = 1000;
%Initialize Hats
Hats1 = cell([1,NumHats]);
Hats2 = cell([1,NumHats]);
%The number of copies of a ball to add each time it results in a win
SuccessBalls = 2;

% fill up two sets of hats
for i=1:length(Hats1)
    Hats1{1,i} = [1,2,3];
end

for i=1:length(Hats2)
    Hats2{1,i} = [1,2,3];
end

%The number of choices that the computer has made
Comp1ChoiceNumber = 0;
Comp2ChoiceNumber = 0;
%How many choices are allocated for the computer
NumChoices = 10^2;
%This Matrix records the choices of the computer as play goes on. The first
%column records the sticks on the field when it made its choice(the number of its hat), the second
%records how many sticks it picked up(the ball it grabbed)
Comp1ChoiceRecord = zeros([NumChoices,2]);
Comp2ChoiceRecord = zeros([NumChoices,2]);
%Initialize losing boolean variables for later checking

%initialize logic variables
Training = true;
Comp1Lose = false;
Comp2Lose = false;

%Tell user to be patient.
fprintf('\nThe AI is being trained now. You might want to grab a drink--this will take a while.\n');

% for 1 to #games
for i=1:NumGames
    % while training
    while Training
        % comp1 takes turn; run smartturn, update sticks, stickspicked
        
        if ~Comp1Lose && ~Comp2Lose
            %increment the choice forward(what row ro use for recording)
            Comp1ChoiceNumber = Comp1ChoiceNumber + 1;
            %fprintf('\nThere are %d sticks on the field.\n',Sticks);
            %Record how many sticks there were when the computer made its decision
            Comp1ChoiceRecord(Comp1ChoiceNumber,1) = Sticks;
            %Run the function determining how many sticks the computer will pick
            [Sticks, Comp1Lose, SticksPicked] = SmartTurn(Sticks,Hats1);
            %Record how many sticks computer1 picked up
            Comp1ChoiceRecord(Comp1ChoiceNumber,2) = SticksPicked;
            %fprintf('The computer selected %d.\n',SticksPicked');
        end
        
        if ~Comp1Lose && ~Comp2Lose
            %increment the choice forward(what row ro use for recording)
            Comp2ChoiceNumber = Comp2ChoiceNumber + 1;
            %fprintf('\nThere are %d sticks on the field.\n',Sticks);
            %Record how many sticks there were when the computer made its decision
            Comp2ChoiceRecord(Comp2ChoiceNumber,1) = Sticks;
            %Run the function determining how many sticks the computer will pick
            [Sticks, Comp2Lose, SticksPicked] = SmartTurn(Sticks,Hats2);
            %Record how many sticks computer1 picked up
            Comp2ChoiceRecord(Comp2ChoiceNumber,2) = SticksPicked;
            %fprintf('The computer selected %d.\n',SticksPicked');
        end
        
        % If the comp1 wins, add balls to hat1
        if Comp2Lose
            %trim choices
            Comp1ChoiceRecord(Comp1ChoiceRecord==0) = [];
            Comp2ChoiceRecord(Comp2ChoiceRecord==0) = [];
            %Correctly resize the matrix after trimming breaks the formatting
            Comp1ChoiceRecord = reshape(Comp1ChoiceRecord,[length(Comp1ChoiceRecord)/2,2]);
            Comp2ChoiceRecord = reshape(Comp2ChoiceRecord,[length(Comp2ChoiceRecord)/2,2]);
            %Stop playing
            Training = false;
            %make sure comp1 has had a chance
            if ~isempty(Comp1ChoiceRecord)
                for j=1:size(Comp1ChoiceRecord,1)
                    %If comp1 wins, Select the hat corresponding to the sticks on the field for that
                    %choice. Add two balls coresponding to that choice.
                    Hats1{1,Comp1ChoiceRecord(j,1)} = [Hats1{1,Comp1ChoiceRecord(j,1)} repmat(Comp1ChoiceRecord(j,2),[1,SuccessBalls])];
                end
            end
            %Additionally, if comp1 wins, take balls from hat2
            for j=1:size(Comp2ChoiceRecord,1)
                %Make sure you don't take the last ball
                if sum(Hats2{1,Comp2ChoiceRecord(j,1)}==Comp2ChoiceRecord(j,2))~=1;
                    %Select the hat corresponding to the sticks on the field for that
                    %choice. Remove the ball corresponding to that choice(using logical indexing.
                    Hats2{1,Comp2ChoiceRecord(j,1)} = Hats2{1,Comp2ChoiceRecord(j,1)}(Hats2{1,Comp2ChoiceRecord(j,1)}~=Comp2ChoiceRecord(j,2));
                    %add a single ball back to replace all the ones you
                    %took. I know this is inefficient; and a good argument
                    %for better planning.
                    Hats2{1,Comp2ChoiceRecord(j,1)} = [Hats2{1,Comp2ChoiceRecord(j,1)} Comp2ChoiceRecord(j,2)];
                end
            end
        end
        
        if Comp1Lose
            %trim choices
            Comp1ChoiceRecord(Comp1ChoiceRecord==0) = [];
            Comp2ChoiceRecord(Comp2ChoiceRecord==0) = [];
            %Correctly resize the matrix after trimming breaks the formatting
            Comp1ChoiceRecord = reshape(Comp1ChoiceRecord,[length(Comp1ChoiceRecord)/2,2]);
            Comp2ChoiceRecord = reshape(Comp2ChoiceRecord,[length(Comp2ChoiceRecord)/2,2]);
            %Stop training
            Training = false;
            %make sure comp1 has had a chance
            if ~isempty(Comp2ChoiceRecord)
                for j=1:size(Comp2ChoiceRecord,1)
                    %Select the hat corresponding to the sticks on the field for that
                    %choice. Add two balls coresponding to that choice.
                    Hats2{1,Comp2ChoiceRecord(j,1)} = [Hats2{1,Comp2ChoiceRecord(j,1)} repmat(Comp2ChoiceRecord(j,2),[1,SuccessBalls])];
                end
            end
            %Additionally, if comp2 wins, take balls from hat1
            for j=1:size(Comp1ChoiceRecord,1)
                %Make sure you don't take the last ball
                if sum(Hats1{1,Comp1ChoiceRecord(j,1)}==Comp1ChoiceRecord(j,2))~=1;
                    %Select the hat corresponding to the sticks on the field for that
                    %choice. Remove the balls corresponding to that choice(using logical indexing.
                    Hats1{1,Comp1ChoiceRecord(j,1)} = Hats1{1,Comp1ChoiceRecord(j,1)}(Hats1{1,Comp1ChoiceRecord(j,1)}~=Comp1ChoiceRecord(j,2));
                    %add a single ball back to replace all the ones you
                    %took. I know this is inefficient; and a good argument
                    %for better planning.
                    Hats1{1,Comp1ChoiceRecord(j,1)} = [Hats1{1,Comp1ChoiceRecord(j,1)} Comp1ChoiceRecord(j,2)];
                end
            end
        end
        
    end
    %Reset values for the next round
    Sticks = SticksInput;
    Comp1ChoiceRecord = zeros([NumChoices,2]);
    Comp2ChoiceRecord = zeros([NumChoices,2]);
    Training = true;
    Comp1Lose = false;
    Comp2Lose = false;
end

%Done training the AI; now the user can play
Finished = false;
Sticks = 10;
while ~Finished
    %Calls the function to prompt player 1 for their turn choice
    %Passes number of sticks on field to the function, then takes the updated value
    
    %Calls the playerTurn function, passing SticksInput to it, the
    %current number of sticks on the field. gameOver is true if the
    %Player took as many or greater sticks than there were left on the field. SticksInput then gets
    %updated after the Player takes them.
    [Sticks,PlayerLose] = playerTurn(1,Sticks);
    
    if ~ PlayerLose
        [Sticks, CompLose, SticksPicked] = SmartTurn(Sticks,Hats1);
        fprintf('The smart computer selected %d.\n',SticksPicked);
    end
    
    if PlayerLose
        fprintf('Player 1 loses. Don''t feel bad; you never had a chance!\n');
        Finished = true;
    end
    
    if CompLose
        fprintf('Computer loses. You beat a smart cookie!\n');
        Finished = true;
    end
    if ~Finished
        %Calls the computerTurn function, passing SticksInput to it, the
        %current number of sticks on the field. gameOver is true if the
        %computer took as many or greater sticks than there were left on the field.
        %SticksInput gets updated with how many sticks are on the field
        %after the computer takes them.
        
    else
        %Initializes gameOver so that it can be checked below
        PlayerLose=0;
    end
    
    if Finished
        Again = menu('Play again?','Yes','No');
        if Again == 1
            Sticks = 10;
            Finished = false;
        end
    end
end
end




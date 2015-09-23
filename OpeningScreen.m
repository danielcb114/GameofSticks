function [] = OpeningScreen(IntroLength,BorderLength)

%Daniel Brewer
%Date:10/20/14
%Section:201
% ''Simply'' displays a welcome screen for the game. An animated 
%welcome screen that automatically centers text based on the border length.
% -IntroLength: How long the animation at the start plays (in seconds)
% -BorderLength: How long the border of the screen is (in characters)

%Frames per second of intro screen
FPS = 5;

%The styles of the alternating borders, as well as the space offsetting the
%welcome message
Border1Type = '*';
Border2Type = '-';
SpaceType = ' ';

%tiles the borders based on the styles
Border1 = repmat(Border1Type,[1,BorderLength]);
Border2 = repmat(Border2Type,[1,BorderLength]);

WelcomeMessage = 'Welcome to the Game of Sticks!';

%Calculates how many spaces there need to be to have the message perfectly
%centered
SpaceLength = ((BorderLength) - length(WelcomeMessage)) / 2;

%Creates the spaces for the welcome screen
Space = repmat(SpaceType,[1,SpaceLength]);

for i = 1:(IntroLength*FPS);
    %Uses remainder to alternate between the two border styles
    if rem(i,2)==0
        %Displays the first border
        disp(Border1),
        %Adds a space, the welcome message, and then the second space
        disp([Space,WelcomeMessage,Space])
        %Displays the second border
        disp(Border1);
    else
        %Displays the first border
        disp(Border2),
        %Adds a space, the welcome message, and then the second space
        disp([Space,WelcomeMessage,Space])
        %Displays the second border
        disp(Border2);
    end
    % sets the frequency of alternations of border.
    pause(1/FPS);
    % clears the border so that when it runs again and the remainder is
    % different, the new border replaces the old.
    clc
end

%Shows it one last time, and goes down some lines
disp(Border1),
disp([Space,WelcomeMessage,Space])
disp(Border1);
fprintf('\n\n');

end

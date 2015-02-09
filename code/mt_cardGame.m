function perc_correct = mt_cardGame(dirRoot, cfg_window, iRecall, varargs)
% ** function mt_cardGame(dirRoot, cfg_window, iRecall)
% This function starts the memory task.
%
% USAGE:
%     mt_cardGame(dirRoot, cfg_window, iRecall)
%
% >>> INPUT VARIABLES >>>
% NAME              TYPE        DESCRIPTION
% dirRoot           char        path to root working directory
% cfg_window        struct      contains window information
%   .screen         1X2 double  [screens ScreenNumber]
%   .window         1X5 double  [window windowRect], actual resolution
%   .window43       1X5 double  [window windowRect], 4:3 resolution
%   .center         1X2 double  [Xcenter Ycenter]
% iRecall           double      current recall session
%
% <<< OUTPUT VARIABLES <<<
% NAME              TYPE        DESCRIPTION
% perc_correct      double      Correctly clicked cards in percent
%
%
% AUTHOR: Marco R�th, contact@marcorueth.com

%% Load parameters specified in mt_setup.m
load(fullfile(dirRoot, 'setup', 'mt_params.mat'))   % load workspace information and properties

%% Set window parameters
% Specify the display window 
window      	= cfg_window.window(1);
ShowCursor;

%% Enable/Disable practice and feedback
if nargin == 4 && varargs == 0
    feedbackOn	= 0; % if set to 0 a blue dot is shown instead of feedback 
else
    feedbackOn	= 1;
end

%% Initialize variables for measured parameters
cardShown     	= cardSequence{cfg_dlgs.sesstype}';
cardClicked  	= zeros(length(cardShown), 1);
mouseData    	= zeros(length(cardShown), 3);

%% Show which session is upcoming
mt_showText(dirRoot, textSession{cfg_dlgs.sesstype}, window);
pause

%% Start the game
% In the learning session all pictures are shown in a sequence
% In the recall sessions mouse interaction is activated
for iCard = 1: length(cardShown)
    % Get current picture
    imageCurrent = cardShown(iCard);
    imageTop = images(imageCurrent);
    
    % Show a picture on top
    Priority(MaxPriority(window));
    Screen('DrawTexture', window, imageTop, [], topCard);
    Screen('FillRect', window, cardColors, rects);
    Screen('FrameRect', window, frameColor, rects, frameWidth);
    Screen('Flip', window, flipTime);
    Priority(0);

    % Delay flipping in case of learning for cardDelay
    if cfg_dlgs.sesstype == 2
        WaitSecs(topCardDisplay);
    end
    
    % Define which card will be flipped
    switch cfg_dlgs.sesstype
        case 2 % Learning
            % The card with the same image shown on top will be flipped
            cardFlip            = imageCurrent;
            cardClicked(iCard)  = cardFlip; % dummy
        otherwise % Recall/Interference
            % OnMouseClick: flip the card
            [cardFlip, mouseData(iCard, :)]	= mt_cardFlip(screenOff, ncards_x, cardSize, topCardHeigth, responseTime);
            % Save which card was clicked
            cardClicked(iCard)           	= cardFlip;
            % Show Feedback
            cardFlip                        = mt_showFeedback(dirRoot, window, cardFlip, feedbackOn, imageCurrent);
    end

    % Flip the card
    Priority(MaxPriority(window));
    Screen('DrawTexture', window, imageTop, [], topCard);

    % Fill all rects but the flipped one
    if cardFlip
        Screen('FillRect', window, cardColors, rects(:, (1:ncards ~= cardFlip)));
        Screen('DrawTexture', window, images(cardFlip), [], imgs(:, cardFlip));
    else
        % no cardFlip in last recall session
        Screen('FillRect', window, cardColors, rects);
    end
    Screen('FrameRect', window, frameColor, rects, frameWidth);
    Screen('Flip', window, flipTime);
    Priority(0);

    % Display the card for a time defined by cardDisplay
    WaitSecs(cardDisplay);
%     % Set fixed duration of trials 
%     WaitSecs(responseTime);
end

%% performance

isinterf = (cfg_dlgs.sesstype==3)+1;    % check if interference

correct             = (cardShown - cardClicked) + 1;
correct(correct~=1) = 0; % set others incorrect
imageNames          = imageConfiguration{cfg_dlgs.memvers}{isinterf}';
imageShown          = imageNames(cardShown);
imageClicked        = imageNames(cardClicked);
coordsShown         = cell(length(cardShown), 1);
coordsClicked       = cell(length(cardShown), 1);
for iCard = 1: length(cardShown)
    coordsShown{iCard}      = mt_cards1Dto2D(cardShown(iCard), ncards_x, ncards_y);
    coordsClicked{iCard}    = mt_cards1Dto2D(cardClicked(iCard), ncards_x, ncards_y);
end
% save cards shown, cards clicked, mouse click x/y coordinates, reaction time
performance         = table(correct, imageShown, imageClicked,  mouseData, coordsShown, coordsClicked);

% save session data
mt_saveTable(dirRoot, performance, feedbackOn)

% return performance
if cfg_dlgs.sesstype ~= 2 % if not learning session
    perc_correct        = sum(correct)/length(correct);
else
    perc_correct           = 1; % in percent
end

end
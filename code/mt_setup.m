function dirRoot = mt_setup(user)
% ** function mt_setup(user) 
% This script allows to adjust the most important parameters for the memory
% task. Define the variables here before you run mt_run.m.
% 
% IMPORTANT:    Do not change the order in which the variables are defined.
%               Some variables have mutual dependencies.
%
% >>> INPUT VARIABLES >>>
% NAME              TYPE        DESCRIPTION
% user              char       	pre-defined user name (see mt_loadUser.m)
%
% <<< OUTPUT VARIABLES <<<
% NAME              TYPE        DESCRIPTION
% dirRoot           char        path to root working directory
%
% 
% AUTHOR: Marco R�th, contact@marcorueth.com

%% ============================== BASICS ================================ %
% IMPORTANT: add your user profile in mt_loadUser
[dirRoot, dirPTB]   = mt_profile(user);

% Expermimental Details
experimentName  = 'Sleep Connectivity'; % name of your study
nLearningSess   = 2; % number of runs for learning
nMinRecall      = 2; % minimum runs for immediate recall (with feedback)
nMaxRecall      = 5; % maximum runs for immediate recall (to exclude if too poor performance)
nFinalRecall    = 2; % number of runs for final recall (incl. one last session w/o feedback)
RecallThreshold = 60;% miniumum correct answers in recall (in percent)
% screenNumber    = 2; % select specific screen

%% ======================== IMAGE CONFIGURATION ========================= %

% Use file names without file extension
imageConfiguration = {
  {{ % imagesA 	LEARNING
  'ant',            'whale',        'ray',          	'hippopotamus',     'fly'           'crocodile';
  'wasp',           'toucan',       'raven',            'lobster',          'giraffe',      'cow';
  'starfish',       'rooster',      'praying_mantis',   'lioness',          'grasshopper',  'cat';
  'barn_owl',       'pigeon',       'penguin',          'hummingbird',      'goose',        'armadillo';
  'scorpion',       'oyster',       'ostrich',          'horse',            'dromedary',    'dragonfly'
  }
  { % imagesA 	INTERFERENCE
  'goose',       	'barn_owl', 	'cat',              'starfish',			'rooster', 		'pigeon';
  'dromedary',      'dragonfly',   	'armadillo',        'ostrich',      	'horse',    	'penguin';
  'hummingbird',	'scorpion',  	'whale',            'ray',      		'ant',  		'oyster';
  'grasshopper', 	'wasp',   		'cow',              'fly',              'crocodile',	'raven';
  'lioness',		'praying_mantis','lobster',         'giraffe',        	'hippopotamus',  'toucan'
  }}
  {{ % imagesB 	LEARNING
  'sparrow',    'tiger',        'seagull',	'owl',          'partridge',    'cheetah';
  'zebra',      'pelican',      'dolphin',	'mussel',       'manatee'       'butterfly';
  'turtle',     'ladybird',     'rhino',	'mosquito',     'tapir',        'beetle';
  'elephant',   'platypus',     'pomfret',	'kiwi',         'crab',         'bee';
  'termite',   	'hen',          'kangaroo',	'killer_whale', 'duck',         'bat'
  }
  { % imagesB 	INTERFERENCE
  'rhino',		'killer_whale',	'duck',     'kangaroo',     'pomfret',		'zebra';
  'beetle',		'crab',			'bat',      'platypus',     'ladybird'      'seagull';
  'manatee',	'butterfly',	'bee',      'sparrow',      'hen',          'termite';
  'dolphin',	'mussel', 		'cheetah',  'partridge',    'pelican',      'turtle';
  'kiwi',       'tapir',        'tiger',    'elephant',     'owl',          'mosquito'
  }}
};


%% =========================== IMAGE SEQUENCE =========================== %

% Define in which order cards are flipped
% Special feature for you: 2D Table-view
% You can run the section 'IMAGE CONFIGURATION' above and then look at the
% tables 'imagesATable' and 'imagesBTable' for 2D coordinates below
[imagesATable, imagesBTable] = mt_imageTable(imageConfiguration);

% Create sequence for learning and interference
% Image Sequences for Image Set A
% Sequence 1: Learning
imageSequenceMainLearningA = {
    'starfish', 'crocodile', 'armadillo', 'pigeon', 'raven', 'horse', ...
	'lioness', 'rooster', 'dragonfly', 'penguin', 'lobster', 'ostrich', ...
	'fly', 'barn_owl', 'cow', 'ant', 'hummingbird', 'hippopotamus', ...
	'scorpion', 'giraffe', 'whale', 'dromedary', 'wasp', 'goose', ...
	'toucan', 'cat', 'praying_mantis', 'oyster', 'grasshopper', 'ray'
    };
imageSequenceInterferenceLearningA = imageSequenceMainLearningA;
% Sequence 2: Recall
imageSequenceimmediateRecallA = {
    'rooster', 'grasshopper', 'whale', 'crocodile', 'lobster', 'toucan', ...
	'cat', 'oyster', 'giraffe', 'barn_owl', 'ostrich', 'dromedary', ...
	'praying_mantis', 'dragonfly', 'penguin', 'starfish', 'lioness', 'scorpion', ...
	'raven', 'cow', 'pigeon', 'goose', 'hippopotamus', 'horse', ...
	'fly', 'hummingbird', 'wasp', 'ray', 'armadillo', 'ant'
    };
imageSequenceInterferenceRecallA = imageSequenceimmediateRecallA;
imageSequenceMainRecallA = imageSequenceimmediateRecallA;

% Image Sequence for Image Set B
% Sequence 1: Learning
imageSequenceMainLearningB = {
    'butterfly', 'hen', 'mussel', 'beetle', 'ladybird', 'cheetah', ...
	'killer_whale', 'owl', 'duck', 'mosquito', 'elephant', 'manatee' ...
	'tiger', 'bee', 'dolphin', 'pomfret', 'tapir', 'zebra', ...
	'termite', 'crab', 'seagull', 'platypus', 'partridge', 'turtle', ...
	'kangaroo', 'sparrow', 'rhino', 'bat', 'kiwi', 'pelican'
    };
imageSequenceInterferenceLearningB = imageSequenceMainLearningB;
% Sequence 2: Recall
imageSequenceimmediateRecallB = {
    'termite', 'zebra', 'kiwi', 'butterfly', 'duck', 'platypus', ...
	'pelican', 'kangaroo', 'crab', 'sparrow', 'tapir', 'rhino' ...
	'owl', 'beetle', 'seagull', 'bat', 'turtle', 'cheetah', ...
	'hen', 'dolphin', 'pomfret', 'bee', 'manatee', 'tiger', 'killer_whale', ...
	'elephant' , 'mosquito', 'partridge', 'ladybird', 'mussel'
    };
imageSequenceInterferenceRecallB = imageSequenceimmediateRecallB;
imageSequenceMainRecallB = imageSequenceimmediateRecallB;


%% ================================ TEXT ================================ %
% Text strings used during the program
textControl = { ...
    'Z�hlaufgabe'
    ''
    'Im Folgenden sehen Sie ein Feld voller grauer Karten.'
    'Von diesen Karten wird eine bestimmte Anzahl'
    'nacheinander verdunkelt werden.'
    ''
    'Ihre Aufgabe: '
    'Z�hlen Sie, wie viele Karten insgesamt dunkler'
    'geworden sind.' 
    'Schauen Sie dabei stets ganz entspannt auf das'
    'Kreuz in der Mitte der momentan verdunkelten Karte.'
};
textFixation = { ...
    'Fixation'
    ''
    'Es erscheint nun ein Kreuz in der Mitte'
    'des Bildschirms. Bitte schauen Sie auf dieses'
    'Kreuz, solange es angezeigt wird.'
    ''
    'Dies wird etwa 6 Minuten dauern.'
};
textLearning = { ...
    'Willkommen!'
    ''
    'Im Folgenden sehen Sie ein Feld voller verdeckter Karten.'
    'Unter jeder Karte befindet sich ein Bild.'
    ''
    'Jedes Bild wird zun�chst oben angezeigt.'
    'Dann wird darunter die dazu passende Karte aufgedeckt.'
    ''
    'Ihre Aufgabe:'
    'Merken Sie sich die Position der Karte.'
    'Nachher werden die Positionen abgefragt.'
    'Wichtig: Schauen Sie stets auf die untere aufgedeckte Karte.'
};
textLearning2Next = { ...
    ''
    ''
    ''
    'Nun beginnt der XXX. Lerndurchgang'
    };
textLearning2 = { ...
    'Lernen - jetzt geht es wirklich los!'
    ''
    'Es werden Ihnen nun alle 30 Bilder zwei Mal gezeigt.'
    ''
    'Nach dem Lernen folgt eine Abfrage der Positionen.'
    'Am Ende wird angezeigt, wie viel Prozent Sie richtig hatten.'
    'Die Abfrage wird so lange wiederholt, bis Sie bei 60% der'
    'Karten richtig liegen.'
    ''
    'Ihre Aufgabe: '
    'Merken Sie sich die Position der Karte. Schauen Sie '
    'dabei stets ganz entspannt auf die aufgedeckte Karte.'
    };
textLearningInterference = { ...
    'Lernen'
    ''
    'Nun folgen erneut zwei Lerndurchg�nge.'
    'Die Karten haben sogar die gleichen Motive wie vor dem'
    'Schlafengehen. Allerdings befinden sich die Motive'
    'nun an anderen Positionen.'
    ''
    'Ihre Aufgabe: '
    'Merken Sie sich die Position der Karte. Schauen Sie '
    'dabei stets ganz entspannt auf die aufgedeckte Karte.'
};
textOutro = { ...
    ''
    ''
    ''
    'Ende'
    ''
    'Vielen Dank!'
    ''
};
textPracticeLearn = { ...
    '�bungsdurchgang'
    ''
    'Lernen'
    ''
    'Merken Sie sich die Position der Karte. Schauen Sie'
    'stets ganz entspannt auf die aufgedeckte Karte.'
};
textPracticeRecall = { ...
    '�bungsdurchgang'
    ''
    'Abfrage'
    ''
    'Oben erscheint wieder jeweils ein Bild.'
    'Schauen Sie bitte kontinuierlich auf das Kreuz auf der'
    'verdeckten Karte, unter der Sie dieses Bild vermuten.'
    ''
    'Sobald die Kreuze verschwinden, '
    'klicken Sie bitte auf diese Karte.'
};
textQuestion = { ...
    ''
    ''
    ''
    'Haben Sie noch Fragen zum Ablauf?'
};
textRecall = { ...
    'Abfrage'
    'Nun m�chten wir von Ihnen wissen, wo die Bilder waren,'
    'die Sie VOR dem Schlafengehen gelernt haben.'
    ''
    ''
    'Oben erscheint jeweils das Bild.'
    'Schauen Sie bitte kontinuierlich auf das Kreuz auf der'
    'verdeckten Karte, unter der Sie dieses Bild vermuten.'
    ''
    'Klicken Sie bitte auf diese Karte, nachdem die Kreuze'
    'verschwunden sind.'
    ''
};
textRecall2 = { ...
    ''
    ''
    'Ihnen wird diesmal nicht gesagt, ob Sie richtig '
    'gelegen haben. Es erscheint lediglich ein blauer Punkt'
    'auf der geklickten Karte (kein Kreuz oder H�kchen).'
    ''
    'Am Ende wird Ihnen wie bisher gesagt, wie gut sie waren.'
    ''
};
textRecallAgain = { ...
    ''
    'Sie hatten XXX Prozent richtig.'
    ''
    'Die Abfrage wird wiederholt.'
    ''
};
textRecallDone = { ...
    ''
    'Gl�ckwunsch!'
    ''
    'Sie hatten XXX Prozent richtig.'
    'Jetzt nur noch ein Durchlauf!'
    ''
};
textRecallImmediate = { ...
    'Abfrage'
    ''
    'Oben erscheint wieder jeweils ein Bild.'
    'Schauen Sie bitte kontinuierlich auf das Kreuz auf der'
    'verdeckten Karte, unter der Sie dieses Bild vermuten.'
    ''
    'Sobald die Kreuze verschwinden, klicken Sie bitte'
    'auf die Karte, unter der Sie das Bild vermuten.'
};
textRecallInterference = textRecallImmediate;
textRecallNoFeedback = { ...
    ''
    'Die Abfrage wird noch einmal wiederholt. Diesmal wird'
    'nicht mehr angezeigt, ob Sie richtig gelegen haben.'
    ''
    'Es erscheint lediglich ein blauer Punkt auf der'
    'geklickten Karte.'
};
textRecallPerformance = { ...
    ''
    ''
    ''
    'Sie hatten XXX Prozent richtig.'
    ''
};
textSession = {
    'Konzentration'    % Control Task  
    'Lernen'           % Main Learning
    'Lernen'           % Interference Learning
    'Abfrage'          % Interference Recall
    'Abfrage'          % Immediate Recall & Main Recall 
    'Konzentration'    % Gray Mode
};

% Text Properties
textDefSize     = 25;           % default Text Size
textDefFont     = 'Arial';      % default Text Font
textDefColor    = [0 0 0];      % default Text Color
textSx          = 'center';     % default Text x-position
textSy          = 10;           % default Text y-position
textVSpacing    = 2;            % default Text vertical line spacing


%% =========================== IMAGE FOLDERS ============================ %
% Card images
imageFolder       = {'imagesA', 'imagesB', 'imagesPractice'};
imageFileExt      = '.jpg';		% image file types

% Feedback images
feedbackFolder    = 'imagesFeedback';
imagesFeedback    = {'correct.png', 'incorrect.png', 'nofeedback.png', 'cross.png'};
feedbackMargin    = 10;       	% #pixels the images are smaller than the cards


%% ========================== CARD PROPERTIES =========================== %
% Number of cards
ncards_x            = 6;
ncards_y            = 5;

% Top Card Properties
topCardHeigth       = 200;          % Size of the top Card
topCardColor        = [.9; .9; .9];    % Color of the top Card

% Memory Cards
cardColors          = [.5; .5; .5]; % Color of cards
cardMargin          = 5;            % Margin between cards
frameWidth          = 2;            % Frame/border around cards
frameColor          = 0;            % Frame color

% Control Task Card Properties
cardColorControl        = 0.3;          % color of highlighted card
textColorCorrect        = [0.2 1 0.2];  % text color for correct response
textColorIncorrect      = [1 0.2 0.2];  % text color for incorrect response
controlTextMargin       = 200;          % distance in x from text to card
controlFeedbackDisplay  = 2;            % feedback display duration

crossSize               = [0 0 30 30];
circleSize              = [0 0 50 50];                  


%% ============================== OPTIONAL ============================== %
% Change Cursor Type
CursorType          = 'Arrow';

% Set Display properties
% Define which window size is used as reference to display the cards
windowSize          = [1024 768];
screenBgColor       = [1 1 1]; % white background
textBgColor         = [1 1 1]; % white background

% Define which display window is used (put a number)
% Note: by default external screens are automatically used if connected 
% window              = ;

% Set Timing (seconds)
topCardDisplay      = 2;    	% Duration image is shown on top Card
topCardGreyDisplay  = 1;        % Duration top Card is shown in grey
cardDisplay         = 7;     	% Duration memory cards are shown
cardCrossDisplay    = 7;        % Duration cross is displayed on cards
cardRecallDisplay   = 1;     	% Duration memory cards are shown
feedbackDisplay     = 1;        % Duration feedback is shown
responseTime        = 15;       % Duration allowed to respond (click)
whiteScreenDisplay  = 2;
% Fixation Task (mt_fixationTask)
fixationCrossDisplay = 7.5;     % Duration fixation cross is displayed


%% ======================= DO NOT CHANGE FROM HERE ====================== %
% Unless you know what you are doing...
% !!!!! Changes need further adjustments in other files and scripts !!!!! %

% Changing the accepted cases also requires to change mt_dialogues.m
cfg_cases.subjects  = 0:1000;                           % 0 is debug
cfg_cases.nights    = {'1', '2'};                       % Night 1 or 2
cfg_cases.memvers   = {'A', 'B'};                       % Memory version
cfg_cases.sesstype  = {'C', 'L', 'I', 'R', 'G'};        % Session Type
cfg_cases.lab       = {'MEG', 'SL3', 'SL4', 'local'};   % Lab/Location
cfg_cases.odor      = {'0', '1'}; 
cfg_cases.sessNames = {'Control', 'Learning', 'Interference', ...
    'Recall', 'Recall', 'GrayMode'};

% image folder
imgfolderA        	= fullfile(dirRoot, imageFolder{1});
imgfolderB      	= fullfile(dirRoot, imageFolder{2});

% Read in feedback images
imgfolderFeedback           = fullfile(dirRoot, feedbackFolder);
[imgCorrect, ~, alpha]      = imread(fullfile(imgfolderFeedback, imagesFeedback{1}));
imgCorrect(:,:,4)           = alpha;
[imgIncorrect, ~, alpha]    = imread(fullfile(imgfolderFeedback, imagesFeedback{2}));
imgIncorrect(:,:,4)         = alpha;
[imgNoFeedback, ~, alpha]   = imread(fullfile(imgfolderFeedback, imagesFeedback{3}));
imgNoFeedback(:,:,4)        = alpha;
[imgCross, ~, alpha]        = imread(fullfile(imgfolderFeedback, imagesFeedback{4}));
imgCross(:,:,4)             = alpha;


% Size of Memory Cards
topCardWidth        = topCardHeigth * (4/3);
cardHeigth          = round((windowSize(2)-topCardHeigth)/ncards_y);
cardWidth           = round(windowSize(1)/ncards_x);
cardSize            = [0 0 cardWidth cardHeigth]; % size to fill screen
cardSize(3:4)       = cardSize(end-1:end)-cardMargin;
ncards              = ncards_x * ncards_y;

% Size of images hidden under the cards
imagesSize          = [0 0 cardHeigth*(4/3) cardHeigth]; % assure 4:3
imagesSize(3:4)     = imagesSize(3:4)-cardMargin;

% Generate file names of images
imageFilesA         = {
    cellfun(@(x) strcat(x, imageFileExt), imageConfiguration{1}{1}', 'UniformOutput', false)
    cellfun(@(x) strcat(x, imageFileExt), imageConfiguration{1}{2}', 'UniformOutput', false)
    };
imageFilesB         = {
    cellfun(@(x) strcat(x, imageFileExt), imageConfiguration{2}{1}', 'UniformOutput', false)
    cellfun(@(x) strcat(x, imageFileExt), imageConfiguration{2}{2}', 'UniformOutput', false)
    };

% Practice set settings
imageFilesP             = {'teapot.jpg', 'guitar.jpg', 'jacket.jpg'};
imageSequencePractice   = [4, 7, 2];
imgfolderP              = fullfile(dirRoot, imageFolder{3});


% Convert image sequences for further processing
imageSequenceMainLearningCoordsA            = zeros(1, size(imageSequenceMainLearningA, 2));
imageSequenceInterferenceLearningCoordsA    = zeros(1, size(imageSequenceInterferenceLearningA, 2));
imageSequenceInterferenceRecallCoordsA      = zeros(1, size(imageSequenceInterferenceRecallA, 2));
imageSequenceMainRecallCoordsA              = zeros(1, size(imageSequenceMainRecallA, 2));

imageSequenceMainLearningCoordsB            = zeros(1, size(imageSequenceMainLearningB, 2));
imageSequenceInterferenceLearningCoordsB    = zeros(1, size(imageSequenceInterferenceLearningB, 2));
imageSequenceInterferenceRecallCoordsB      = zeros(1, size(imageSequenceInterferenceRecallB, 2));
imageSequenceMainRecallCoordsB              = zeros(1, size(imageSequenceMainRecallB, 2));

for i = 1: size(imageSequenceMainLearningA, 2)
    imageSequenceMainLearningCoordsA(i)         = find(cellfun(@(x) strcmp(x, imageSequenceMainLearningA{i}), imageConfiguration{1}{1}'));
    imageSequenceInterferenceLearningCoordsA(i) = find(cellfun(@(x) strcmp(x, imageSequenceInterferenceLearningA{i}), imageConfiguration{1}{2}'));
    imageSequenceInterferenceRecallCoordsA(i)   = find(cellfun(@(x) strcmp(x, imageSequenceInterferenceRecallA{i}), imageConfiguration{1}{2}'));
    imageSequenceMainRecallCoordsA(i)           = find(cellfun(@(x) strcmp(x, imageSequenceMainRecallA{i}), imageConfiguration{1}{1}'));
    
    imageSequenceMainLearningCoordsB(i)         = find(cellfun(@(x) strcmp(x, imageSequenceMainLearningB{i}), imageConfiguration{2}{1}'));
    imageSequenceInterferenceLearningCoordsB(i) = find(cellfun(@(x) strcmp(x, imageSequenceInterferenceLearningB{i}), imageConfiguration{2}{2}'));
    imageSequenceInterferenceRecallCoordsB(i)   = find(cellfun(@(x) strcmp(x, imageSequenceInterferenceRecallB{i}), imageConfiguration{2}{2}'));
    imageSequenceMainRecallCoordsB(i)           = find(cellfun(@(x) strcmp(x, imageSequenceMainRecallB{i}), imageConfiguration{2}{1}'));
end

% Check if every image were used exactly once
if  ~isempty(setdiff(imageConfiguration{1}{1}', imageSequenceMainLearningA)) ...
        || ~isempty(setdiff(imageConfiguration{1}{2}', imageSequenceInterferenceLearningA)) ...
        || ~isempty(setdiff(imageConfiguration{1}{2}', imageSequenceInterferenceRecallA)) ...
        || ~isempty(setdiff(imageConfiguration{1}{1}', imageSequenceMainRecallA)) ... 
        || ~isempty(setdiff(imageConfiguration{2}{1}', imageSequenceMainLearningB)) ...
        || ~isempty(setdiff(imageConfiguration{2}{2}', imageSequenceInterferenceLearningB)) ...
        || ~isempty(setdiff(imageConfiguration{2}{2}', imageSequenceInterferenceRecallB)) ...
        || ~isempty(setdiff(imageConfiguration{2}{1}', imageSequenceMainRecallB)) 
    error('Every image has to be used exactly once')
end

% Load sequence for controlList
try
    controlSequence = load(fullfile(dirRoot, 'code/help_functions/controlSequence.mat'));
    controlList     = controlSequence.controlList;
    controlSequence = controlSequence.controlSequence;
catch
    fprintf('Control Lists missing: run mt_controlList.m\n')
    error(ME.message)
end

% Store 2D coordinates for cards to be flipped
cardSequence 	= {...
    { % Memory version A
    % Sequence for Control
    controlSequence; % identical across subjects
    % Sequence for Learning
    imageSequenceMainLearningCoordsA; ...
    % Sequence for Interference Learning
    imageSequenceInterferenceLearningCoordsA; ...
    % Sequence for Interference Recall
    imageSequenceInterferenceRecallCoordsA; ...
    % Sequence for Immediate Recall & Retrieval
    imageSequenceMainRecallCoordsA; ...
    % Sequence for Gray Mode
    controlSequence ...
    }
    { % Memory version B
    % Sequence for Control
    controlSequence; % identical across subjects
    % Sequence for Learning
    imageSequenceMainLearningCoordsB; ...
    % Sequence for Interference Learning
    imageSequenceInterferenceLearningCoordsB; ...
    % Sequence for Interference Recall
    imageSequenceInterferenceRecallCoordsB; ...
    % Sequence for Immediate Recall & Retrieval
    imageSequenceMainRecallCoordsB; ...
    % Sequence for Gray Mode
    controlSequence ...
    }
}; 

% % Transform intuitive 2D coordinates into 1D coordinates used for iteration
% cardSequence        = cell(size(imageSequence2D));
% for r = 1: size(cardSequence, 2)
%     cardSequence{r} = cellfun(@(x) mt_cards2Dto1D(x, ncards_x, ncards_y), imageSequence2D{r});
% end

% Folder for configurations
setupdir            = fullfile(dirRoot, 'setup');
if ~exist(setupdir, 'dir')
    mkdir(setupdir) % create folder in first run
end

% Folder for data
if ~exist(fullfile(dirRoot, 'DATA'), 'dir')
    mkdir(fullfile(dirRoot, 'DATA')) % create folder in first run
    mkdir(fullfile(dirRoot, 'BACKUP'))
end

% Save configuration in workdir
cd(dirRoot)
save(fullfile(setupdir, 'mt_params.mat'))
end
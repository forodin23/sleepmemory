%% TODO: Documentation
%% Prepare workspace

close all;          % Close all figures
clear all;          % Clear all variables in the workspace
sca;                % Clear all features related to PTB

% TODO: load mt_setup.mat generated by mt_setup.m

% optional: configure root directory
workdir             = 'D:\Studium T�bingen\Master Thesis\00 - Program\';
cd(workdir)

% prepare and open the window on the screen
% TODO: Window management: do we want two screens to show different information (experimenter vs. subject)?
cfg_window          = mt_window();

% draw the cards
mt_cards(cfg_window);

% Type "sca" and hit enter if the window freezes
commandwindow
close all
clc
clear all

% ao=analogoutput('nidaq','dev2');
% addchannel(ao,[0,1]);
% 
% set(ao,'TriggerType','Immediate');
% set(ao,'SampleRate',10000);


amplitude          =1;
frequency          =10;
sampling_frequency = 20000;    %sampling rate (Hz)
duration           = 1;       %duration of the stimulus (sec)
t                  = 1 / sampling_frequency:1 / sampling_frequency:duration;
stimulus       = (amplitude *(sin(2*pi*frequency*t)+ 1)/2);  
% stimulus       = amplitude * sin(2*pi*frequency*t - pi/2) + 2.5; 
stimulus(1,1:1500)=0;

trigger            =zeros(length(stimulus),1); 
trigger(1:1000,1)  = 5;


% 
% putdata(ao,[stimulus' trigger]);                  
% start(ao);



plot (stimulus,'g')
% hold on
% plot (trigger, 'r')






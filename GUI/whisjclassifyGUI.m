function [ljdownindx,ljupindx] = whisjclassifyGUI(pitch,pitchnext)
%This work is licensed from LabDaemons <info@labdaemons.com> 
%under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License.
dclust = [40 30; 125 117; 125 30; 40 30]*1000;
uclust = [30 40; 30 125; 110 125; 30 40]*1000;
ljdown = inpolygon(pitch,pitchnext,dclust(:,1),dclust(:,2));
ljup = inpolygon(pitch,pitchnext,uclust(:,1),uclust(:,2));
ljdownindx = find(ljdown);
ljupindx = find(ljup);
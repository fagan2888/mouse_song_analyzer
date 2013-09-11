mouse_song_analyzer
===================

Matlab program to categorize and analyze mouse syllables


v1.3 Release Notes

Allows selecting a minimum frequency below 35 kHz when generating sonograms.



v1.2 Release Notes

A new option has been added to find harmonics when processing sonograms. This feature improves performance when dealing with complex syllables that have harmonic components.

When a harmonic is present, the fundamental frequency will be estimated and used for categorization instead of peak frequency. This approach avoids classification errors that may occur when the peak frequency rapidly jumps between the fundamental and harmonic.

This approach is VERY sensitive to cage noise around frequencies that can be mistaken for a harmonic of the peak frequency (typically around 30 - 40 kHz). Thus, you should only use the harmonics feature if your recordings are free of cage noise.
The threshold for harmonic detection can be set by editing line 4 of "whisparamsGUI.m".


Please watch the following video for a brief overview of the major functions:

http://youtu.be/4YPiXpnyr-0

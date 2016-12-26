#Reusable classes for your music.
##effects
In this folder you'll find effects.
##rand_loop.ck
Switches between different versions of the same loop at random positions.
##rec.ck
May be used to record left and right channel.
##rms_rand_loop.ck and .rb
Switches between different versions of the same loop at random positions, but only when there's silence,
so you cannot really hear the changes.
###Usage
You have to call ```RMSRandLoop.analyze(fname)``` from a Ruby script to generate ```silence_arr_#{fname}.ck```,
which you have to include in your ChucK program. For an example, see ../descarga_giardia.
##stereo_rand_loop.ck
It's basically two RandLoops, one for each channel.
##timer.ck
A timer class for a more flexible time handling.



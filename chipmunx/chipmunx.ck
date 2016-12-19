1::minute / 130. =>Timer.set_T;
0=>Timer.start_at;

spork~Rec.rec("Chipmunx") @=> Shred aarec;

Gain mono => Gain limitingLeft => NRev nl => Dyno dyLeft => dac.left;
mono => Gain limitingRight => NRev nr => Dyno dyRight => dac.right;

.015=>nl.mix;
.015=>nr.mix;

dyLeft.limit();
.65=>dyLeft.thresh;
.15=>dyLeft.slopeAbove;

.72=>limitingLeft.gain;

dyRight.limit();
.65=>dyRight.thresh;
.15=>dyRight.slopeAbove;

.72=>limitingRight.gain;

fun void changeMixTo(float target) {
	while (nl.mix() < target) {
		nl.mix()*1.02=>nl.mix;
		nr.mix()*1.02=>nr.mix;
		<<<nl.mix()>>>;
		5::ms=>now;
	} 
}

StereoRandLoop guit_theme_1;
"Guit_theme_1"=>guit_theme_1.read;
guit_theme_1.chuckLeft() => limitingLeft;
guit_theme_1.chuckRight() => limitingRight;
.8=>guit_theme_1.setPan;
5=>guit_theme_1.setMaxLoopNo;
8=>guit_theme_1.setPeriodicity;
guit_theme_1.setRandPeriod(1, 4, 1./32.); 


StereoRandLoop guit_theme_2;
"Guit_theme_2"=>guit_theme_2.read;
guit_theme_2.chuckLeft() => limitingLeft;
guit_theme_2.chuckRight() => limitingRight;
.8=>guit_theme_2.setPan;
7=>guit_theme_2.setMaxLoopNo;
4=>guit_theme_2.setPeriodicity;
guit_theme_2.setRandPeriod(1, 4, 1./32.); 


StereoRandLoop guit_theme_3;
"Guit_theme_3"=>guit_theme_3.read;
guit_theme_3.chuckLeft() => limitingLeft;
guit_theme_3.chuckRight() => limitingRight;
.8=>guit_theme_3.setPan;
7=>guit_theme_3.setMaxLoopNo;
4=>guit_theme_3.setPeriodicity;
guit_theme_3.setRandPeriod(1, 4, 1./32.); 

StereoRandLoop guit_theme_4;
"Guit_theme_4"=>guit_theme_4.read;
guit_theme_4.chuckLeft() => limitingLeft;
guit_theme_4.chuckRight() => limitingRight;
.8=>guit_theme_4.setPan;
7=>guit_theme_4.setMaxLoopNo;
4=>guit_theme_4.setPeriodicity;
guit_theme_4.setRandPeriod(1, 4, 1./32.); 

StereoRandLoop guit_theme_5;
"Guit_theme_5"=>guit_theme_5.read;
guit_theme_5.chuckLeft() => limitingLeft;
guit_theme_5.chuckRight() => limitingRight;
.8=>guit_theme_5.setPan;
3=>guit_theme_5.setMaxLoopNo;
32=>guit_theme_5.setPeriodicity;
guit_theme_5.setRandPeriod(1, 4, 1./32.); 
/*
1.7=>guit_theme_5.setGain;
day=>now;*/


/////

StereoRandLoop ashiko;
"Ashiko"=>ashiko.read;
ashiko.chuckLeft() => limitingLeft;
ashiko.chuckRight() => limitingRight;
.8=>ashiko.setPan;
30=>ashiko.setMaxLoopNo;
4=>ashiko.setPeriodicity;
ashiko.setRandPeriod(1, 4, 1./32.); 

StereoRandLoop chekere;
"Chekere"=>chekere.read;
chekere.chuckLeft() => NRev nchl => limitingLeft;
chekere.chuckRight() => NRev nchr => limitingRight;
.1=>nchl.mix;
.1=>nchr.mix;
.8=>chekere.setPan;
13=>chekere.setMaxLoopNo;
4=>chekere.setPeriodicity;
chekere.setRandPeriod(1, 4, 1./32.); 

/////

StereoRandLoop bass_1;
"Bass_1"=>bass_1.read;
bass_1.chuckLeft() => limitingLeft;
bass_1.chuckRight() => limitingRight;
.8=>bass_1.setPan;
4=>bass_1.setMaxLoopNo;
8=>bass_1.setPeriodicity;
bass_1.setRandPeriod(1, 4, 1./4.); 

StereoRandLoop bass_2;
"Bass_2"=>bass_2.read;
bass_2.chuckLeft() => limitingLeft;
bass_2.chuckRight() => limitingRight;
.8=>bass_2.setPan;
4=>bass_2.setMaxLoopNo;
4=>bass_2.setPeriodicity;
bass_2.setRandPeriod(1, 4, 1./4.); 
//1.5=>bass_2.setGain;day=>now;
//1.5=>bass_2.setGain;day=>now;

StereoRandLoop bass_3;
"Bass_3"=>bass_3.read;
bass_3.chuckLeft() => limitingLeft;
bass_3.chuckRight() => limitingRight;
.8=>bass_3.setPan;
6=>bass_3.setMaxLoopNo;
4=>bass_3.setPeriodicity;
bass_3.setRandPeriod(1, 4, 1./4.); 

StereoRandLoop bass_4;
"Bass_4"=>bass_4.read;
bass_4.chuckLeft() => limitingLeft;
bass_4.chuckRight() => limitingRight;
.8=>bass_4.setPan;
7=>bass_4.setMaxLoopNo;
4=>bass_4.setPeriodicity;
bass_4.setRandPeriod(1, 4, 1./4.); 

StereoRandLoop bass_5;
"Bass_5"=>bass_5.read;
bass_5.chuckLeft() => limitingLeft;
bass_5.chuckRight() => limitingRight;
.8=>bass_5.setPan;
3=>bass_5.setMaxLoopNo;
32=>bass_5.setPeriodicity;
bass_5.setRandPeriod(1, 4, 1./4.); 


////////////////////

StereoRandLoop chords_1;
"Chords_1"=>chords_1.read;
chords_1.chuckLeft() => limitingLeft;
chords_1.chuckRight() => limitingRight;
.8=>chords_1.setPan;
5=>chords_1.setMaxLoopNo;
8=>chords_1.setPeriodicity;
chords_1.setRandPeriod(1, 4, 1./32.); 


StereoRandLoop chords_2;
"Chords_2"=>chords_2.read;
chords_2.chuckLeft() => limitingLeft;
chords_2.chuckRight() => limitingRight;
.8=>chords_2.setPan;
7=>chords_2.setMaxLoopNo;
4=>chords_2.setPeriodicity;
chords_2.setRandPeriod(1, 4, 1./32.); 


StereoRandLoop chords_3;
"Chords_3"=>chords_3.read;
chords_3.chuckLeft() => limitingLeft;
chords_3.chuckRight() => limitingRight;
.8=>chords_3.setPan;
6=>chords_3.setMaxLoopNo;
4=>chords_3.setPeriodicity;
chords_3.setRandPeriod(1, 4, 1./32.); 

StereoRandLoop chords_4;
"Chords_4"=>chords_4.read;
chords_4.chuckLeft() => limitingLeft;
chords_4.chuckRight() => limitingRight;
.8=>chords_4.setPan;
6=>chords_4.setMaxLoopNo;
4=>chords_4.setPeriodicity;
chords_4.setRandPeriod(1, 4, 1./32.); 

StereoRandLoop chords_5;
"Chords_5"=>chords_5.read;
chords_5.chuckLeft() => limitingLeft;
chords_5.chuckRight() => limitingRight;
.8=>chords_5.setPan;
2=>chords_5.setMaxLoopNo;
32=>chords_5.setPeriodicity;
chords_5.setRandPeriod(1, 4, 1./32.); 

StereoRandLoop tres_1;
"Tres_1"=>tres_1.read;
tres_1.chuckLeft() => limitingLeft;
tres_1.chuckRight() => limitingRight;
.8=>tres_1.setPan;
8=>tres_1.setMaxLoopNo;
8=>tres_1.setPeriodicity;
tres_1.setRandPeriod(1, 4, 1./4.); 
//1.5=>tres_1.setGain;day=>now;
StereoRandLoop tres_2;
"Tres_2"=>tres_2.read;
tres_2.chuckLeft() => limitingLeft;
tres_2.chuckRight() => limitingRight;
.8=>tres_2.setPan;
7=>tres_2.setMaxLoopNo;
4=>tres_2.setPeriodicity;
tres_2.setRandPeriod(1, 4, 1./4.); 

StereoRandLoop tres_3;
"Tres_3"=>tres_3.read;
tres_3.chuckLeft() => limitingLeft;
tres_3.chuckRight() => limitingRight;
.8=>tres_3.setPan;
8=>tres_3.setMaxLoopNo;
4=>tres_3.setPeriodicity;
tres_3.setRandPeriod(1, 4, 1./4.); 

StereoRandLoop tres_4;
"Tres_4"=>tres_4.read;
tres_4.chuckLeft() => limitingLeft;
tres_4.chuckRight() => limitingRight;
.8=>tres_4.setPan;
5=>tres_4.setMaxLoopNo;
4=>tres_4.setPeriodicity;
tres_4.setRandPeriod(1, 4, 1./4.); 

StereoRandLoop tres_5;
"Tres_5"=>tres_5.read;
tres_5.chuckLeft() => limitingLeft;
tres_5.chuckRight() => limitingRight;
.8=>tres_5.setPan;
3=>tres_5.setMaxLoopNo;
32=>tres_5.setPeriodicity;
tres_5.setRandPeriod(1, 4, 1./4.); 

//1.5=>tres_5.setGain;day=>now;
//////////////


/*
1.7=>chords_5.setGain;
day=>now;*/

3.8=>float bassGain;
2.8=>float guitThemeGain;
2.5=>float chordsGain;
.85=>float chekereGain;
1.8=>float ashikoGain;
1.1=>float tresGain;

2=>float bass2multiplier;
.95=>float bass5multiplier;
.65=>float bass3multiplier;
.75=>float bass4multiplier;

guitThemeGain=>guit_theme_1.setGain;

8=>Timer.advance;

ashikoGain=>ashiko.setGain;
chekereGain=>chekere.setGain;

8=>Timer.advance;
bassGain=>bass_1.setGain;
0=>Timer.advance;
7.75=>Timer.advance;
0=>guit_theme_1.setGain;
.2=>Timer.advance;

0=>bass_1.setGain;
bassGain*bass2multiplier=>bass_2.setGain;
.05=>Timer.advance;
guitThemeGain=>guit_theme_2.setGain;
3.75=>Timer.advance;
0=>guit_theme_2.setGain;
.25=>Timer.advance;
0=>ashiko.setGain;
0=>chekere.setGain;
0=>bass_2.setGain;
bassGain*bass3multiplier=>bass_3.setGain;
guitThemeGain=>guit_theme_3.setGain;
3.75=>Timer.advance;
0=>guit_theme_3.setGain;
ashikoGain=>ashiko.setGain;
chekereGain=>chekere.setGain;
.25=>Timer.advance;
0=>bass_3.setGain;


//////////////////////

guitThemeGain=>guit_theme_1.setGain;

bassGain=>bass_1.setGain;
7=>Timer.advance;


8.5=>Timer.advance;

.5=>Timer.advance;
7.75=>Timer.advance;
0=>guit_theme_1.setGain;
.2=>Timer.advance;

0=>bass_1.setGain;
bassGain*bass2multiplier=>bass_2.setGain;
.05=>Timer.advance;
guitThemeGain=>guit_theme_2.setGain;
3.75=>Timer.advance;
0=>guit_theme_2.setGain;
.25=>Timer.advance;
0=>bass_2.setGain;
0=>ashiko.setGain;
0=>chekere.setGain;
bassGain*bass4multiplier=>bass_4.setGain;
guitThemeGain=>guit_theme_4.setGain;
3.75=>Timer.advance;
0=>guit_theme_4.setGain;
ashikoGain=>ashiko.setGain;
chekereGain=>chekere.setGain;
.25=>Timer.advance;
0=>bass_4.setGain;
////////////////////////


guitThemeGain=>guit_theme_5.setGain;
bassGain*bass5multiplier=>bass_5.setGain;
32=>Timer.advance;
0=>guit_theme_5.setGain;
0=>bass_5.setGain;


/////

guitThemeGain=>guit_theme_1.setGain;
bassGain=>bass_1.setGain;

7=>Timer.advance;
8.5=>Timer.advance;
.5=>Timer.advance;
7.75=>Timer.advance;
0=>guit_theme_1.setGain;
.2=>Timer.advance;

0=>bass_1.setGain;
bassGain*bass2multiplier=>bass_2.setGain;
.05=>Timer.advance;
guitThemeGain=>guit_theme_2.setGain;
3.75=>Timer.advance;
0=>guit_theme_2.setGain;
.25=>Timer.advance;
0=>ashiko.setGain;
0=>chekere.setGain;
0=>bass_2.setGain;
bassGain*bass3multiplier=>bass_3.setGain;
guitThemeGain=>guit_theme_3.setGain;
3.75=>Timer.advance;
0=>guit_theme_3.setGain;
ashikoGain=>ashiko.setGain;
chekereGain=>chekere.setGain;
.25=>Timer.advance;
0=>bass_3.setGain;






/////////////////////////////////////////


tresGain=>tres_1.setGain;
chordsGain=>chords_1.setGain;
bassGain=>bass_1.setGain;
8=>Timer.advance;


8=>Timer.advance;
0=>Timer.advance;
7.75=>Timer.advance;
0=>tres_1.setGain;
.2=>Timer.advance;

0=>chords_1.setGain;
0=>bass_1.setGain;
bassGain*bass2multiplier=>bass_2.setGain;
.05=>Timer.advance;
chordsGain=>chords_2.setGain;
tresGain=>tres_2.setGain;
3.75=>Timer.advance;
0=>tres_2.setGain;
.25=>Timer.advance;
0=>ashiko.setGain;
0=>chekere.setGain;
0=>bass_2.setGain;
0=>chords_2.setGain;
chordsGain=>chords_3.setGain;
bassGain*bass3multiplier=>bass_3.setGain;
tresGain=>tres_3.setGain;
3.75=>Timer.advance;
0=>tres_3.setGain;
ashikoGain=>ashiko.setGain;
chekereGain=>chekere.setGain;
.25=>Timer.advance;
0=>bass_3.setGain;
0=>chords_3.setGain;

//////////////////////

tresGain=>tres_1.setGain;
chordsGain=>chords_1.setGain;
bassGain=>bass_1.setGain;
7=>Timer.advance;


8.5=>Timer.advance;

.5=>Timer.advance;
7.75=>Timer.advance;
0=>tres_1.setGain;
.2=>Timer.advance;

0=>bass_1.setGain;
0=>chords_1.setGain;
chordsGain=>chords_2.setGain;
bassGain*bass2multiplier=>bass_2.setGain;
.05=>Timer.advance;
tresGain=>tres_2.setGain;
3.75=>Timer.advance;
0=>tres_2.setGain;
.25=>Timer.advance;
0=>bass_2.setGain;
0=>chords_2.setGain;
0=>ashiko.setGain;
0=>chekere.setGain;
bassGain*bass4multiplier=>bass_4.setGain;
chordsGain=>chords_4.setGain;
tresGain=>tres_4.setGain;
3.75=>Timer.advance;
0=>tres_4.setGain;
ashikoGain=>ashiko.setGain;
chekereGain=>chekere.setGain;
.25=>Timer.advance;
0=>bass_4.setGain;
0=>chords_4.setGain;
////////////////////////


tresGain=>tres_5.setGain;
bassGain*bass5multiplier=>bass_5.setGain;
chordsGain=>chords_5.setGain;
32=>Timer.advance;
0=>tres_5.setGain;
0=>bass_5.setGain;
0=>chords_5.setGain;


/////

tresGain=>tres_1.setGain;
bassGain=>bass_1.setGain;
chordsGain=>chords_1.setGain;

7=>Timer.advance;
8.5=>Timer.advance;
.5=>Timer.advance;
7.75=>Timer.advance;
0=>tres_1.setGain;
.2=>Timer.advance;

0=>bass_1.setGain;
0=>chords_1.setGain;
bassGain*bass2multiplier=>bass_2.setGain;
.05=>Timer.advance;
chordsGain=>chords_2.setGain;
tresGain=>tres_2.setGain;
3.75=>Timer.advance;
0=>tres_2.setGain;
.25=>Timer.advance;
0=>ashiko.setGain;
0=>chekere.setGain;
0=>bass_2.setGain;
0=>chords_2.setGain;
chordsGain=>chords_3.setGain;
bassGain*bass3multiplier=>bass_3.setGain;
tresGain=>tres_3.setGain;

1.75=>Timer.advance;

spork~changeMixTo(.5);

2=>Timer.advance;
0=>tres_3.setGain;
ashikoGain=>ashiko.setGain;
chekereGain=>chekere.setGain;
.25=>Timer.advance;
0=>bass_3.setGain;
0=>chekere.setGain;
0=>chords_3.setGain;
0=>ashiko.setGain;

4::second=>now;

aarec.exit();

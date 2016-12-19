1::minute / 110. =>Timer.set_T;
0=>Timer.start_at;

spork~Rec.rec("Christmas_storm_cha") @=> Shred aarec;

Gain mono => Gain limitingLeft => Dyno dyLeft => dac.left;
mono => Gain limitingRight => Dyno dyRight => dac.right;

dyLeft.limit();
.65=>dyLeft.thresh;
.15=>dyLeft.slopeAbove;

.85=>limitingLeft.gain;

dyRight.limit();
.65=>dyRight.thresh;
.15=>dyRight.slopeAbove;

.85=>limitingRight.gain;

// van pár stereo track,
StereoRandLoop bassloop;
"bass"=>bassloop.read;
194345 => bassloop.setStartPos;
bassloop.chuckLeft() => limitingLeft;
bassloop.chuckRight() => limitingRight;
.6=>bassloop.setPan;
9=>bassloop.setMaxLoopNo;
bassloop.setRandPeriod(1, 1, 1./16.); 
//1.4=>bassloop.setGain;

StereoRandLoop cimloop;
"cim"=>cimloop.read;
194345 => cimloop.setStartPos;
cimloop.chuckLeft() => limitingLeft;
cimloop.chuckRight() => limitingRight;
.5=>cimloop.setPan;
26=>cimloop.setMaxLoopNo;
//.3=>cimloop.setGain;

StereoRandLoop ashikoloop;
"ashiko"=>ashikoloop.read;
482634 => ashikoloop.setStartPos;
ashikoloop.chuckLeft() => limitingLeft;
ashikoloop.chuckRight() => limitingRight;
.5=>ashikoloop.setPan;
44=>ashikoloop.setMaxLoopNo;
//1.7=>ashikoloop.setGain;

StereoRandLoop mainloop;
"main"=>mainloop.read;
99594 => mainloop.setStartPos;
mainloop.chuckLeft() => limitingLeft;
mainloop.chuckRight() => limitingRight;
1.=>mainloop.setPan;
27=>mainloop.setMaxLoopNo;
mainloop.setGain(1.1, 5::ms);
bassloop.setRandPeriod(1, 8, 1./8.); 

StereoRandLoop furcsaloop;
"furcsa"=>furcsaloop.read;
194345 => furcsaloop.setStartPos;
furcsaloop.chuckLeft() => limitingLeft;
furcsaloop.chuckRight() => limitingRight;
1.=>furcsaloop.setPan;
22=>furcsaloop.setMaxLoopNo;
bassloop.setRandPeriod(1, 2, 1./6.); 
//.6=>furcsaloop.setGain;

StereoRandLoop szeploop;
"szep"=>szeploop.read;
353668 => szeploop.setStartPos;
szeploop.chuckLeft() => limitingLeft;
szeploop.chuckRight() => limitingRight;
1.=>szeploop.setPan;
10=>szeploop.setMaxLoopNo;
//.9=>szeploop.setGain;
16=>szeploop.setPeriodicity;
bassloop.setRandPeriod(1, 4, 1./4.); 

14=>Timer.advance;

1.7=>ashikoloop.setGain;

2=>Timer.advance;

.3=>cimloop.setGain;

16=>Timer.advance;

szeploop.setGain(.9, 5::ms);

46=>Timer.advance;

szeploop.setGain(0, 8::second);
2=>Timer.advance;
mainloop.setGain(0, 8::second);

16=>Timer.advance;

1.4=>bassloop.setGain;

16=>Timer.advance;

.6=>furcsaloop.setGain;

32=>Timer.advance;

szeploop.setGain(.9, 5::ms);

32=>Timer.advance;

mainloop.setGain(1.1, 5::ms);

48=>Timer.advance;

bassloop.setGain(0, 10::second);
cimloop.setGain(0, 10::second);
ashikoloop.setGain(0, 10::second);
mainloop.setGain(0, 10::second);
mainloop.setGain(0, 10::second);
furcsaloop.setGain(0, 10::second);
szeploop.setGain(0, 10::second);

10::second=>now;

aarec.exit();

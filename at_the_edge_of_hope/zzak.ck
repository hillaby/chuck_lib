1400::ms => AATimer.set_T;

spork~AARec.rec("At_the_edge_of_hope") @=> Shred aarec;

AATimer.start_at(0);

Gain mono => Gain limitingLeft => Gain gainLeft => Dyno dyLeft => dac.left;
mono => Gain limitingRight => Gain gainRight => Dyno dyRight => dac.right;

dyLeft.limit();
.65=>dyLeft.thresh;
.15=>dyLeft.slopeAbove;

.92=>limitingLeft.gain;
1=>gainLeft.gain;

dyRight.limit();
.65=>dyRight.thresh;
.15=>dyRight.slopeAbove;

.92=>limitingRight.gain;
1=>gainRight.gain;

//////////////////////////////////

MyFlute flute1;
MyFlute flute2;

Bass bass;
Guitar guitar;
Baterista drums;

SndBuf cym => mono;
"cymbal-ride-bell.wav" => cym.read;
cym.samples() => cym.pos;
1.5 => cym.gain;

flute2.set_what_to_play(1);

/////

Pan2 rightPan;
rightPan.left=>limitingLeft;
rightPan.right=>limitingRight;
rightPan.pan(-0.4);

Pan2 leftPan;
leftPan.left=>limitingLeft;
leftPan.right=>limitingRight;
leftPan.pan(0.4);


flute1.connect(rightPan);
flute2.connect(leftPan);
bass.connect(mono);
guitar.connect(mono);
drums.connectLeft(limitingLeft);
drums.connectRight(limitingRight);

drums.on(.4);

8=>AATimer.advance;

guitar.on(1);

8=>AATimer.advance;

bass.on(.7);

16.75=>AATimer.advance;
0=>cym.pos;
1.25=>AATimer.advance;

flute1.on(.5);
flute2.on(.3);

32.75=>AATimer.advance;

0=>cym.pos;
1.25=>AATimer.advance;

32.75=>AATimer.advance;

0=>cym.pos;
1.25=>AATimer.advance;

drums.off();
guitar.off();
bass.off();
flute1.off();
flute2.off();

aarec.exit();

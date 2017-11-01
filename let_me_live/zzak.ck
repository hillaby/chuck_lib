1200::ms=>AATimer.set_T;

//AATimer.start_at(145);
AATimer.start_at(0);
spork~AARec.rec("Let_me_live") @=> Shred aarec;

Gain mono => Gain limitingLeft => Gain gainLeft => Dyno dyLeft => dac.left;
mono => Gain limitingRight => Gain gainRight => Dyno dyRight => dac.right;

dyLeft.limit();
.65=>dyLeft.thresh;
.15=>dyLeft.slopeAbove;

.87=>limitingLeft.gain;
1=>gainLeft.gain;

dyRight.limit();
.65=>dyRight.thresh;
.15=>dyRight.slopeAbove;

.82=>limitingRight.gain;
1=>gainRight.gain;


Drums drums;
drums.connectLeft(limitingLeft);
drums.connectRight(limitingRight);

drums.set_what_to_play(2);
drums.on(.7);


Bass bass;
bass.connect(mono);


Piano piano;
piano.connectLeft(limitingLeft);
piano.connectRight(limitingRight);
piano.on(.35);

Lead lead;
lead.connectLeft(limitingLeft);
lead.connectRight(limitingRight);
//lead.on(1.3);

//440=>sin.freq;
//440=>sin.freq;

15=>AATimer.advance;

bass.on(.81);

7=>AATimer.advance;

drums.set_what_to_play(0);

9=>AATimer.advance;

lead.on(1.35);
33=>AATimer.advance;

31.5=>AATimer.advance;

lead.off();

SndBuf solo;// => /*Dyno comp =>*/
Chorus ch=>Echo e=>Pan2 pan;
e=>Gain fb=>e;
(AATimer.get_T()/8.0)=>e.delay;
.12=>fb.gain;
.2=>e.mix;
pan.left => limitingLeft;
pan.right => limitingRight;
/*
comp.limit();
0.1=>comp.thresh;
4=>comp.gain;*/

///////////////////// distort
// calculate abs()
solo => FullRect abs_s;

// calculate 1 + abs(source) to use as the divisor
abs_s => Gain divisor;
Step one => divisor;
1 => one.next;

// divide source by the divisor
solo => Gain division;
divisor => division;
4 => division.op;

// hear out. (try different gain)
2.5 => solo.gain;
division => ch;

////////////////////////////

1.2=>ch.gain;
.01=>ch.modDepth;
(8.0::second/AATimer.get_T())=>ch.modFreq;
.2=>ch.mix;

"let_me_live_solo.wav"=>solo.read;
373980=>solo.pos;



53.95=>AATimer.advance;

piano.set_what_to_play(1);
bass.set_what_to_play(1);
drums.set_what_to_play(1);
.05=>AATimer.advance;

//lead.on(1.3);
64=>AATimer.advance;

// sweep_out
for (1000 => int i; i > 750; i--)
{
    //<<<i / 10.0 => Std.dbtopow>>>;
    i / 10.0 => Std.dbtopow => gainLeft.gain;
    i / 10.0 => Std.dbtopow => gainRight.gain;
    .07::AATimer.get_T() => now;
}

aarec.exit();

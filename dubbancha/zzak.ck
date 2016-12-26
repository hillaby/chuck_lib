
1000::ms=>AATimer.set_T;

AATimer.start_at(0); // 72 fi di solo
spork~AARec.rec("Dubbancha") @=> Shred aarec;

Gain mono => Gain limitingLeft => Gain gainLeft => Dyno dyLeft => dac.left;
mono => Gain limitingRight => Gain gainRight => Dyno dyRight => dac.right;

dyLeft.limit();
.65=>dyLeft.thresh;
.15=>dyLeft.slopeAbove;

.7=>limitingLeft.gain;
.7=>gainLeft.gain;

dyRight.limit();
.65=>dyRight.thresh;
.15=>dyRight.slopeAbove;

.6=>limitingRight.gain;
.7=>gainRight.gain;

//######################################

Drums drums;
drums.connectLeft(limitingLeft);
drums.connectRight(limitingRight);

Bass bass;
bass.connect(mono);

Trumpets trumpets;
trumpets.connectLeft(limitingLeft);
trumpets.connectRight(limitingRight);

Saxes saxes;
saxes.connectLeft(limitingLeft);
saxes.connectRight(limitingRight);

Trombone trombone;
trombone.connectLeft(limitingLeft);
trombone.connectRight(limitingRight);

Piano piano;
piano.connectLeft(limitingLeft);
piano.connectRight(limitingRight);

////////////////////////////////////

SndBuf solo=>Chorus ch=>Echo e=>Pan2 pan;
e=>Gain fb=>e;
(AATimer.get_T()/8.0)=>e.delay;
.12=>fb.gain;
.2=>e.mix;
pan.left => limitingLeft;
pan.right => limitingRight;
0.3=>pan.pan;

1.4=>ch.gain;
.01=>ch.modDepth;
(8.0::second/AATimer.get_T())=>ch.modFreq;
.4=>ch.mix;

"dubbancha_solo-2.wav"=>solo.read;
solo.samples()=>solo.pos;




////////////////////////////////////

drums.on(1);

//while(true){1=>AATimer.advance;}

bass.on(.7);
//trumpets.on(.7);
//saxes.on(.7);
//trombone.on(.7);
piano.on(.7);

12=>AATimer.advance;

trombone.on(.7);

8=>AATimer.advance;

saxes.on(.7);

//36=>AATimer.advance;
20=>AATimer.advance;

trumpets.on(.5);

4=>AATimer.advance;

//solo.pos(204400); //////////////////////////////
//solo.pos(204900); //////////////////////////////
solo.pos(204800); //////////////////////////////
<<<"aaa">>>;

0=>solo.gain;

12=>AATimer.advance;

1=>solo.gain;

// 1:36 idáig
trumpets.off();
saxes.off();
trombone.off();

116=>AATimer.advance;

trombone.on(.7);

8=>AATimer.advance;

saxes.on(.7);

36=>AATimer.advance;

trumpets.on(.5);

32=>AATimer.advance;

// sweep_out
for (1000 => int i; i > 750; i--)
{
    //<<<i / 10.0 => Std.dbtopow>>>;
    i / 10.0 => Std.dbtopow => gainLeft.gain;
    i / 10.0 => Std.dbtopow => gainRight.gain;
    .07::AATimer.get_T() => now;
}

aarec.exit();


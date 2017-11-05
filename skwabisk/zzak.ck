1000::ms => AATimer.set_T;

AATimer.start_at(55);
//AATimer.start_at(180);

Drums drums;
Guitar guitar;
Guitar2 guitar2;
Bass bass;

spork~AARec.rec("Skwabisk") @=> Shred aarec;

Gain mono => Gain limitingLeft => Gain gainLeft => Dyno dyLeft => dac.left;
mono => Gain limitingRight => Gain gainRight => Dyno dyRight => dac.right;

dyLeft.limit();
.65=>dyLeft.thresh;
.15=>dyLeft.slopeAbove;

.62=>limitingLeft.gain;
1=>gainLeft.gain;

dyRight.limit();
.65=>dyRight.thresh;
.15=>dyRight.slopeAbove;

.85=>limitingRight.gain;
1=>gainRight.gain;

//######################################

drums.connectLeft(limitingLeft);
drums.connectRight(limitingRight);

guitar.connectLeft(limitingLeft);
guitar.connectRight(limitingRight);

guitar2.connectLeft(limitingLeft);
guitar2.connectRight(limitingRight);

bass.connect(mono);

guitar.set_what_to_play(1);
guitar2.set_what_to_play(1);
drums.set_what_to_play(1);
bass.set_what_to_play(1);

56=>AATimer.advance;

drums.on(.9);
guitar.on(.9);
guitar2.on(.9);
bass.on(.9);

7.95=>AATimer.advance;

guitar.set_what_to_play(0);
guitar2.set_what_to_play(0);
drums.set_what_to_play(0);
bass.set_what_to_play(0);

0.05=>AATimer.advance;

127.95=>AATimer.advance;

guitar.set_what_to_play(1);
guitar2.set_what_to_play(1);
drums.set_what_to_play(1);
bass.set_what_to_play(1);

7.7=>AATimer.advance;

// sweep_out
for (1000 => int i; i > 750; i--)
{
    //<<<i / 10.0 => Std.dbtopow>>>;
    i / 10.0 => Std.dbtopow => gainLeft.gain;
    i / 10.0 => Std.dbtopow => gainRight.gain;
    .0014=>AATimer.advance;
}

aarec.exit();

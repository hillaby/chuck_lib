900::ms => AATimer.set_T;

//AATimer.start_at(56);

Drums drums;
Guitar guitar;
Guitar2 guitar2;
Guitar3 guitar3;
Bass bass;

spork~AARec.rec("Seven_lives") @=> Shred aarec;

Gain mono => Gain limitingLeft => Gain gainLeft => Dyno dyLeft => dac.left;
mono => Gain limitingRight => Gain gainRight => Dyno dyRight => dac.right;

dyLeft.limit();
.65=>dyLeft.thresh;
.15=>dyLeft.slopeAbove;

.65=>limitingLeft.gain;
1=>gainLeft.gain;

dyRight.limit();
.65=>dyRight.thresh;
.15=>dyRight.slopeAbove;

.75=>limitingRight.gain;
1=>gainRight.gain;

//######################################

drums.connectLeft(limitingLeft);
drums.connectRight(limitingRight);

guitar.connectLeft(limitingLeft);
guitar.connectRight(limitingRight);

guitar2.connectLeft(limitingLeft);
guitar2.connectRight(limitingRight);

guitar3.connectLeft(limitingLeft);
guitar3.connectRight(limitingRight);

bass.connect(mono);

drums.on(.9);
guitar2.on(.9);

//21=>AATimer.advance;
27.45=>AATimer.advance;
0=>drums.set_what_to_play;
.55=>AATimer.advance;

guitar.on(.9);

27.5=>AATimer.advance;

bass.on(.9);

.5=>AATimer.advance;

21=>AATimer.advance;

guitar3.start(.9);

7=>AATimer.advance;

guitar2.off();
guitar3.on();

28=>AATimer.advance;

28=>AATimer.advance;

28=>AATimer.advance;

28=>AATimer.advance;

// sweep_out
for (1000 => int i; i > 750; i--)
{
    //<<<i / 10.0 => Std.dbtopow>>>;
    i / 10.0 => Std.dbtopow => gainLeft.gain;
    i / 10.0 => Std.dbtopow => gainRight.gain;
    .07=>AATimer.advance;
}

aarec.exit();

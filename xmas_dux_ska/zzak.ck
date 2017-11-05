1300::ms => AATimer.set_T;

//AATimer.start_at(20);

Horns horns;
Baterista drums;
Piano piano;
Bass bass;

spork~AARec.rec("Xmas_dux_ska") @=> Shred aarec;

Gain mono => Gain limitingLeft => Gain gainLeft => Dyno dyLeft => dac.left;
mono => Gain limitingRight => Gain gainRight => Dyno dyRight => dac.right;

dyLeft.limit();
.65=>dyLeft.thresh;
.15=>dyLeft.slopeAbove;

.75=>limitingLeft.gain;
1=>gainLeft.gain;

dyRight.limit();
.65=>dyRight.thresh;
.15=>dyRight.slopeAbove;

.75=>limitingRight.gain;
1=>gainRight.gain;

//######################################

horns.connectLeft(limitingLeft);
horns.connectRight(limitingRight);
drums.connectLeft(limitingLeft);
drums.connectRight(limitingRight);
piano.connectLeft(limitingLeft);
piano.connectRight(limitingRight);
bass.connect(mono);

drums.on(.9);

8=>AATimer.advance;
horns.trp_on(.6);

7.95=>AATimer.advance;

drums.set_what_to_play(1);

.05=>AATimer.advance;

horns.off();
piano.on(.7);

8=>AATimer.advance;
horns.sax_on(.6);

16=>AATimer.advance;

// bass+piano+drums
horns.off();

bass.on(.96);
8=>AATimer.advance;

// ++trumpet
horns.trp_on(.54);
horns.sax_on(.51);
16=>AATimer.advance;

// --sax
horns.off();
7.95=>AATimer.advance;

// drums.set_what_to_play(0);

drums.set_what_to_play(0);

.05=>AATimer.advance;

bass.off();
piano.off();

7.95=>AATimer.advance;

horns.set_what_to_play(1);
.05=>AATimer.advance;
horns.off();
horns.trp_on(.6);
7.95=>AATimer.advance;
bass.set_what_to_play(1);
drums.set_what_to_play(1);
.05=>AATimer.advance;

horns.trp_on(.50);
horns.sax_on(.49);
bass.on(.94);
piano.on(.7);

15.95=>AATimer.advance;

horns.set_what_to_play(0);
bass.set_what_to_play(0);

.05=>AATimer.advance;

horns.trp_on(.54);
horns.sax_on(.51);
bass.on(.96);

16=>AATimer.advance;

// sweep_out
for (1000 => int i; i > 750; i--)
{
    //<<<i / 10.0 => Std.dbtopow>>>;
    i / 10.0 => Std.dbtopow => gainLeft.gain;
    i / 10.0 => Std.dbtopow => gainRight.gain;
    .07=>AATimer.advance;
}

aarec.exit();

1050::ms=>AATimer.set_T;

//AATimer.start_at(145);
AATimer.start_at(40); // 72 = solo
spork~AARec.rec("Moonshine_reggae") @=> Shred aarec;

Gain mono => Gain limitingLeft => Gain gainLeft => Dyno dyLeft => dac.left;
mono => Gain limitingRight => Gain gainRight => Dyno dyRight => dac.right;

dyLeft.limit();
.65=>dyLeft.thresh;
.15=>dyLeft.slopeAbove;

.3=>limitingLeft.gain;
1=>gainLeft.gain;

dyRight.limit();
.65=>dyRight.thresh;
.15=>dyRight.slopeAbove;

.3=>limitingRight.gain;
1=>gainRight.gain;

//######################################

Drums drums;
drums.connectLeft(limitingLeft);
drums.connectRight(limitingRight);

Bass bass;
bass.connect(mono);
bass.set_what_to_play(1);


Piano piano;
piano.connectLeft(limitingLeft);
piano.connectRight(limitingRight);
piano.set_what_to_play(1);

Trombone trombone;
trombone.connectLeft(limitingLeft);
trombone.connectRight(limitingRight);

40=>AATimer.advance;
/*
SndBuf tres_l =>NRev nrl=>  limitingLeft;
SndBuf tres_r =>NRev nrr=>  limitingRight;

"tres_left.wav"=>tres_l.read;
"tres_right.wav"=>tres_r.read;

364500=>tres_l.pos;
364500=>tres_r.pos;

2=>tres_l.gain;
2=>tres_r.gain;
*/
/*Overdrive od_l;
od_l.setType(3);
od_l.drive(.7);*/
SndBuf ash_l /*=> od_l.chuck => *//* =>HPF ashlpf_l*/=>Envelope enl=>NRev nrl=>  limitingLeft;
"ashiko_left.wav"=>ash_l.read;
6.9=>ash_l.gain;

/*Overdrive od_r;
od_r.setType(3);
od_r.drive(.7);*/
SndBuf ash_r /*=> od_r.chuck =>*//*=>HPF ashlpf_r*/=>Envelope enr=>NRev nrr=>  limitingRight;
"ashiko_right.wav"=>ash_r.read;
6.9=>ash_r.gain;

.05=>nrr.mix;
.05=>nrl.mix;
/*
ashlpf_l.freq(1000);
ashlpf_l.Q(4);
ashlpf_r.freq(1000);
ashlpf_r.Q(4);*/

drums.on(1);

0.46=>AATimer.advance;

ash_l.pos(0);
ash_r.pos(0);


7.54=>AATimer.advance;


bass.on(.75);

.02=>AATimer.advance;

SndBuf tres_l => nrl;
SndBuf tres_r => nrr;

"tres_left.wav"=>tres_l.read;
"tres_right.wav"=>tres_r.read;

1.7=>tres_l.gain;
1.7=>tres_r.gain;

enl.target(1);
enr.target(1);

7.98=>AATimer.advance;
piano.on(.8);
7.95=>AATimer.advance;

piano.set_what_to_play(0);
bass.set_what_to_play(0);

0.05=>AATimer.advance;

trombone.on(.7);

128=>AATimer.advance;

// sweep_out
for (1000 => int i; i > 750; i--)
{
    //<<<i / 10.0 => Std.dbtopow>>>;
    i / 10.0 => Std.dbtopow => gainLeft.gain;
    i / 10.0 => Std.dbtopow => gainRight.gain;
    .07::AATimer.get_T() => now;
}

aarec.exit();

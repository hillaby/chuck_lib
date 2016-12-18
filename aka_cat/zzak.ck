// - stereo - KÉSZ
// - generikus sweep-in és out implementálása -> ADSR!
// - Magicba több magas felhang, karakteresebb vauvau - KÉSZ.
// - elhalkulás nem lineáris érzetre - KÉSZ.
// - basszusban slide up legyen ritkább - KÉSZ.
// - végén trumpet modulációt érdekesebbé - KÉSZ.
// - dob LPF egy kicsit magasabb freq - KÉSZ.
// - egész szám legyen hangosabb - KÉSZ (rec.ck).

1100::ms => AATimer.set_T;
AATimer.start_at(0);

Gain mono => Gain limitingLeft => Gain gainLeft => Dyno dyLeft => dac.left;
mono => Gain limitingRight => Gain gainRight => Dyno dyRight => dac.right;

dyLeft.limit();
.65=>dyLeft.thresh;
.15=>dyLeft.slopeAbove;

.97=>limitingLeft.gain;
1=>gainLeft.gain;

dyRight.limit();
.65=>dyRight.thresh;
.15=>dyRight.slopeAbove;

.97=>limitingRight.gain;
1=>gainRight.gain;

//######################################

Timbalero01 timbalero01;
timbalero01.connectLeft(limitingLeft);
timbalero01.connectRight(limitingRight);

Baterista01 baterista01;
//baterista01.connect(lpf);
baterista01.connectLeft(limitingLeft);
baterista01.connectRight(limitingRight);

Bajo01 bajo01;
bajo01.connect(mono);

Magic01 magic01;
magic01.connectLeft(limitingLeft);
magic01.connectRight(limitingRight);

Trumpets01 trumpets01;
trumpets01.connectLeft(limitingLeft);
trumpets01.connectRight(limitingRight);

Conguero01 conguero01;
conguero01.connectLeft(limitingLeft);
conguero01.connectRight(limitingRight);

Piano01 piano01;
piano01.connectLeft(limitingLeft);
piano01.connectRight(limitingRight);

spork~AARec.rec("Aka_cat") @=> Shred recsh;

trumpets01.on(.8);

//piano01.on(.8);

7.75=>AATimer.advance;

baterista01.on(.8);

//me.exit();

8=>AATimer.advance;

timbalero01.on(.8);

8=>AATimer.advance;

bajo01.on(.7);

8=>AATimer.advance;

magic01.sweep_in(.8);

16=>AATimer.advance;

conguero01.on(.9);

.2 => AATimer.advance;

trumpets01.set_what_to_play(1);

.05 => AATimer.advance;

trumpets01.modulate_trumpets();

16 => AATimer.advance;

conguero01.off();
piano01.on(.8);

16 => AATimer.advance;

///////////////////////

bajo01.off();
trumpets01.off();

8 => AATimer.advance;

piano01.off();

7.75 => AATimer.advance;

conguero01.on(.9);

.25 => AATimer.advance;

baterista01.off();

magic01.off();

7.75 => AATimer.advance;

bajo01.on(.7);

8.25 => AATimer.advance;

magic01.on(.8);

16 => AATimer.advance;

for (1000 => int i; i > 750; i--)
{
    //<<<i / 10.0 => Std.dbtopow>>>;
    i / 10.0 => Std.dbtopow => gainLeft.gain;
    i / 10.0 => Std.dbtopow => gainRight.gain;
    .07 => AATimer.advance;
}

recsh.exit();

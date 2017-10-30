700::ms=>Timer.set_T;
0=>Timer.start_at;

spork~Rec.rec("Gas_station") @=> Shred aarec;

Gain mono => Gain limitingLeft => NRev r1=> Gain gainLeft => Dyno dyLeft => dac.left;
mono => Gain limitingRight => NRev r2 => Gain gainRight => Dyno dyRight => dac.right;

r1.mix(.03);
r2.mix(.03);

dyLeft.limit();
.65=>dyLeft.thresh;
.15=>dyLeft.slopeAbove;

.15=>limitingLeft.gain;
.8=>gainLeft.gain;

dyRight.limit();
.65=>dyRight.thresh;
.15=>dyRight.slopeAbove;

.15=>limitingRight.gain;
.8=>gainRight.gain;

Drum drums;
drums.connectLeft(limitingLeft);
drums.connectRight(limitingRight);

/*drums.on(1);
Timer.advance(32);*/

Chords chs;
chs.connectLeft(limitingLeft);
chs.connectRight(limitingRight);


//piano.bowOn(2.5);
chs.bowOn(.25);

32=>Timer.advance;
//######################################
// play pluck theme
Overdrive od;
od.setType(3);
od.drive(.4);

StereoEcho ee;
ee.setDelay(.125,.3);
ee.setOnOffRate(1,.5);
SndBuf plk => od.chuck => HPF hpf =>  ADSR adsr => Chorus ch => /*Gain mul*/ LPF lpf => ee.chuck;

ee.getLeft() =>limitingLeft;
ee.getRight() =>limitingRight;
ch => Gain clean => lpf;
.2=>clean.gain;
plk => od.chuck => HPF hpf2 => adsr;

hpf2.gain(6);
4::second/Timer.get_T()=>ch.modFreq;
.6=>ch.gain;
.5=>ch.mix;
.02=>ch.modDepth;

//"gs_pluck_01.wav"=>plk.read;
"gs_pluck_02.wav"=>plk.read;
plk.gain(2.1);
adsr.set(20::ms, 20::ms, 1., .1*Timer.get_T());
adsr.keyOff(1);
fun void pluck() {
	//.1=>Timer.advance;
	while(1){
		//5400=>plk.pos;

		5800=>plk.pos;
		//5900=>plk.pos;

		//5312=>plk.pos;
		adsr.keyOn(1);
		63.9=>Timer.advance;
		adsr.keyOff(1);
		.1=>Timer.advance;
	}
}

Overdrive oo ;
oo.drive(.9);
oo.setType(3);
SinOsc filterSWP => oo.chuck => blackhole;
.5::second/Timer.get_T()=>filterSWP.freq;
.8=>filterSWP.phase;
fun void sweepFilters() {
	1::samp=>now;
	while(1) {
		1700+filterSWP.last()* 1400 => hpf.freq;
		6700+filterSWP.last()* 1000 => hpf2.freq;
		7700+filterSWP.last()* 7000 => lpf.freq; <<<lpf.freq()>>>;
		.04=>Timer.advance;
	}
}
spork~sweepFilters() @=> Shred swf;

//spork~pluck();
//Timer.advance(32);
//######################################

chs.bowOn(.2);
spork~pluck() @=> Shred plck;
/*Drum drums;
drums.connectLeft(limitingLeft);
drums.connectRight(limitingRight);
*/
Timer.advance(29.9);
//mm.phase(0);


//drums.on(1);

drums.on(1);
drums.bassOff();
drums.hhOff();

Timer.advance(2);

drums.bassOn();
drums.hhOn();
chs.marOn(.8);
plk.gain(1.4);

Timer.advance(.1);

Bass bass;
bass.connect(mono);


chs.bowOn(.18);

Timer.advance(31.9);




bass.on(2.2);
chs.marOn(1.3);
plk.gain(.5);
Timer.advance(.1);

Theme trp;
trp.connectLeft(limitingLeft);
trp.connectRight(limitingRight);

chs.bowOn(.16);

Timer.advance(31.9);

trp.on(1);
chs.marOn(1.7);
plk.gain(0);

swf.exit();
plck.exit();


Timer.advance(.1);

Timer.advance(31.9);

chs.marOn(1.3);
chs.quartetOn(.7);
Timer.advance(.1);
Timer.advance(31.9);

chs.marOn(1);
chs.quartetOn(1.4);

Timer.advance(.1);
Timer.advance(32);

// sweep_out
for (1000 => int i; i > 750; i--)
{
    //<<<i / 10.0 => Std.dbtopow>>>;
    i / 10.0 => Std.dbtopow => gainLeft.gain;
    i / 10.0 => Std.dbtopow => gainRight.gain;
    .07::Timer.get_T() => now;
}

aarec.exit();

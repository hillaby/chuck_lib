Gain limitingLeft => Envelope e1 => NRev r1 => Dyno dyLeft => dac.left;
Gain limitingRight => Envelope e2 => NRev r2 => Dyno dyRight => dac.right;

dyLeft.limit();
.65=>dyLeft.thresh;
.15=>dyLeft.slopeAbove;

.36=>limitingLeft.gain;

dyRight.limit();
.65=>dyRight.thresh;
.15=>dyRight.slopeAbove;

.36=>limitingRight.gain;

.04=>r1.mix;
.04=>r2.mix;

minute/130.0 => Timer.set_T;

12::second=>e1.duration;
12::second=>e2.duration;


spork~Rec.rec("test") @=> Shred rec;

Pan2 mono;
mono.left => limitingLeft;
mono.right => limitingRight;
/*
SndBuf b =>mono;
"01.wav"=>b.read;
fun void lll() {
	while(1) {
		0=>b.pos;
		
		b.samples()::samp=>now;
	}
}*/
//spork~lll();

SndBuf cb => mono;
.3=>cb.gain;
"../lib/instruments/s_cowbell/Cowbel Velo01  Funk.wav" => cb.read;
fun void ccc() {
	while(1) {
		0=>cb.pos;
		Timer.advance(1);
	}
}
spork~ccc();

TriBass b;
.8=>b.setGain;
b.chuck() => mono;
fun void bass() {
	while(1)
	{
		Timer.advance(2);
		b.note("c", 2, 1);
		b.note("d", 2, 1);
		Timer.advance(1.5);
		b.note("c", 2, 1.5);
		b.note("g", 1, 1);
	}
}
spork ~ bass();

RandPan pan;
pan.getLeft() => limitingLeft;
pan.getRight() => limitingRight;

RandLPF lpf;

RMSRandLoop loop3;
1=>loop3.setGain;
loop3.chuck() => lpf.chuck => pan.chuck;
21=>loop3.setMaxLoopNo;

loop3.setSilenceArr(SA_01.get());
1=>loop3.setGain;

"01.wav"=>loop3.read;

RandPan pan2;
pan2.getLeft() => limitingLeft;
pan2.getRight() => limitingRight;

RandLPF lpf2;

RMSRandLoop loop4;
1=>loop4.setGain;
loop4.chuck() => lpf2.chuck => pan2.chuck;
21=>loop4.setMaxLoopNo;

loop4.setSilenceArr(SA_01.get());
1=>loop4.setGain;

"01.wav"=>loop4.read;

1.=>e1.target;
1.=>e2.target;

3::minute=>now;

0.=>e1.target;
0.=>e2.target;

e1.duration()=>now;

rec.exit();


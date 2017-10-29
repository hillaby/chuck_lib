public class TalkingBass extends Instrument {

	BlitSquare bass=>LPF lpf=>/*HPF hpf=>*/Chorus ch=>ADSR adsr=>output;
	bass=>HPF hpf=>LPF lpf2=>ch;
	hpf.gain(1);
	lpf2.gain(1);
	bass.gain(.7);
	lpf.gain(1.2);
	SinOsc subbass=>adsr;
	subbass.gain(1);
	Phasor b => Gen10 g10=> adsr;
	g10.coefs( [1.0, 1.5, 0.3, 1.5, 0.3, 0.4, 0.1, 0.3, 0.1] );
	//b.bodySize(200);
	b.gain(1.0);

	ch.modFreq(8::second/Timer.get_T());
	ch.modDepth(.01);

	adsr.set(.00::Timer.get_T(), .03::Timer.get_T(), .9, 0::second);
	adsr.keyOff();

	public void sweepFilters(float d) {
		20=>int steps;
		for (0=>int i; i < steps; i++) {
			Std.ftom(bass.freq()) + i*5 => Std.mtof => float fr;
			//<<<fr>>>;
			hpf.freq(fr-10);
			lpf2.freq(fr+100);
			lpf.freq(fr+10);
			Timer.advance(d*.3/steps);
			//<<<startFreqLPF-i*((startFreqLPF-bass.freq())/steps)>>>;
		}
		for (steps-1=>int i; i >= 0; i--) {
			Std.ftom(bass.freq()) + i*5 => Std.mtof => float fr;
			//<<<fr>>>;
			hpf.freq(fr-10);
			lpf2.freq(fr+100);
			lpf.freq(fr+10);
			Timer.advance(d*.7/steps);
			//<<<startFreqLPF-i*((startFreqLPF-bass.freq())/steps)>>>;
		}
		//bpf.freq(bass.freq());
		//lpf.freq(bass.freq());
		//<<<bpf.freq(), bass.freq()>>>;
	}

	public void note(float n, float d) {

		adsr.attackTime(d*.07*Timer.get_T());
		adsr.decayTime(d*.3*Timer.get_T());
		adsr.releaseTime(d*.3*Timer.get_T());

		n => Std.mtof => bass.freq;
		spork~sweepFilters(.5*d);
		n-12=> Std.mtof => subbass.freq;
		n=> Std.mtof => b.freq;
		//b.noteOn(1);
		Timer.advance(.0*d);
		adsr.keyOn(1);


		Timer.advance(.6*d);
		adsr.keyOff(1);

		Timer.advance(.4*d);
	}
}

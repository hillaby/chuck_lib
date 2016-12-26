// sounds funny

public class DentalDrill extends Instrument {

	FMVoices moog=> BPF lpf => Chorus ch => ADSR adsr => output;
	moog => Gain g=> ch;
	g.gain(.7);
	moog.gain(1.2);
	
	ch.modFreq(16::second/Timer.get_T());
	ch.modDepth(.001);
	
	//lpf.freq(500);
	lpf.Q(5);
	
	adsr.set(0::second, .3::Timer.get_T(), .8, .3::Timer.get_T()); 
	adsr.keyOff();
	
	public void sweep_lpf(float d) {
		50=>int steps;
		for (0=>int i; i < steps; i++) {
			//<<<i,20000-i*(19900/steps)>>>;
			lpf.freq(1000+i*(13000/steps));
			Timer.advance(.2*d/steps);
		} 
		//Timer.advance(.3*d);
		for (0=>int i; i < steps; i++) {
			//<<<i,20000-i*(19900/steps)>>>;
			lpf.freq(14000-i*(13000/steps));
			Timer.advance(.6*d/steps);
		} 		
	}
	
	public void note(float n, float d) {
		adsr.attackTime(.05*Timer.get_T());
		adsr.decayTime(.1*Timer.get_T());
		adsr.releaseTime(.3*Timer.get_T());
		n => Std.mtof => moog.freq;
		
		moog.vowel(.9);
		moog.spectralTilt(.4);
		moog.noteOn(1);
		adsr.keyOn();
		
		spork~sweep_lpf(d);
		
		Timer.advance(d*.8);
		moog.noteOff(1);
		adsr.keyOff();
		
		Timer.advance(d*.2);
	}
	
}


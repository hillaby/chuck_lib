// triangle wave bass

public class TriBass extends Instrument {

	TriOsc bass=>Chorus ch=>ADSR adsr=> output;
	bass.gain(1.8);
	SinOsc subbass=>adsr;
	subbass.gain(1);
	
	ch.modFreq(8::second/Timer.get_T());
	ch.modDepth(.01);
	
	adsr.set(.00::Timer.get_T(), .03::Timer.get_T(), .5, 0::second); 
	adsr.keyOff();

	// plays a note for duration d
	public void note(float n, float d) {
		adsr.attackTime(d*.01*Timer.get_T());
		adsr.decayTime(d*.2*Timer.get_T());
		adsr.releaseTime(d*.3*Timer.get_T());

		n => Std.mtof => bass.freq;
		n-12=> Std.mtof => subbass.freq;
		adsr.keyOn(1);
		

		Timer.advance(.7*d);
		adsr.keyOff(1);

		Timer.advance(.3*d);
	}
}


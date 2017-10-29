public class Tom extends Instrument {
	
	SinOsc sin => ADSR sinadsr => /*NRev rev=>*/ output;
	.22=>sin.gain;
	//100=>sin.freq;
	
	Step step => Envelope freqEnv => sin; // => sin.freq
	Step dc_component => sin;
	80=>step.next;
	200=>dc_component.next;

	ModalBar sin2 => sinadsr;
	sin2.freq(160);
	sin2.gain(5);
	sin2.preset(6);
	
	//rev.mix(.01);
	
	Noise noz => LPF lpf => ADSR adsr /*=>rev*/=> output;
	.1=>noz.gain;
	
	adsr.set(.00::Timer.get_T(), .03::Timer.get_T(), .0, .04::Timer.get_T()); 
	adsr.keyOff();
	
	sinadsr.set(.00::Timer.get_T(), .03::Timer.get_T(), 0, .04::Timer.get_T()); 
	sinadsr.keyOff();
	
	public void note(float dur) {
		dur*.5*Timer.get_T()=>freqEnv.duration;

		sinadsr.decayTime(dur*.5*Timer.get_T());
		sinadsr.releaseTime(dur*.5*Timer.get_T());

		adsr.decayTime(dur*.05*Timer.get_T());
		adsr.releaseTime(dur*.95*Timer.get_T());

		1.0=>freqEnv.value;
		3000+(Std.randf()*200)=>lpf.freq;
		freqEnv.keyOff();
		adsr.keyOn();
		sinadsr.keyOn();

		sin2.strike(1);

		Timer.advance(dur*.5);
		adsr.keyOff();
		sinadsr.keyOff();
		Timer.advance(dur*.5);
		
	}
	
	public void hit() {
		spork~this.note(.25);
	}
	
	public void note(float n, float d) { <-- n-et nem használjuk :)
		this.note(d);
	}
}

// a very basic bass drum

public class BassDrum extends Instrument {
	
	SinOsc sin => ADSR sinadsr => output;
	1.3=>sin.gain;
	//100=>sin.freq;
	
	Step step => Envelope freqEnv => sin; // => sin.freq
	Step dc_component => sin;
	80=>step.next;
	20=>dc_component.next;
	
	Noise noz => LPF lpf => ADSR adsr => output;
	.07=>noz.gain;
	
	adsr.set(.00::Timer.get_T(), .03::Timer.get_T(), 0, .04::Timer.get_T()); 
	adsr.keyOff();
	
	sinadsr.set(.00::Timer.get_T(), .03::Timer.get_T(), 0, .04::Timer.get_T()); 
	sinadsr.keyOff();

	public void hit() {
		spork~this.note(.25);
	}
	
	public void note(float n, float d) { <-- we don't use n :)
		this.note(d);
	}	
	
	public void note(float dur) {
		dur*.4*Timer.get_T()=>freqEnv.duration;

		sinadsr.decayTime(dur*.4*Timer.get_T());
		sinadsr.releaseTime(dur*.6*Timer.get_T());

		adsr.decayTime(dur*.25*Timer.get_T());
		adsr.releaseTime(dur*.75*Timer.get_T());

		1.0=>freqEnv.value;
		3000+(Std.randf()*200)=>lpf.freq;
		freqEnv.keyOff();
		adsr.keyOn();
		sinadsr.keyOn();
		Timer.advance(dur*.3);
		adsr.keyOff();
		sinadsr.keyOff();
		Timer.advance(dur*.7);
	}
	
}

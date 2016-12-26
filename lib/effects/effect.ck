// base class for all Effects

public class Effect {

	Gain input;
	Gain output;
	
	// connects
	public UGen chuck(UGen @ u){
		u => input;
		return output;
	}
	
	// sets gain
	public void setGain(float g) {
		g => output.gain;
	}
}

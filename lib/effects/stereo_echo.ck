// a stereo echo effect

public class StereoEcho extends StereoEffect {
	SqrOsc rightLFO => Gain sumR => Gain mulR => outputRight;
	SqrOsc leftLFO => Gain sumL => Gain mulL => outputLeft;

	3 => mulR.op => mulL.op;

	0. => float offRate;
	1. => float onRate;
	Step ctR => sumR;
	Step ctL => sumL;
	setOnOffRate(1., 0.);

	input => Gain g => mulL;
	g => mulR;
	g => Delay delay => input;

	setDelay(.25, .4);

	// sets on/off rate
	public void setOnOffRate(float onR, float offR) {
		onR => onRate;
		offR => offRate;

		(onRate + offRate) / 2. => ctR.next;
		(onRate - offRate) / 2. => rightLFO.gain;


		(onRate + offRate) / 2.=> ctL.next;
		(onRate - offRate) / 2.=> leftLFO.gain;
	}

	// sets delay
	public void setDelay(float d, float g) {
		g=>delay.gain;
		d*Timer.get_T() => delay.delay;
		16*delay.delay() => delay.max;
		1::second/(2.*d*Timer.get_T()) => rightLFO.freq;
		rightLFO.freq() => leftLFO.freq;
		resetPhase();
	}

	// resets phase
	public void resetPhase() {
		0 => leftLFO.phase;
		.5 => rightLFO.phase;
	}
}

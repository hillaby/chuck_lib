// strings synth

public class BowedString extends Instrument {
	Bowed b => Gain g => ADSR adsr => NRev rev => output;
	.01=>rev.mix;
	1.5=>rev.gain;
	
	3=>g.op;
	SinOsc mod => Gain sum => g;
	Step dc => sum;
	.9 => dc.next;
	mod.gain(.09);
	mod.freq(4::second/Timer.get_T());
	
	4::second/Timer.get_T()=>b.vibratoFreq;
	
	
	g => LPF lpf => adsr;
	
	
	0=>int octave;
	
	// sets octave
	public void setOctave(int oct) {
		oct => octave;
	}
	
	// plays a note
	public void note(float n, float d, int legato/*bits: 0-no, 1-from_here, 2-to-here*/) {
		n=>curNote;
		n+(octave*12)=>Std.mtof=>b.freq;
		<<<"note... ", b.freq(), legato>>>;
		
		b.freq() * Std.rand2f(.999, 1.001) => b.freq;
		
		.02 + b.freq()/200000.=>b.vibratoGain;
		.09 + b.freq()/70000.=>mod.gain;
		
		1./(b.freq()/800.+1.)=>b.gain;
		
		300. + .35*b.freq() => float calcdF;
		calcdF => lpf.freq;
		10./(b.freq()/100.+1.)=>lpf.gain;
		/**(1.+b.freq()/10000.)*/ 
		<<<"LPF:", lpf.freq()>>>;
		
		d*(.1 - (b.freq() $ float / 300000.))::Timer.get_T()=>adsr.attackTime;
		d*.05::Timer.get_T()=>adsr.decayTime;
		.9=>adsr.sustainLevel;
		d*.1::Timer.get_T()=>adsr.releaseTime;
		/*if (b.freq() < 400) {
			.2 + ((40./50.)*b.freq() $ float / 1000.) => b.bowPosition;
		} else {
			.7 => b.bowPosition;
		}*/
		if (b.freq() < 1600) {
			.3 + ((15./160.)*b.freq() $ float / 1000.) => b.bowPosition;
		} else {
			.45 => b.bowPosition;
		}
		
		b.bowPosition() * Std.rand2f(.98, 1.02) => b.bowPosition;
		Std.rand2f(.92, .94) =>b.bowPressure;

		if ((legato & 2) == 0) {
			b.noteOn(1);	
			adsr.keyOn();
		}
		/*
		HidIn hi;
		hi.openMouse(0);
		//SinOsc fff =>Gain mu2l=> dac;

		//b.freq()=>fff.freq;
		//.2=>fff.gain;
		while (1) {
			
			hi => now;
			hi.recv(HidMsg msg);
			if (msg.isButtonDown()) {
				<<<"brk: ", b.freq(), b.bowPosition(), b.bowPressure()>>>;
				break;
			}
			b.bowPosition() + msg.deltaX/1000. => b.bowPosition;
			b.bowPressure() + msg.deltaY/1000. => b.bowPressure;
			<<<b.freq(), b.bowPosition(), b.bowPressure()>>>;
		}
		//fff=<dac;
		*/
		<<<"brk: ", b.freq(), b.bowPosition(), b.bowPressure()>>>;
		.9*d=>Timer.advance;
		if ((legato & 1) == 0) {
			adsr.keyOff();
		}
		.1*d=>Timer.advance;
		if ((legato & 1) == 0) {
			b.noteOff(1);
		}
	}
}

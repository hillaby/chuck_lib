public class STalkingBass extends Instrument {
	SndBuf smpl => ADSR adsr => output;
	"../lib/instruments/s_talking_bass/TB3 Bass 08.wav" => smpl.read;
	adsr.set(0::ms, 0::ms, 1., 0::ms);
	adsr.keyOff(1);
	1=>adsr.gain;
	public void note(float d) {
		.2*d*Timer.get_T()=>adsr.releaseTime;
		0=>smpl.pos;
		adsr.keyOn(1);
		.8*d=>Timer.advance;
		adsr.keyOff(1);
		.2*d=>Timer.advance;
	}
	public void note(float n, float d, int legato) {
		.2*d*Timer.get_T()=>adsr.releaseTime;

		n=>Std.mtof=>float fre;

		fre/65.4063915=> smpl.rate;

		if ((legato&2) == 0) {
			0=>smpl.pos;
			//env.keyOn(1);
			adsr.keyOn(1);
		}

		.7*d=>Timer.advance;
		if ((legato&1) == 0) {
			adsr.keyOff(1);
		}
		.3*d-.05=>Timer.advance;
		//env.keyOff(1);
		.05=>Timer.advance;
	}
}

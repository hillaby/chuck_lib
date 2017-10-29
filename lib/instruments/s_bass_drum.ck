public class SBassDrum extends Instrument {
	SndBuf smpl => ADSR adsr => output;
	"../lib/instruments/s_bass_drum/BDRUM2.wav" => smpl.read;
	adsr.set(0::ms, 0::ms, 1., 0::ms);
	adsr.keyOff(1);
	2.5=>adsr.gain;
	public void note(float d) {
		.2*d*Timer.get_T()=>adsr.releaseTime;
		0=>smpl.pos;
		adsr.keyOn(1);
		.8*d=>Timer.advance;
		adsr.keyOff(1);
		.2*d=>Timer.advance;
	}
	public void hit() {
		0=>smpl.pos;
		adsr.keyOn(1);
	}
}

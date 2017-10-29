public class SAggressiveSnare extends Instrument {
	SndBuf smpl => ADSR adsr => output;
	
	adsr.set(10::ms, 0::ms, 1., 0::ms);
	adsr.keyOff(1);
	
	//"../lib/instruments/s_aggressive_snare/SNARE10.wav" => smpl.read;
	
	"../lib/instruments/s_aggressive_snare/RX5 SD 3.wav" => smpl.read;
	adsr.gain(2.1);
	1448=>int startPos;

	public void note(float d) {
		.2*d*Timer.get_T()=>adsr.releaseTime;
		startPos=>smpl.pos;
		adsr.keyOn(1);
		.8*d=>Timer.advance;
		adsr.keyOff(1);
		.2*d=>Timer.advance;
	}
	public void hit() {
		startPos=>smpl.pos;
		adsr.keyOn(1);
	}
}
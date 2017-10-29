public class SHiHat extends Instrument {
	SndBuf smpl_closed => ADSR adsr => output;
	SndBuf smpl_open => adsr;
	"../lib/instruments/s_hihat/cymbal-hihat-stick.wav" => smpl_closed.read;
	adsr.set(0::ms, 0::ms, 1., 0::ms);
	adsr.keyOff(1);
	
	"../lib/instruments/s_hihat/cymbal-hihat-open-stick-2.wav" => smpl_open.read;
	
	smpl_open.samples() => smpl_open.pos;
	smpl_closed.samples() => smpl_closed.pos;
	
	1.1=>adsr.gain;
	public void closedNote(float d) {
		.2*d*Timer.get_T()=>adsr.releaseTime;
		0=>smpl_closed.pos;
		adsr.keyOn(1);
		.8*d=>Timer.advance;
		adsr.keyOff(1);
		.2*d=>Timer.advance;
	}
	public void hit() {
		0=>smpl_closed.pos;
		adsr.keyOn(1);
	}
	public void openNote(float d) {
		.2*d*Timer.get_T()=>adsr.releaseTime;
		0=>smpl_open.pos;
		adsr.keyOn(1);
		.8*d=>Timer.advance;
		adsr.keyOff(1);
		.2*d=>Timer.advance;
	}
}

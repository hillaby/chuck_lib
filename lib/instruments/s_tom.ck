public class STom extends Instrument {
	SndBuf smpl[3];
	ADSR adsr[3];
	for (0 => int i; i < smpl.cap(); i++) {
		smpl[i]=> adsr[i] => output;
		adsr[i].set(0::ms, 0::ms, 1., 0::ms);
		adsr[i].keyOff(1);
		1.4=>adsr[i].gain;
	}
	
	"../lib/instruments/s_tom/RX5 TOM 1.wav" => smpl[0].read;
	"../lib/instruments/s_tom/RX5 TOM 2.wav" => smpl[1].read;
	"../lib/instruments/s_tom/RX5 TOM 3.wav" => smpl[2].read;
	//"../lib/instruments/s_tom/drum-tom-hi-tap.wav" => smpl_1.read;

	public void nnote(int i, float d) {
		.2*d*Timer.get_T()=>adsr[i].releaseTime;
		0=>smpl[i].pos;
		adsr[i].keyOn(1);
		.8*d=>Timer.advance;
		adsr[i].keyOff(1);
		.2*d=>Timer.advance;
	}
	public void note(float d) {
		this.note(0, d);
	}	
	public void hit() {
		0=>smpl[0].pos;
		adsr[0].keyOn(1);
	}
}

public class SBowedGlass extends Instrument {
	Overdrive  od;
	3 => od.setType;
	SndBuf smpl =>  od.chuck => ADSR env => ADSR adsr  => NRev r => output;

	r.mix(.5);
	//SinOsc tmp => adsr;
	//.1=>tmp.gain;

	.5=>adsr.gain;

	"../lib/instruments/s_bowed_glass/bowedGlass 3.wav" => smpl.read;
	adsr.set(0::ms, 0::ms, 1., 0::ms);
	adsr.keyOff(1);

	env.set(.01*Timer.get_T(), .05*Timer.get_T(), 1., .01*Timer.get_T());
	env.keyOff(1);
	.6=>adsr.gain;
	.7*Timer.get_T()=>adsr.releaseTime;
	.3*Timer.get_T()=>adsr.attackTime;

	// n - note, d - duration
	public void note(float n, float d, int legato) {
		//.3*d*Timer.get_T()=>adsr.releaseTime;
		if (d < .7) {
			<<<"!!!!!!!!!!!!!!!!!!!!! d < .7">>>;
		}

		Std.rand2f(.3,.7) => adsr.gain;
		Std.rand2f(.3,.5) => od.drive;

		n=>Std.mtof=>float fre;

		fre/1919.6 => smpl.rate;

		if ((legato&2) == 0) {
			5000=>smpl.pos;
			env.keyOn(1);
			adsr.keyOn(1);
		}

		.7*d=>Timer.advance;
		if ((legato&1) == 0) {
			adsr.keyOff(1);
		}
		.3*d-.05=>Timer.advance;
		env.keyOff(1);
		.05=>Timer.advance;
	}
}

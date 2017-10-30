public class SMarimba extends Instrument {
	SndBuf smpl[11];
	ADSR adsr => output;
	"../lib/instruments/s_marimba/MarimbaHardC2.wav" => smpl[0].read;
	"../lib/instruments/s_marimba/MarimbaHardG2.wav" => smpl[1].read;
	"../lib/instruments/s_marimba/MarimbaHardC3.wav" => smpl[2].read;
	"../lib/instruments/s_marimba/MarimbaHardG3.wav" => smpl[3].read;
	"../lib/instruments/s_marimba/MarimbaHardC4.wav" => smpl[4].read;
	"../lib/instruments/s_marimba/MarimbaHardG4.wav" => smpl[5].read;
	"../lib/instruments/s_marimba/MarimbaHardC5.wav" => smpl[6].read;
	"../lib/instruments/s_marimba/MarimbaHardG5.wav" => smpl[7].read;
	"../lib/instruments/s_marimba/MarimbaHardC6.wav" => smpl[8].read;
	"../lib/instruments/s_marimba/MarimbaHardG6.wav" => smpl[9].read;
	"../lib/instruments/s_marimba/MarimbaHardC7.wav" => smpl[10].read;
	for (0=>int i; i<smpl.cap(); i++) {
		smpl[i]=>adsr;
		smpl[i].samples() => smpl[i].pos;
	}

	adsr.set(0::ms, 0::ms, 1., 0::ms);
	adsr.keyOff(1);
	1=>adsr.gain;

	float notes[11];
	getNote("c",2)=>notes[0];
	getNote("g",2)=>notes[1];
	getNote("c",3)=>notes[2];
	getNote("g",3)=>notes[3];
	getNote("c",4)=>notes[4];
	getNote("g",4)=>notes[5];
	getNote("c",5)=>notes[6];
	getNote("g",5)=>notes[7];
	getNote("c",6)=>notes[8];
	getNote("g",6)=>notes[9];
	getNote("c",7)=>notes[10];

	float limits[10];
	for (0=>int i;i<notes.cap()-1;i++) {
		(notes[i]+notes[i+1])/2.=>limits[i];
		//<<<limits[i]>>>;
	}

	[4960,3770,3460,2580,2380,2000,2300,2630,1980,1520,1330] @=> int posses[];


	public void note(float n, float d, int legato) {
		.3*d*Timer.get_T()=>adsr.releaseTime;
		n=>Std.mtof=>float fre;
		int curSND;
		for (0=>curSND; curSND < smpl.cap(); curSND++) {
			if (curSND == smpl.cap()-1) {
				break;
			}
			if (n < limits[curSND]) {
				break;
			}
		}

		//<<<n, curSND>>>;

		fre/Std.mtof(notes[curSND])=> smpl[curSND].rate;

		posses[curSND]=>smpl[curSND].pos;

		adsr.keyOn(1);

		.7*d=>Timer.advance;
		adsr.keyOff(1);
		.3*d=>Timer.advance;
	}
}

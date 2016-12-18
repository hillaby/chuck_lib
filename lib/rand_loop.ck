// switches between different versions of the same recorded loop
// at random positions
// 
// The loop is recorded in the same .wav file many times (these are the versions)
// and at random times another version will be played.
//
// DO NOT FORGET TO SET --srate TO THE SAMPLE RATE OF THE RECORDED LOOPS!

public class RandLoop {
	Envelope g_env;
	
	50::ms => dur defDur;
	g_env.duration(defDur);
	
	// sets gain
	public void setGain(float g) {
		setGain(g, defDur);
	}
	
	// sets gain with smooth change (slope duration is d)
	public void setGain(float g, dur d) {
		g_env.duration(d);
		g=>g_env.target;
	}
	
	0 => int period;
	setPeriodicity(8);

	SndBuf buf[2];
	ADSR bar[2];

	buf[0] => bar[0] => g_env;
	bar[0].set(10::ms, 0::samp, 1., 10::ms);
	buf[1] =>bar[1] => g_env;
	bar[1].set(10::ms, 0::samp, 1., 10::ms);

	// can be used for connecting
	public UGen chuck() {
		return g_env;
	}

	// reads in the loops from filename
	public void read(string filename) {
		filename + ".wav" => buf[0].read;
		filename + ".wav" => buf[1].read;
	}
	
	// sets the periodicity of the loops
	public void setPeriodicity(int p) {
		Math.floor( Timer.get_T() * p / samp ) $ int => period;
		//<<<(1::second / 1::samp)>>>;
		//Machine.crash();
	}

	0=>int bufStartPos;

	// sets starting position
	public void setStartPos(int s) {
		s=>bufStartPos;
	}

	0=>int maxLoopNo;

	// sets the number of different versions in the same .wav
	public void setMaxLoopNo(int m) {
		m=>maxLoopNo;
	}
	
	1=>int minPeriod;
	16=>int maxPeriod;
	1./16. => float granularity; 

	// sets random period:
	// - min is the minimum period size
	// - max is the maximum period size
	// - gran is the granularity
	public void setRandPeriod(int min, int max, float gran) {
		min=>minPeriod;
		max=>maxPeriod;
		gran => granularity;
	}

	// endless loop that changes the loop versions
	public void changeBuf() {
		0 => int changePos;
		0 => int curBuf;
		bufStartPos=>buf[curBuf].pos;
		while (1) {
			//<<<maxLoopNo>>>;
			0 => int curPos;
			if (0) { // TRY::::
				bufStartPos + (/*Std.rand2(0, maxLoopNo)*/maxLoopNo * period) + ((buf[curBuf].pos()-bufStartPos) % period) => curPos;
				//<<<"c:",bufStartPos, curPos, maxLoopNo, period, buf_left[curBuf].pos()>>>;
				if (curPos > buf[(curBuf+1)%2].samples()) {
					<<<"toomuch">>>;
					Machine.crash();
				}
			} else {
				bufStartPos + (Std.rand2(0, maxLoopNo) * period) + ((buf[curBuf].pos()-bufStartPos) % period) => curPos;
			}
			curPos => buf[(curBuf+1)%2].pos;
			bar[curBuf].keyOff(1);
			bar[(curBuf+1)%2].keyOn(1);
			Math.floor( Std.rand2(minPeriod, maxPeriod) * granularity * period ) $ int => changePos;
			<<<changePos>>>;
			(curBuf+1)%2=>curBuf;
			changePos::samp => now;
		}
	}

	spork ~ changeBuf();
}

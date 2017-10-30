// it switches between different "versions" of the same loop.
// Switches are done only if there is silence, so the switches
// cannot be heard. Very useful for generating infinite variations
// of the same solo e.g.

public class RMSRandLoop {
	Envelope gain;

	30::ms => dur defDur;
	30::ms => dur maxRelease;
	<<<"defDur:", defDur/samp, "samples">>>;
	gain.duration(defDur);

	// sets gain
	public void setGain(float g) {
		setGain(g, defDur);
	}

	// sets gain with a slope of duration d
	public void setGain(float g, dur d) {
		gain.duration(d);
		g=>gain.target;
	}

	0 => int period;
	setPeriodicity(8);

	SndBuf buf;
	Envelope buf_env;
	defDur=>buf_env.duration;

	buf => buf_env => gain;

	// can be used for connecting
	public UGen chuck() {
		return gain;
	}

	// pre-analyzes the wav file for "moments of silence", when the versions can be switched.
	public static void analyze(string filename) {
		SndBuf buf => FFT fft =^ RMS rms => blackhole;
		filename + ".wav" => buf.read;

		1024 => int fftSize;
		fftSize => fft.size;
		Windowing.hann(fftSize) => fft.window;

		.0=>float last;
		//.00015=>float maxRMS;
		while( true )
		{
			fft.size()::samp => now;
			// upchuck: take fft then rms
			rms.upchuck() @=> UAnaBlob blob;

			// print out RMS
			blob.fval(0) => last;
			<<< "[ ", buf.pos(), ", ", last, " ],">>>;

			if (buf.pos() >= buf.samples() - 1) {
				break;
			}
		}
	}

	int silence_arr[];

	// sets silence array
	public void setSilenceArr(int _silence_arr[]) {
		_silence_arr @=> silence_arr;
	}

	0=>int bufStartPos;

	// sets start position
	public void setStartPos(int s) {
		s=>bufStartPos;
	}

	// reads in wav file
	public void read(string filename) {
		filename => buf.read;
	}

	// sets the periodicity of the loop
	public void setPeriodicity(int p) {
		Math.floor( Timer.get_T() * p / samp ) $ int => period;
	}


	0=>int maxLoopNo;

	// sets how many versions there are in the wav file
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

	private int getNextSilence(int p) {
		for (0=>int i; i<silence_arr.cap(); i++) {
			if (silence_arr[i] > p) {
				return silence_arr[i];
			}
		}
		return buf.samples();
	}

	private int getNextSilence() {
		return getNextSilence(buf.pos());
	}

	// play that funky music
	public void play() {
		1.=>buf_env.target;
		bufStartPos=>buf.pos;
		0 => int np;
		while (1) {
			// next silence
			// we'll sleep till that moment
			(getNextSilence()-buf.pos())::samp => now;
			if (Std.randf() > -.3 && buf.pos() < maxLoopNo*period) {
				// there'll be no "off", sleep on
				<<<"sk">>>;
				continue;
			}

			// there'll be "off"

			// next position?
			bufStartPos + (Std.rand2(0, maxLoopNo) * period) + ((buf.pos()-bufStartPos) % period) => np;

			// how much do we have to wait for the break at the next silence
			// set decay
			getNextSilence(np + (maxRelease/1::samp) $ int)-np=>int offDur;
			<<<offDur>>>;
			(offDur::samp-maxRelease)=>now;

			maxRelease=>buf_env.duration;
			0.=>buf_env.target;

			maxRelease=>now;

			// step to the next position
			np+offDur=>buf.pos;

			// turn on sound quickly
			defDur=>buf_env.duration;
			1.=>buf_env.target;
			defDur=>now;
		}
	}
	
	spork ~ play();
}

// switches between different versions of the same recorded loop
// at random positions. It basically contains two RandLoops, so
// calm down.

public class StereoRandLoop {
	RandLoop r_left;
	RandLoop r_right;
	Pan2 pan1;
	pan1.left => Gain gLeft;
	pan1.right => Gain gRight;
	Pan2 pan2;
	pan2.left => gLeft;
	pan2.right => gRight;
	
	// sets gain
	public void setGain(float g) {
		r_left.setGain(g);
		r_right.setGain(g);
	}
	
	// sets gain with a nice slope (it does not click)
	public void setGain(float g, dur d) {
		r_left.setGain(g, d);
		r_right.setGain(g, d);
	}
	
	r_left.chuck() => pan1;
	r_right.chuck() => pan2;

	// for connecting left
	public UGen chuckLeft() {
		return gLeft;
	}

	// for connecting right
	public UGen chuckRight() {
		return gRight;
	}
	
	// reads the stereo loops
	public void read(string filename) {
		filename + "_left" => r_left.read;
		filename + "_right" => r_right.read;
	}
	
	// sets loop period
	public void setPeriodicity(int p) {
		r_left.setPeriodicity(p);
		r_right.setPeriodicity(p);
	}

	// sets loop starting position
	public void setStartPos(int s) {
		r_left.setStartPos(s);
		r_right.setStartPos(s);
	}
	
	// sets pan
	public void setPan(float p) {
		p=>pan1.pan;
		-p=>pan2.pan;
	}
	
	// sets maximum loop number
	public void setMaxLoopNo(int m) {
		r_left.setMaxLoopNo(m);
		r_right.setMaxLoopNo(m);
	}
	
	// sets random period:
	// - min is the minimum period size
	// - max is the maximum period size
	// - gran is the granularity
	public void setRandPeriod(int min, int max, float gran) {
		r_left.setRandPeriod(min, max, gran);
		r_right.setRandPeriod(min, max, gran);
	}

}

// a stereo effect

public class StereoEffect extends Effect {
	Gain outputLeft;
	Gain outputRight;
	Mix2 mix => output; <--mono output
	outputLeft => mix.left;
	outputRight => mix.right;
	
	// gets left output
	public UGen getLeft() {
		return outputLeft;
	}
	
	// gets right output
	public UGen getRight() {
		return outputRight;
	}
}

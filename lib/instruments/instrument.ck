// base class for all Instruments

public class Instrument {
	Gain output;
	
	// for connecting
	public UGen chuck() {
		return output;
	}
	
	// gets MIDI note number for note
	public static float getNote(string n) {
		if (n == "c" || n == "C") {
			return 12.0;
		} else if (n == "c#" || n == "C#") {
			return 13.0;
		} else if (n == "d" || n == "D") {
			return 14.0;
		} else if (n == "d#" || n == "D#") {
			return 15.0;
		} else if (n == "e" || n == "E") {
			return 16.0;
		} else if (n == "f" || n == "F") {
			return 17.0;
		} else if (n == "f#" || n == "F#") {
			return 18.0;
		} else if (n == "g" || n == "G") {
			return 19.0;
		} else if (n == "g#" || n == "G#") {
			return 20.0;
		} else if (n == "a" || n == "A") {
			return 21.0;
		} else if (n == "a#" || n == "A#" || n == "b" || n == "B") {
			return 22.0;
		} else if (n == "h" || n == "H") {
			return 23.0;
		}
	}
	
	float curNote;

	// gets note number for note and octave
	public static float getNote(string n, int octave) {
		return getNote(n) + octave * 12.0;
	}

	// TODO...
	public void note(float n, float d, int legato) {

	}
	
	// plays a note n for duration d
	public void note(float n, float d) {
		note(n, d, 0);
	}
	
	// plays a note
	public void note(string n, int oct, float d) {
		note(getNote(n, oct), d);
	}
	
	// plays a glissando from note n1 to n2
	public void gliss(float n1, float n2, float d, int legato) {
		// only the glissando
		50.=>float steps;
		note(n1, d/steps, legato|1);
		for(0=>int i; i < steps-2; i++) {
			note(n1+i*(n2-n1)/steps, d/steps, 3);
		}
		note(n2, d/steps, legato|2);
	}
	
	// plays a glissando from current note to n
	public void gliss_to(float n, float d, int legato) {
		gliss(curNote, n, d*.1, legato|1);
		note(n, d*.9, legato|2);
	}
	
	// glissando
	public void gliss_to(float n, float d) {
		gliss_to(n, d, 0);
	}

	// sets gain
	public void setGain(float g) {
		g => output.gain;
	}
}


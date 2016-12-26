// chord player

public class ChordPlayer {

	Instrument instrs[];

	// returns the number of notes in a chord
	public static int chordNotesLen(string noteName, string chordName) {
		if (chordName == "" || chordName == "m" || chordName == "aug") {
			// dur
			return 3;
		} else if (chordName == "dim" || chordName == "7" || chordName == "m7" || chordName == "maj7") {
			return 4;
		}
	}

	// returns the notes in a chord
	public static float[] chordNotes(string noteName, string chordName) {
		float baseNotes[chordNotesLen(noteName, chordName)];
		Instrument.getNote(noteName) => baseNotes[0];
		if (chordName == "") {
			// dur
			baseNotes[0] + 4.0 => baseNotes[1];
			baseNotes[0] + 7.0 => baseNotes[2];
			// baseNotes[0] + 12.0 => baseNotes[3];
		} else if (chordName == "m") {
			baseNotes[0] + 3.0 => baseNotes[1];
			baseNotes[0] + 7.0 => baseNotes[2];
			// baseNotes[0] + 12.0 => baseNotes[3];
		} else if (chordName == "aug") {
			baseNotes[0] + 4.0 => baseNotes[1];
			baseNotes[0] + 8.0 => baseNotes[2];
			// baseNotes[0] + 12.0 => baseNotes[3];
		} else if (chordName == "dim") {
			baseNotes[0] + 3.0 => baseNotes[1];
			baseNotes[0] + 6.0 => baseNotes[2];
			baseNotes[0] + 9.0 => baseNotes[3];
		} else if (chordName == "7") {
			baseNotes[0] + 4.0 => baseNotes[1];
			baseNotes[0] + 7.0 => baseNotes[2];
			baseNotes[0] + 10.0 => baseNotes[3];
		} else if (chordName == "m7") {
			baseNotes[0] + 3.0 => baseNotes[1];
			baseNotes[0] + 7.0 => baseNotes[2];
			baseNotes[0] + 10.0 => baseNotes[3];
		} else if (chordName == "maj7") {
			baseNotes[0] + 4.0 => baseNotes[1];
			baseNotes[0] + 7.0 => baseNotes[2];
			baseNotes[0] + 11.0 => baseNotes[3];
		}
		return baseNotes;
	}


	// returns all the notes in a chord (how many? - see param howManyNotes) starting on a note 
	public static float[] chordNotesRange(string noteName, string chordName, int howManyNotes, string startNote, int startOctave) {
	
		<<< "chnotes" >>>;
		chordNotes(noteName, chordName) @=> float f[];

		// calculate output array size
		//	<<< "getnote" >>>;
		//	Instrument.getNote(maxNote, octave) => float max;
		//	Math.floor((max - f[0]) / 12) $ int => int fullOctaves;
		//	<<<"full oct", fullOctaves>>>;
		//	((max - f[0]) $ int) - fullOctaves*12 => int remNotes;
		//	<<<"rem notes", remNotes>>>;
		//	0 => int remNotesFromChord;
		//	for (0 => int j; j < f.cap(); j++) {
		//		if (f[j] - f[0] > remNotes) {
		//			j => remNotesFromChord;
		//			break;
		//		}
		//	}
		//	<<<"rem notes from chord", remNotesFromChord>>>;
		//
		Instrument.getNote(startNote, startOctave) => float start;
		
		float out[howManyNotes];
		0 => int actPos;
		for (0 => int i; true; i++) {
			for (0 => int j; j < f.cap(); j++) {
				12.0*i + f[j] => float actNote;
				if (actPos == howManyNotes) {
					//	1=>loopEnded;
					break;
				}
				if (actNote < start) {
					continue;
				}
				actNote => out[actPos++];
				
			}
			if (actPos == howManyNotes) {
				break;
			}
		}
		return out;
	}

	// sets size of instrument array
	public void setInstrumentsSize(int siz) {
		Instrument loc[siz] @=> instrs;
	}
	
	// sets instrument at position
	public void setInstrumentAt(int pos, Instrument instr) {
		instr @=> instrs[pos];
	}
	
	// plays a chord
	public void chord(string name, string chName, float d, string startNote, int startOctave, int legato) {
		<<<"ch">>>;
		chordNotesRange(name, chName, instrs.cap(), startNote, startOctave) @=> float f[];
		for (0=>int i; i < instrs.cap(); i++) {
			spork~instrs[i].note(f[i],d,legato);
		}
		Timer.advance(d);
	}
	
	// plays a chord
	public void chord(string name, string chName, float d, string startNote, int startOctave) {
		chord(name, chName, d, startNote, startOctave, 0);
	}	
	
	// glissando to a chord
	public void gliss_to_chord(string name, string chName, float d, string startNote, int startOctave, int legato) {
		<<<"ch">>>;
		chordNotesRange(name, chName, instrs.cap(), startNote, startOctave) @=> float f[];
		for (0=>int i; i < instrs.cap(); i++) {
			spork~instrs[i].gliss_to(f[i],d,legato);
		}
		Timer.advance(d);
	}	
	
	// glissando to a chord
	public void gliss_to_chord(string name, string chName, float d, string startNote, int startOctave) {
		gliss_to_chord(name, chName, d, startNote, startOctave, 0);
	}	

	// arpeggio
	public void arpeggio(string name, string chName, float d, int howManyNotes,
			string startNote, int startOctave) {
		chordNotesRange(name, chName, howManyNotes, startNote, startOctave) @=> float f[];
		for (0=>int i; i<f.cap(); i++) {
			<<<"note: ", f[i]>>>;
			
			spork~instrs[i % instrs.cap()].note(f[i],d*instrs.cap());
			Timer.advance(d);
		}
	}
	
	// reverse arpeggio (down)
	public void revArpeggio(string name, string chName, float d, int howManyNotes,
			string startNote, int startOctave) {
		chordNotesRange(name, chName, howManyNotes, startNote, startOctave) @=> float f[];
		0 => int actInstr;
		for ((f.cap()-1)=>int i; i>=0; i--) {
			<<<"note: ", f[i]>>>;
			
			spork~instrs[actInstr++ % instrs.cap()].note(f[i],d*instrs.cap());
			Timer.advance(d);
		}
	}
}

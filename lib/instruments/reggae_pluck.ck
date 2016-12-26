// a guitar-like synth

public class ReggaePluck extends Instrument {

	1.5=>float releaseD;
	null=>Shred @wfrs;
	
	Mandolin guit[12];
	ADSR adsr[guit.cap()];
	float noteArr[guit.cap()];
	
	// this array shows if releasing is on 
	int releasingArr[guit.cap()];
	
	for (0=>int i; i<guit.cap(); i++) {
		guit[i]=>adsr[i]=>output;
		guit[i].stringDamping(0.3);
		guit[i].pluckPos(0.05);
		guit[i].bodySize(0.7);
		guit[i].gain(1.8);
		
		adsr[i].set(.02::Timer.get_T(), .03::Timer.get_T(), 1, releaseD::Timer.get_T()); 
		adsr[i].keyOff();
		0=>noteArr[i];
		0=>releasingArr[i];
	}
	
	private void waitForRelease(int i)
	{
		//<<<"rel",noteArr[i],"timer">>>;
		releaseD=>Timer.advance;
		//<<<"rel",noteArr[i]>>>;
		if (1 == releasingArr[i]) {
			0=>releasingArr[i];
			0=>noteArr[i];
		}
	}
	
	private int getNoteIndex(float n)
	{
		for (0=>int i; i<noteArr.cap(); i++)
		{
			if (noteArr[i] == n)
			{
				return i;
			}
		}
		return -1;
	}
	
	private int newNoteIndex(float n)
	{
		for (0=>int i; i<noteArr.cap(); i++)
		{
			if (noteArr[i] == 0)
			{
				n=>noteArr[i];
				return i;
			}
		}
		<<<"no more index">>>;
		Machine.crash();
	}

	// note on
	public void noteOn(float n)
	{
		getNoteIndex(n)=>int i;
		if (i < 0) {
			newNoteIndex(n) => i;
		} else {
			0=>releasingArr[i];
			wfrs.exit(); <-- ?? not work?
		}
		n => Std.mtof => guit[i].freq;
		Std.rand2f(.995, 1.005)*guit[i].freq()=>guit[i].freq;
		guit[i].pluck(1);
		adsr[i].keyOn(1);
	}
	
	// note off
	public void noteOff(float n)
	{
		getNoteIndex(n)=>int i;
		if (i < 0) {
			<<< "no such note", n >>>;
			return;
		}
		adsr[i].keyOff(1);
		1=>releasingArr[i];
		spork~waitForRelease(i) @=> wfrs;
	}

	// plays a note
	public void note(float n, float d, int legato /*ignored*/) {
		noteOn(n);

		Timer.advance(d);
		
		noteOff(n);
	}
}


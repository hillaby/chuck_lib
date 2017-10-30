public class Chords
{
	Gain gainLeft;
	Gain gainRight;

	StereoEcho e;
	e.setDelay(.125, .3);
	e.setOnOffRate(1., .3);
	e.getLeft() => gainLeft;
	e.getRight() => gainRight;

	SMarimba mar[4];
	Pan2 mpan[4];
	ChordPlayer mchord;
	mchord.setInstrumentsSize(mar.cap());
	for (0 => int i; i < mar.cap(); i++)
	{
		//<<< i >>>;
		mar[i].chuck()=>mpan[i];
		((i % 2) - 0.5) * 0.8 => mpan[i].pan;
		mpan[i].left => /*lpfLeft*/ gainLeft;
		mpan[i].right => /*lpfRight*/ gainRight;
		mchord.setInstrumentAt(i, mar[i]);
	}

	SBowedGlass violin[6];
	Pan2 vpan[6];
	ChordPlayer violinChord;
	violinChord.setInstrumentsSize(violin.cap());
	for (0 => int i; i < violin.cap(); i++)
	{
		//<<< i >>>;
		violin[i].chuck()=>vpan[i];
		((i % 2) - 0.5) * 0.8 => vpan[i].pan;
		vpan[i].left => /*lpfLeft*/ gainLeft;
		vpan[i].right => /*lpfRight*/ gainRight;
		violinChord.setInstrumentAt(i, violin[i]);
	}
//if (false) {
	BowedString quartet[4]; <-- :):):)
	Pan2 qpan[4];
	ChordPlayer quartetChord;
	quartetChord.setInstrumentsSize(quartet.cap());
	for (0 => int i; i < quartet.cap(); i++)
	{
		//<<< i >>>;
		quartet[i].chuck()=>qpan[i];
		((i % 2) - 0.5) * 0.8 => qpan[i].pan;
		qpan[i].left => /*lpfLeft*/ gainLeft;
		qpan[i].right => /*lpfRight*/ gainRight;
		quartet[i].setGain(1);
		if (i == 0)
		{
			quartet[i].setOctave(-1);
		}
		else if (i == 1)
		{
			quartet[i].setOctave(0);
		}
		else if (i == 2)
		{
			quartet[i].setOctave(1);
		}
		else
		{
			quartet[i].setOctave(2);
		}
		quartetChord.setInstrumentAt(i, quartet[i]);
	}
//}
	off();
	spork ~ play();

	0=>int what_to_play;

	public void chord(string name, string chName, float dur)
	{
		if (name == "")
		{
			dur=>Timer.advance;
			return;
		}
		mchord.chord(name, chName, dur, "C",3);
	}

	0=>int qPlaying;
	public void piano_pattern(string name, string chName,string name2, string chName2)
	{
		spork~violinChord.chord(name, chName, 3, "C", 5);
		if (!qPlaying)
		{
			spork~quartetChord.chord(name, chName, 3, "C", 3, 0);
			1=>qPlaying;
		}
		else
		{
			spork~quartetChord.gliss_to_chord(name, chName, 3, "C", 3, 2);
		}
		chord("","", .75);
		chord(name,chName, .5);
		chord("","", .25);
		chord(name,chName, .5);
		chord("","", .5);
		chord(name,chName, .5);
		spork~violinChord.chord(name2, chName2, .7, "C", 5);
		spork~quartetChord.chord(name2, chName2, .95, "C", 3, 1);
		chord(name2,chName2, .5);
		chord("","", .25);
		spork~chord(name2,chName2, .5);

		chord("","", .25);
	}

	public void play()
	{
		while(true)
		{
			if (what_to_play == 0)
			{

				piano_pattern("E","m","F","dim");
				piano_pattern("F#","m","F","dim");

				piano_pattern("E","m","F","dim");
				piano_pattern("F#","m","F","dim");

				piano_pattern("G","","F","dim");
				piano_pattern("F#","","F","dim");

				piano_pattern("G","","F","dim");
				spork~violinChord.chord("G#","dim", 2, "d#", 5);
				spork~quartetChord.gliss_to_chord("G#","dim", 2, "d#", 3);
				chord("","", .75);
				chord("F","dim", .5);
				chord("","", .25);
				chord("F","dim", .5);
				spork~violinChord.chord("H","7", 2, "F#", 5);
				spork~quartetChord.chord("H","7", 2, "F#", 3);
				chord("","", .75);
				chord("H","7", .5);
				chord("","", .25);
				chord("H","7", .5);


				0=>qPlaying;
			}

		}
	}

	public void connectLeft(UGen ug)
	{
		gainLeft => ug;
	}

	public void connectRight(UGen ug)
	{
		gainRight => ug;
	}

	public void marOn(float g)
	{
		for (0 => int i; i < mar.cap(); i++)
		{
			mar[i].setGain(g);
		}
	}

	public void bowOn(float g)
	{
		for (0 => int i; i < violin.cap(); i++)
		{
			violin[i].setGain(g);
		}
	}

	public void quartetOn(float g)
	{
		for (0 => int i; i < quartet.cap(); i++)
		{
			quartet[i].setGain(g);
		}
	}

	public void off()
	{
		marOn(0);
		bowOn(0);
		quartetOn(0);
	}

	public void set_what_to_play(int p)
	{
		p => what_to_play;
	}
}

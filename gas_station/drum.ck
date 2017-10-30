public class Drum
{
	Gain mono => Gain gainLeft;
	mono => Gain gainRight;
	/* ABSndBuf snare;*/
	SAggressiveSnare snare;
	Pan2 snarePan;
	/* NRev rev=>snarePan;
	.04=>rev.mix;*/
	// 1=>rev.gain;
	snare.chuck()=>snarePan;
	snarePan.left=>gainLeft;
	snarePan.right=>gainRight;

	snare.setGain(1.4);
	// "drum-snare-tap.wav" => snare.read;

	//ABSndBuf bass;
	.8=>float bassGain;
	SBassDrum bass;
	bass.chuck()=>mono;
	bass.setGain(bassGain);
	//"drum-bass-lo-1.wav" => bass.read;

	1=>float hhGain;
	SHiHat hh;
	hh.chuck()=>Pan2 hhp;
	hhp.left=>gainLeft;
	hhp.right=>gainRight;
	hh.setGain(hhGain);

	STom t;
	t.chuck()=>Pan2 tp;
	tp.left=>gainLeft;
	tp.right=>gainRight;
	t.setGain(1.8);


	off();
	spork ~ play();
	spork ~ playT();
	spork ~ playB();

	0=>int what_to_play;

	public void tnote(int no, float d)
	{
		Std.rand2f(-1,1)=>tp.pan;
		t.nnote(no, d);
	}

	public void playT()
	{
		while(1)
		{
			Timer.advance(2);
			if (maybe)
			{
				spork~tnote(0, 1.5);
				Timer.advance(.75);
				//tnote(.25);
				//tnote(.25);
				tnote(1, .25);
			}
			else
			{
				tnote(0, .25);
				//tnote(.25);
				//tnote(.25);
				spork~tnote(0, 1.5);
				Timer.advance(.75);
			}
			spork~tnote(1, 1.5);
			Timer.advance(.5);
			//Timer.advance(.25);
			//tnote(.25);
			spork~tnote(2, 1.5);
			Timer.advance(.5);
		}
	}

	public void playB()
	{
		while (1)
		{
			bass.note(1);
		}
	}

	public void hhnote(float d)
	{
		Std.rand2f(-.5,.5)=>hhp.pan;
		hh.closedNote(d);
	}
	public void snnote(float d)
	{
		Std.rand2f(-.1,.1)=>snarePan.pan;
		snare.note(d);
	}
	public void play()
	{
		// b... ..s. .... s... x3 b,,s ..s. b..s ..s.
		0=>int turn;
		while(true)
		{
			if (what_to_play == 0)
			{
				for (0=>int i; i<7; i++)
				{
					hhnote(.25);

					if (false)
					{
						Timer.advance(.25);
						//spork~snnote(.25);
						hhnote(.25);
					}
					else
					{
						hhnote(.25);
						//spork~snnote(.25);
						Timer.advance(.25);
					}
					hhnote(.25);
					Timer.advance(.25);
					hhnote(.25);
					spork~hhnote(.25);
					snnote(.25);
					Timer.advance(.25);
					hh.openNote(.5);
					/*hhnote(.25);
					Timer.advance(.25);*/
					hhnote(.25);
					Timer.advance(.25);
					hhnote(.25);
					//snnote(.25);
					Timer.advance(.25);
					spork~snnote(.25);
					hhnote(.25);
					hhnote(.25);
				}
				for (0=>int i; i<2; i++)
				{
					if (i == 1)
					{
						hh.openNote(.5);
						hhnote(.25);
					}
					else
					{
						hhnote(.25);
						//bass.note(.25);
						if (maybe)
						{
							Timer.advance(.25);
							hhnote(.25);
						}
						else
						{
							hhnote(.25);
							Timer.advance(.25);
						}
					}
					spork~snnote(.25);
					hhnote(.25);
					Timer.advance(.25);
					hhnote(.25);
					spork~hhnote(.25);
					snnote(.25);
					if (maybe)
					{
						hhnote(.25);
					}
					else
					{
						Timer.advance(.25);
					}
				}
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

	public void on(float g)
	{
		g => gainLeft.gain;
		g => gainRight.gain;
	}

	public void on(float g)
	{
		g => gainLeft.gain;
		g => gainRight.gain;
	}

	public void bassOn() {
		bassGain=>bass.setGain;
	}

	public void bassOff() {
		0=>bass.setGain;
	}

	public void hhOn() {
		hhGain=>hh.setGain;
	}

	public void hhOff() {
		0=>hh.setGain;
	}

	public void off()
	{
		0 => gainLeft.gain;
		0 => gainRight.gain;
	}

	public void set_what_to_play(int p)
	{
		p => what_to_play;
	}
}

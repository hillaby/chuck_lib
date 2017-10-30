public class Theme
{
	//ABSndBuf trombone[1];
	// Pan2 pans[1];
	// LPF lpf=>Gain dummy=>pans[0];
	// dummy=>Echo echo=>Gain feedback=>dummy;
	//trombone[0].connect(lpf);
	//trombone[0].set_gain(.8);
	// trombone[0].read("Trombone4.wav", 41);
	// trombone[0].read("Trombone4.wav", 41.09);
	//trombone[0].set_start_pos(6000);
	Pan2 pan;
	//MugiMaki mm;
	STrumpet mm;

	NRev n=>pan;
	n.mix(.1);
	mm.chuck()=>n;


	pan.left => Gain gainLeft;
	pan.right => Gain gainRight;

	//(1.0/8.0)::AATimer.get_T() => echo.delay;
	//.2 => echo.mix;
	//1::AATimer.get_T() => echo.max;
	//.9 => feedback.gain;


	//1200=>lpf.freq;

	//pans[0].pan(0);

	off();
	spork ~ play();

	0=>int what_to_play;

	public void play()
	{
		while(true)
		{
			if (what_to_play == 0)
			{
				for (0=>int i;i<2;i++){
					mm.note("e",5,.75);
					mm.note("h",4,2.25);
					//Timer.advance(1);
					mm.note("g#",4,.5);
					mm.note("h",4,.5);

					mm.note("d",5,.75);
					mm.note("c#",5,.75);
					mm.note("a",4,2.5);
				}
				mm.note("h",4,.75);
				mm.note("g",4,2.25);
				//Timer.advance(1);
				mm.note("f",4,.5);
				mm.note("g#",4,.5);

				mm.note("h",4,.75);
				mm.note("a#",4,.75);
				mm.note("f#",4,2.5);

				mm.note("h",4,.75);
				mm.note("g",4,2.25);
				//Timer.advance(1);
				mm.note("f",4,.5);
				mm.note("g#",4,.5);

				mm.note("h",4,.75);
				mm.note("a#",4,.75);
				mm.note("g#",4,.5);

				mm.note("d",5,.75);
				mm.note("c#",5,.75);
				mm.note("h",4,.5);
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

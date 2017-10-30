public class Bass
{
    TalkingBass bass;
    bass.chuck()=>Gain gain;

    bass.setGain(1);


    off();
    spork ~ play();

    0=>int what_to_play;

    public void play()
    {
        while(true)
        {
			// e..g .... .... f... f#..a .... .... x2  g..h      f f#  a  g  h   f   h b g# g f# f
            if (what_to_play == 0)
            {
				for (0=>int i;i<2;i++) {
					bass.note("e",1,.75);
					bass.note("g",1,.75);

					//bass.note("e",3,1);
					Timer.advance(1.5);
					bass.note("f",1,1);
					//Timer.advance(.25);

					bass.note("f#",1,.75);
					bass.note("a",1,.75);
					//bass.note("e",3,1);
					Timer.advance(1.5);
					bass.note("f",1,1);
					//Timer.advance(.25);
				}
				bass.note("g",1,.75);
				bass.note("h",1,.75);
				//bass.note("e",3,1);
				Timer.advance(1.5);
				bass.note("f",1,1);
				//Timer.advance(.25);

				bass.note("f#",1,.75);
				bass.note("a#",1,.75);
				//bass.note("e",3,1);
				Timer.advance(1.5);
				bass.note("f#",1,1);
				//Timer.advance(.25);

				bass.note("g",1,.75);
				bass.note("h",1,.75);
				//bass.note("e",3,1);
				Timer.advance(1.5);
				bass.note("f",1,1);
				//Timer.advance(.25);

				bass.note("h",1,.75);
				bass.note("a#",1,.75);
				bass.note("g#",1,.5);
				//bass.note("e",3,1);
				bass.note("g",1,.75);
				bass.note("f#",1,.75);
				bass.note("f",1,.5);

			}
        }
    }

    public void connect(UGen ug)
    {
        gain => ug;
    }

    public void on(float g)
    {
        g => gain.gain;
    }

    public void off()
    {
        0 => gain.gain;
    }

    public void set_what_to_play(int p)
    {
        p => what_to_play;
    }
}

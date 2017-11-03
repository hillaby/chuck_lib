public class Piano
{
    Gain gainLeft;
    Gain gainRight;

    gainLeft=>Echo echoLeft=>Gain feedbackLeft=>gainLeft;
    gainRight=>Echo echoRight=>Gain feedbackRight=>gainRight;

    (1.0/6.0)::AATimer.get_T() => echoLeft.delay;
    .3 => echoLeft.mix;
    1::AATimer.get_T() => echoLeft.max;
    1 => feedbackLeft.gain;

    (1.0/6.0)::AATimer.get_T() => echoRight.delay;
    .3 => echoRight.mix;
    1::AATimer.get_T() => echoRight.max;
    1 => feedbackRight.gain;

    LPF lpfLeft=>gainLeft;
    LPF lpfRight=>gainRight;
    lpfRight.freq(2000);
    lpfLeft.freq(2000);
    ABSndBuf piano[10];
    Pan2 pan[10];
    for (0 => int i; i < piano.cap(); i++)
    {
        piano[i].connect(pan[i]);
        ((i % 2) - 0.5) * 0.8 => pan[i].pan;
        pan[i].left => lpfLeft;
        pan[i].right => lpfRight;
        piano[i].read(
            "piano_D4.wav",
            50.04
        );
        piano[i].set_gain(.5);
    }


    off();
    spork ~ play();

    0=>int what_to_play;

    public void chord(int arr[], float dur)
    {
        if (arr[0]== -1)
        {
            dur=>AATimer.advance;
            return;
        }
        for (0 => int i; i < arr.cap(); i++)
        {
            spork~piano[i].note(arr[i], dur);
        }
        dur=>AATimer.advance;
    }

    public void piano_pattern(int arr[])
    {
        chord([-1], .5);
        chord(arr, .15);
        chord([-1], .85);
        chord(arr, .15);
        chord([-1], .85);
        chord(arr, .15);
        chord([-1], .85);
        chord(arr, .15);
		chord([-1], .35);
    }

    public void play()
    {
        while(true)
        {
            if (what_to_play == 0)
            {
                // c minor
                piano_pattern([48, 51, 55, 60]);

                // b augmented
                piano_pattern([47, 51, 55, 59]);
                //bass_pattern(23, 31);

                // es
                piano_pattern([51, 55, 58, 63]);
                /*bass_pattern(22, 31);*/

                // f septim
                /*bass_pattern(21, 29);       */
                piano_pattern([53, 57, 60, 63]);

                // as
                piano_pattern([48, 51, 56, 60]);

                // g septim
                piano_pattern([50, 53, 55, 59]);

                // c major septim
                piano_pattern([48, 52, 55, 59]);

                // b septim
                piano_pattern([46, 50, 53, 56]);


                // a minor
                piano_pattern([48, 52, 57, 60]);

                // gis augmented
                piano_pattern([48, 52, 56, 60]);

                // c
                piano_pattern([48, 52, 55, 60]);

                // d septim
                piano_pattern([50, 54, 57, 60]);

                // f
                piano_pattern([48, 53, 57, 60]);

                // g
                piano_pattern([50, 55, 59, 62]);

                // gis
                piano_pattern([51, 56, 60, 63]);

                // cis septim
                piano_pattern([49, 53, 56, 59]);

            }
            else
            {
                piano_pattern([48, 51, 55, 60]);
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

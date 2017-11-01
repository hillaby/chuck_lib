public class Piano
{
    LPF lpfLeft => Gain gainLeft;
    LPF lpfRight => Gain gainRight;
    200=>lpfLeft.freq;
    200=>lpfRight.freq;
    ABSndBuf piano[10];
    Pan2 pan[10];
    for (0 => int i; i < piano.cap(); i++)
    {
        piano[i].connect(pan[i]);
        ((i % 2) - 0.5) * 0.8 => pan[i].pan;
        pan[i].left => lpfLeft;
        pan[i].right => lpfRight;
        piano[i].read(
            //"../instruments/Berklee44V4/piano_D4.wav",
            //"../instruments/OpenPathMusic44V4/organ-tonewheel-octave2.wav",
            //"../instruments/OpenPathMusic44V4/piano-electric-tine-octave2.wav",
            //"../instruments/OpenPathMusic44V4/organ-tonewheel-octave2-mod-2.wav",
            "organ-tonewheel-octave2-modd.wav",
            48
        );
    }


    off();
    spork ~ play();

    0=>int what_to_play;

    public void wah()
    {
        for (10=>int i; i < 1000; i++)
        {
            //<<<i>>>;
            i*20 => lpfLeft.freq;
            i*20 => lpfRight.freq;
            .003=>AATimer.advance;
        }
    }

    public void chord(float arr[], float dur)
    {
        if (arr[0]== -1)
        {
            dur=>AATimer.advance;
            return;
        }
        spork~wah() @=> Shred ww;;
        for (0 => int i; i < arr.cap(); i++)
        {
            spork~piano[i].note(arr[i], dur);
        }
        dur=>AATimer.advance;
        ww.exit();
    }

    public void play()
    {
        while(true)
        {
            if (what_to_play == 0)
            {
                // D F G#
                chord([-1.0], .25);
                chord([53.0, 56.0, 59.0, 62.0], .75);
                chord([50.0, 53.0, 56.0, 59.0], .5);
                chord([50.0, 53.0, 56.0, 59.0], .5);

                chord([-1.0], .25);
                chord([53.0, 56.0, 59.0, 62.0], .75);
                chord([50.0, 53.0, 56.0, 59.0], .5);
                chord([50.0, 53.0, 56.0, 59.0], .5);

                // Cm
                chord([-1.0], .25);
                chord([51.0, 55.0, 58.0, 60.0], .75);
                chord([48.0, 51.0, 55.0, 58.0], .5);
                chord([48.0, 51.0, 55.0, 58.0], .5);

                chord([-1.0], .25);
                chord([51.0, 55.0, 58.0, 60.0], .75);
                chord([48.0, 51.0, 55.0, 58.0], .5);
                chord([48.0, 51.0, 55.0, 58.0], .5);

                // C D# F#
                chord([-1.0], .25);
                chord([51.0, 54.0, 57.0, 60.0], .75);
                chord([48.0, 51.0, 54.0, 57.0], .5);
                chord([48.0, 51.0, 54.0, 57.0], .5);

                chord([-1.0], .25);
                chord([51.0, 54.0, 57.0, 60.0], .75);
                chord([48.0, 51.0, 54.0, 57.0], .5);
                chord([48.0, 51.0, 54.0, 57.0], .5);

                // Bb maj7
                chord([-1.0], .25);
                chord([50.0, 53.0, 57.0, 60.0], .75);
                chord([46.0, 50.0, 53.0, 57.0], .5);
                chord([46.0, 50.0, 53.0, 57.0], .5);

                chord([-1.0], .25);
                chord([50.0, 53.0, 57.0, 60.0], .75);
                chord([46.0, 50.0, 53.0, 57.0], .5);
                chord([46.0, 50.0, 53.0, 57.0], .5);

                // F#7
                chord([-1.0], .25);
                chord([52.0, 54.0, 58.0, 61.0], .75);
                chord([49.0, 52.0, 54.0, 58.0], .5);
                chord([49.0, 52.0, 54.0, 58.0], .5);

                chord([-1.0], .25);
                chord([52.0, 54.0, 58.0, 61.0], .75);
                chord([49.0, 52.0, 54.0, 58.0], .5);
                chord([49.0, 52.0, 54.0, 58.0], .5);

                // F7
                chord([-1.0], .25);
                chord([51.0, 53.0, 57.0, 60.0], .75);
                chord([48.0, 51.0, 53.0, 57.0], .5);
                chord([48.0, 51.0, 53.0, 57.0], .5);



            }
            else
            {
                chord([-1.0], .25);
                chord([46.0, 50.0, 53.0, 57.0], .25);
                chord([-1.0], .25);
                chord([46.0, 50.0, 53.0, 57.0], 1);
                //chord([-1.0], .5);
                chord([46.0, 50.0, 53.0, 57.0], .25);
            }

            if (what_to_play == 0)
            {


                chord([-1.0], .25);
                chord([51.0, 53.0, 57.0, 60.0], .75);
                chord([48.0, 51.0, 53.0, 57.0], .5);
                chord([48.0, 51.0, 53.0, 57.0], .5);

                // Bb maj7
                chord([-1.0], .25);
                chord([50.0, 53.0, 57.0, 60.0], .75);
                chord([46.0, 50.0, 53.0, 57.0], .5);
                chord([46.0, 50.0, 53.0, 57.0], .5);

                chord([-1.0], .25);
                chord([50.0, 53.0, 57.0, 60.0], .75);
                chord([46.0, 50.0, 53.0, 57.0], .5);
                chord([46.0, 50.0, 53.0, 57.0], .5);

                // Bb m 7
                chord([-1.0], .25);
                chord([49.0, 53.0, 56.0, 58.0], .75);
                chord([46.0, 49.0, 53.0, 56.0], .5);
                chord([46.0, 49.0, 53.0, 56.0], .5);

                chord([-1.0], .25);
                chord([49.0, 53.0, 56.0, 58.0], .75);
                chord([46.0, 49.0, 53.0, 56.0], .5);
                chord([49.0, 53.0, 56.0, 58.0], .5);
            }
            else
            {
                chord([48.0, 51.0, 55.0, 58.0], .75);
                chord([47.0, 51.0, 54.0, 58.0], .75);
                //chord([47.0, 51.0, 54.0, 58.0], .5);
                chord([46.0, 50.0, 53.0, 57.0], .25);
                chord([46.0, 50.0, 53.0, 57.0], .25);
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

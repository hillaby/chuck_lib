public class Bass
{
    ABSndBuf bass;
    bass.connect(LPF lpf);
    bass.read(
        "bass-elec2-E-octave0.wav",
        16
    );
    bass.set_gain(.76);

    lpf=>Gain gain;
    360=>lpf.freq;

    off();
    spork ~ play();

    0=>int what_to_play;


    public void play()
    {
        while(true)
        {
            if (what_to_play == 0)
            {
                for (0=>int j; j < 2; j++) {
                    // f
                    for (0=>int i; i < 5; i++) {
                        bass.note(17, .5);
                        bass.note(24, .5);
                    }

                    bass.note(17, .5);
                    // g
                    bass.note(19, .5);

                    // c
                    bass.note(24, .5);
                    bass.note(19, .5);
                    bass.note(24, .5);

                    //  d
                    bass.note(26, .5);

                    // gm
                    bass.note(19, .5);
                    bass.note(26, .5);
                    bass.note(19, .5);

                    // c
                    bass.note(24, .5);

                    // f
                    bass.note(17, .5);
                    bass.note(24, .5);
                    bass.note(17, .5);

                    // esz
                    bass.note(15, .5);

                    // g
                    bass.note(19, .5);
                    bass.note(26, .5);

                    // c
                    bass.note(24, .5);
                    bass.note(19, .5);
                    /*bass.note(24, .5);
                    bass.note(16, .5);*/

                    // f
                    bass.note(17, .5);
                    bass.note(24, .5);
                    bass.note(17, .5);
                    if (j == 0) {
                        bass.note(24, .5);
                    } else {
                        bass.note(26, .5);
                    }
                }

                for (0=>int j; j < 8; j++) {
                    // gm
                    bass.note(19, .5);
                    bass.note(26, .5);
                    bass.note(19, .5);

                    // c
                    bass.note(24, .5);

                    // f
                    bass.note(17, .5);
                    bass.note(24, .5);
                    bass.note(17, .5);

                    if (j != 7) {
                        // d
                        bass.note(26, .5);
                    } else {
                        bass.note(24, .5);
                    }
                }
            }
            else
            {
                for (0=>int j; j < 2; j++) {
                    bass.note(19, .5);
                    bass.note(-1, .25);
                    bass.note(24, 1);
                    bass.note(-1, .25);

                    if (j != 1) {
                        bass.note(17, .5);
                        bass.note(-1, .25);
                        bass.note(26, 1);
                        bass.note(-1, .25);
                    }
                    else
                    {
                        bass.note(17, 2);
                    }
                }
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

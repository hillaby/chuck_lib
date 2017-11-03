public class Bass
{
    ABSndBuf bass;
    bass.connect(LPF lpf);
    bass.read(
        "bass-elec2-E-octave0.wav",
        16
    );
    bass.set_gain(1.3);

    SinOsc sin => ADSR adsr => lpf;
    //TriOsc tri => adsr => lpf;
    adsr.set( 30::ms, 4::ms, .9, 100::ms );
    sin.gain(1.7);

    lpf=>Gain gain;
    360=>lpf.freq;

    off();
    spork ~ play();

    0=>int what_to_play;

    public void bass_note(float n, float d)
    {
        spork~bass.note(n, d);
        if (n >= 0) {
            n => Std.mtof => sin.freq;
            //n+24 => Std.mtof => tri.freq;
            adsr.keyOn();
            .6*d=>AATimer.advance;
            adsr.keyOff();
            .4*d=>AATimer.advance;
        } else {
            d=>AATimer.advance;
        }
    }

    public void bass_pattern(float n1, float n2)
    {
        bass_note(n1, .5);
        bass_note(-1, .25);
        bass_note(n1, .25);
        bass_note(n2, .25);
        bass_note(n2, .25);
        bass_note(n2, .25);
        bass_note(n1, .25);

        bass_note(-1, .75);
        bass_note(n1, .25);
        bass_note(n2, .25);
        bass_note(n2, .25);
        bass_note(n2, .25);
        bass_note(n1, .25);
    }

    public void play()
    {
        while(true)
        {
            if (what_to_play == 0)
            {
                // c minor
                bass_pattern(24, 31);

                // b augmented
                bass_pattern(23, 31);

                // es
                bass_pattern(22, 31);

                // f septim
                bass_pattern(21, 29);

                // as
                bass_pattern(20, 27);

                // g septim
                bass_pattern(19, 26);

                // c major septim
                bass_pattern(24, 31);

                // e septim
                //bass_pattern(20, 26);

                // bb septim
                bass_pattern(22, 29);

                // a minor
                bass_pattern(21, 28);

                // gisz augmented
                bass_pattern(20, 28);

                // c
                bass_pattern(19, 28);

                // d septim
                bass_pattern(18, 26);

                // f
                bass_pattern(17, 24);

                // g
                bass_pattern(19, 26);

                // gis
                bass_pattern(20, 27);

                // cis septim
                bass_pattern(25, 32);
            }
            else
            {
                bass_pattern(24, 31);
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

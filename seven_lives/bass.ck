public class Bass
{
    ABSndBuf bass;
    bass.connect(LPF lpf);
    bass.read(
        "bass-elec2-E-octave0.wav",
        16
    );
    bass.set_gain(.9);

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
                // g minor
                bass.note(19, .5);
                bass.note(22, .5);
                bass.note(26, .5);

                // d septim
                bass.note(18, .833);
                bass.note(21, .667);
                bass.note(26, .5);

                // g minor
                bass.note(19, .5);
                bass.note(22, .5);
                bass.note(26, .5);

                // d septim
                bass.note(18, .833);
                bass.note(21, .667);

                // g septim
                bass.note(23, .5);

                // C minor
                bass.note(24, .5);
                bass.note(27, .5);
                bass.note(31, .5);

                // Bb
                bass.note(22, .833);
                bass.note(26, .667);
                bass.note(29, .5);

                // G#
                bass.note(20, .5);
                bass.note(24, .5);
                bass.note(27, .5);

                // g minor
                bass.note(19, .833);
                bass.note(22, .667);
                bass.note(26, .5);

                // D septim
                bass.note(18, .5);
                bass.note(21, .5);
                bass.note(26, .5);

                // C septim
                bass.note(16, .833);
                bass.note(19, .667);
                bass.note(24, .5);

                 // D#
                bass.note(19, .5);
                bass.note(22, .5);
                bass.note(27, .5);

                // D septim
                bass.note(18, .833);
                bass.note(21, .667);
                bass.note(26, .5);

                // C minor
                bass.note(24, .5);
                bass.note(27, .5);
                bass.note(31, .5);

                // Bb
                bass.note(22, .833);
                bass.note(26, .667);
                bass.note(29, .5);

                // G#
                bass.note(20, .5);
                bass.note(24, .5);
                bass.note(27, .5);

                // g minor
                bass.note(19, .833);
                bass.note(22, .667);
                bass.note(26, .5);
            }
            else
            {
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

public class Bass
{
    LPF lpf=>Gain gain;
    300=>lpf.freq;
    ABSndBuf bass;
    bass.connect(lpf);
    bass.read(
        "bass-elec2-E-octave0.wav",
        16
    );
    bass.set_gain(1.5);
    
    
    off();
    spork ~ play();
    
    0=>int what_to_play;
    
   
    public void play()
    {
        while(true)
        {
            if (what_to_play == 0)
            {
                bass.note(21, .25);
                bass.note(-1, .5);
                bass.note(26, .75);
                bass.note(-1, .5);
                //bass.note(24, .25);
                bass.note(-1, .25);
                bass.note(23, .25);
                bass.note(-1, .25);
                bass.note(21, .25);
                bass.note(-1, .25);
                //bass.note(23, .75);
                //bass.note(28, .75);
                bass.note(18, .25);
                bass.note(-1, .25);
                bass.note(20, .25);
                //bass.note(20, .25);
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
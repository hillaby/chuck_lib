public class Bass
{
    SndBuf bass => ADSR bass_adsr => Gain gain;
    "bass-elec2-E-octave0.wav" => bass.read;
    bass.samples() => bass.pos;
    bass_adsr.set( 1::ms, 4::ms, .9, 100::ms ); 
   
    off();
    spork ~ play();
    
    public void bass_note(float n, float d)
    {
        0+=>n;
        //Std.mtof(n) => ref.freq;
        // 91 => g6
        Std.mtof(n)/Std.mtof(16) /*+ Std.randf()*.012*/ => bass.rate;
        0=>bass.pos;
        //0=>sax.pos;
        bass_adsr.keyOn();
        .8*d => AATimer.advance;
        .2*d*AATimer.get_T() => bass_adsr.releaseTime;
        bass_adsr.keyOff();
        bass_adsr.keyOff();
        .2*d => AATimer.advance;
    }
    
    0=>int what_to_play;
    public void play()
    {
        while(true)
        {
            if (what_to_play == 0)
            {
                for (0=>int i; i<2; i++)
                {
                    bass_note(19, .5);
                    bass_note(26, .5);
                    bass_note(19, .5);
                    bass_note(26, .5);
                    bass_note(19, .5);
                    bass_note(25, .5);
                    bass_note(26, .5);
                    bass_note(21, .5);
                    
                    bass_note(17, .5);
                    bass_note(24, .5);
                    bass_note(17, .5);
                    bass_note(24, .5);
                    bass_note(17, .5);
                    bass_note(18, .5);
                    bass_note(19, .5);
                    bass_note(26, .5);
                }
                for (0=>int i; i<2; i++)
                {
                    bass_note(22, .5);
                    bass_note(17, .5);
                    bass_note(24, .5);
                    bass_note(19, .5);
                    bass_note(22, .5);
                    bass_note(17, .5);
                    bass_note(24, .5);
                    bass_note(19, .5);
                    
                    bass_note(17, .5);
                    bass_note(24, .5);    
                    bass_note(22, .5);
                    bass_note(17, .5);
                    bass_note(24, .5);
                    bass_note(19, .5);
                    bass_note(24, .5);
                    bass_note(24, .25);
                    if (i == 0)
                        bass_note(23, .25);      
                    else
                        bass_note(25, .25); 
                }
                bass_note(26, .75);
                bass_note(21, 1.25);
            }
            else
            {

            }
            //.5=>now;
        }            
    }
    
    public void set_what_to_play(int w)
    {
        w=>what_to_play;
    }
    
    public void connect(UGen ug)
    {
        gain => ug;
    }
    
    public void on(float g)
    {
        g=>gain.gain;
    }
    
    public void off()
    {
        0=>gain.gain;
    }
}
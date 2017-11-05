public class Bass
{
    SndBuf bass => ADSR bass_adsr => Gain gain;
    "f-1A.wav" => bass.read;
    1 => bass.gain;
    bass_adsr.set( 1::ms, 4::ms, .9, 100::ms ); 
   
    off();
    spork ~ play();
    
    public void bass_note(float n, float d)
    {
        //Std.mtof(n) => ref.freq;
        // 91 => g6
        Std.mtof(n)/Std.mtof(21) + Std.randf()*.012 => bass.rate;
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
                bass_note(24, .5);
                bass_note(26, .5);
                if (Std.randf() > -0.4)
                {
                    bass_note(19, .5);
                }
                else
                {
                    bass_note(31, .5);
                }
                if (Std.randf() > -0.1)
                {
                    bass_note(22, .5);
                }
                else
                {
                    bass_note(25, .5);
                }
            }
            else
            {
                bass_note(24, .375);
                bass_note(30, .125);
                bass_note(31, .125);
                bass_note(31, .125);
                bass_note(31, .125);
                bass_note(31, .125);
                1=>AATimer.advance;
            }
            //.5=>AATimer.advance;
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
public class Bass
{
    // sync
    1300::ms => dur T;
    T - (now % (2*T)) => now;
    
    /*SqrOsc ref => Gain gain;
    .03 => ref.gain;*/
    
    SndBuf bass => ADSR bass_adsr => Gain gain;
    "bass-elec2-E-octave0.wav" => bass.read;
    1 => bass.gain;
    bass_adsr.set( 1::ms, 4::ms, .9, 100::ms ); 
   
    off();
    spork ~ play();
    
    0=>int note_is_on;
    
    public void bass_note(float n, float t_rel)
    {
       
        //Std.mtof(n) => ref.freq;
        // 91 => g6
        Std.mtof(n)/Std.mtof(15.35)  /*+Std.randf()*.007*/ => bass.rate;
        //Std.mtof(n)/Std.mtof(15.55)  /*+Std.randf()*.007*/ => bass.rate;
        0=>bass.pos;
        //0=>sax.pos;
        .001*(t_rel::T) => now;
        bass_adsr.keyOn();
        1=>note_is_on;
        .799*(t_rel::T) => now;
        0=>note_is_on;
        .2*(t_rel::T) => bass_adsr.releaseTime;
        bass_adsr.keyOff();
        bass_adsr.keyOff();
        .2*(t_rel::T) => now;
        
    }
    
    1=>int what_to_play;
    public void play()
    {
        while(true)
        {
            if (what_to_play == 0)
            {
                bass_note(21, 1);
                bass_note(25, .375);
                bass_note(21, .375);
                bass_note(23, .125);
                bass_note(25, .125);
                
                bass_note(21, 1);
                bass_note(26, .375);
                bass_note(21, .375);
                bass_note(23, .125);
                bass_note(25, .125);
                
                bass_note(21, 1);
                bass_note(28, .375);
                bass_note(21, .375);
                bass_note(23, .125);
                bass_note(25, .125);
                
                bass_note(21, 1);
                bass_note(26, .375);
                bass_note(21, .375);
                bass_note(23, .125);
                bass_note(25, .125);
                
                bass_note(21, 1);
                bass_note(25, .375);
                bass_note(21, .375);
                bass_note(23, .125);
                bass_note(25, .125);
                
                bass_note(21, 1);
                bass_note(26, .375);
                bass_note(21, .375);
                bass_note(23, .125);
                bass_note(25, .125);
                
                bass_note(21, 1);
                bass_note(28, .375);
                bass_note(21, .375);
                bass_note(23, .125);
                bass_note(25, .125);
                
                bass_note(21, 1);
                bass_note(21, .5);
                /*bass_note(23, .25);
                bass_note(25, .25);*/
                bass_note(23, .5);
            }
            else if(what_to_play == 1)
            {
                1::T=>now;
            }
            else if(what_to_play == 2)
            {
                bass_note(26, .75);
                bass_note(21, .75);
                bass_note(26, .25);
                bass_note(27, .25);
                
                bass_note(28, .75);
                bass_note(23, .75);
                bass_note(28, .25);
                bass_note(27, .25);
                
                bass_note(26, .75);
                bass_note(21, .75);
                bass_note(26, .25);
                bass_note(27, .25);
                
                bass_note(28, .75);
                bass_note(23, .75);
                bass_note(16, .25);
                bass_note(18, .25);
                
                bass_note(19, .75);
                bass_note(24, .75);
                bass_note(28, .25);
                bass_note(27, .25);     

                bass_note(26, .75);
                bass_note(21, .75);
                bass_note(16, .25);
                bass_note(18, .25); 
                
                bass_note(19, .75);
                bass_note(24, .75);
                bass_note(28, .25);
                bass_note(27, .25);     

                bass_note(26, .75);
                bass_note(21, .75);
                bass_note(19, .25);
                bass_note(18, .25); 
                
                bass_note(16, 2);
                
                bass_note(22, .75);
                bass_note(22, .25);
                bass_note(17, .5);
                bass_note(19, .5);  

                //////////////////////
                
                bass_note(26, .75);
                bass_note(21, .75);
                bass_note(26, .25);
                bass_note(27, .25);
                
                bass_note(28, .75);
                bass_note(23, .75);
                bass_note(28, .25);
                bass_note(27, .25);
                
                bass_note(26, .75);
                bass_note(21, .75);
                bass_note(26, .25);
                bass_note(27, .25);
                
                bass_note(28, .75);
                bass_note(23, .75);
                bass_note(16, .25);
                bass_note(18, .25);
                
                bass_note(19, .75);
                bass_note(24, .75);
                bass_note(28, .25);
                bass_note(27, .25);     

                bass_note(26, .75);
                bass_note(21, .75);
                bass_note(16, .25);
                bass_note(18, .25); 
                
                bass_note(19, .75);
                bass_note(24, .75);
                bass_note(28, .25);
                bass_note(27, .25);     

                bass_note(26, .75);
                bass_note(21, .75);
                bass_note(19, .25);
                bass_note(21, .25); 
            }
            else if(what_to_play == 3)
            {
                bass_note(23, .75);
                bass_note(26, .75);   
                bass_note(26, .25);   
                bass_note(25, .25);
                
                bass_note(24, .75);
                bass_note(19, .75);   
                bass_note(21, .25);   
                bass_note(22, .25);                
            }
            else if(what_to_play == 4)
            {
                bass_note(26, .75);
                bass_note(21, 1.25);
                bass_note(16, .75);  
                bass_note(20, 1.25);                
            }
            else
            {
                bass_note(26, 8);    
            }
            //.5=>now;
        }            
    }
    
    public void set_what_to_play(int w)
    {
        w=>what_to_play;
    }
    
    public void set_T(dur t)
    {
        if (note_is_on)
        {
            <<<"NNOOTTEE IISS OONN">>>;
            me.exit();
        }
        t=>T;    
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
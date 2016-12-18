public class MyFlute
{
    SndBuf flute0 => ADSR flute0_adsr => Gain gain;
    "flute-C-octave0.wav" => flute0.read;
    flute0.samples() => flute0.pos;
    flute0_adsr.set( 1::ms, 4::ms, .9, 100::ms ); 
    
    SndBuf flute1 => ADSR flute1_adsr => gain;
    "flute-C-octave1.wav" => flute1.read;
    flute1.samples() => flute1.pos;
    flute1_adsr.set( 1::ms, 4::ms, .9, 100::ms ); 

    SndBuf flute2 => ADSR flute2_adsr => gain;
    "flute-C-octave2.wav" => flute2.read;
    flute2.samples() => flute2.pos;
    flute2_adsr.set( 1::ms, 4::ms, .9, 100::ms ); 
     
   
    off();
        
    public void flute_note(float n, float d)
    {
        
        if (n < 0)
        {
            d=>AATimer.advance;
            return;
        }
        
        // transpose +5
        //5 +=> n;

        if (n < 42)//(n < 42)
        {
            //<<<"1">>>;
            Std.mtof(n)/Std.mtof(36) /*+ Std.randf()*.012*/ => flute0.rate;
            3000=>flute0.pos;
            flute0_adsr.keyOn();
            .8*d => AATimer.advance;
            .2*d*AATimer.get_T() => flute0_adsr.releaseTime;
            flute0_adsr.keyOff();
            .2*d => AATimer.advance;
        }
        else if (n < 54)//(n < 54)
        {
            //<<<"2">>>;
            Std.mtof(n)/Std.mtof(48) /*+ Std.randf()*.012*/ => flute1.rate;
            2000=>flute1.pos;
            flute1_adsr.keyOn();
            .8*d => AATimer.advance;
            .2*d*AATimer.get_T() => flute1_adsr.releaseTime;
            flute1_adsr.keyOff();
            .2*d => AATimer.advance;
        }
        else
        {
            //<<<"3">>>;
            Std.mtof(n)/Std.mtof(60) /*+ Std.randf()*.012*/ => flute2.rate;
            2000=>flute2.pos;
            flute2_adsr.keyOn();
            .8*d => AATimer.advance;
            .2*d*AATimer.get_T() => flute2_adsr.releaseTime;
            flute2_adsr.keyOff();
            .2*d => AATimer.advance;
        }

    }
    
    0=>int what_to_play;
    public void play()
    {
        flute0.gain(1);
        flute1.gain(1);
        flute2.gain(1);
        while(true)
        {
            if (what_to_play == 0)
            {
                for (0=>int i; i<2; i++)
                {
                    flute_note(-1, .25);
                    flute_note(59, .125);
                    flute_note(57, .125);
                    flute_note(59, .5);
                    
                    flute_note(-1, .25);
                    flute_note(59, .125);
                    flute_note(57, .125);
                    flute_note(59, .5);
                    
                    flute_note(60, .5);
                    flute_note(59, .375);
                    flute_note(57, .125);
                    
                    flute_note(57, .5);
                    flute_note(-1, .5);
                    
                    ///////////////////
                    
                    flute_note(-1, .25);
                    flute_note(57, .125);
                    flute_note(55, .125);
                    flute_note(57, .5);
                    
                    flute_note(-1, .25);
                    flute_note(57, .125);
                    flute_note(55, .125);
                    flute_note(57, .5);
                    
                    flute_note(57, .5);
                    flute_note(59, .375);
                    flute_note(57, .125);
                    
                    flute_note(55, .5);
                    flute_note(-1, .5);
                }
                
                for (0=>int i; i<2; i++)
                {
                    flute_note(-1, .25);
                    flute_note(50, .125);
                    flute_note(48, .125);
                    flute_note(50, .125);
                    flute_note(48, .125);
                    flute_note(50, .125);
                    flute_note(53, .125);
                    
                    flute_note(55, .25);
                    flute_note(52, .25);
                    flute_note(52, .25);
                    flute_note(52, .125);
                    flute_note(48, .125);
                    //////
                    flute_note(-1, .25);
                    flute_note(50, .125);
                    flute_note(48, .125);
                    flute_note(50, .125);
                    flute_note(48, .125);
                    flute_note(50, .125);
                    flute_note(53, .125);
                    
                    flute_note(55, .25);
                    flute_note(52, .25);
                    flute_note(52, .25);
                    flute_note(52, .125);
                    flute_note(48, .125);
                    ///////////
                    flute_note(-1, .25);
                    flute_note(45, .125);
                    flute_note(43, .125);
                    flute_note(45, .5);
                    
                    flute_note(46, .125);
                    flute_note(41, .125);
                    flute_note(41, .5);
                    flute_note(-1, .25);    

                    flute_note(40, .125);
                    flute_note(38, .125);
                    flute_note(40, 1);
                    
                    //flute_note(-1, 1);
                    
                    flute_note(-1, .5);
                    
                    if (i == 0)
                    {
                        flute_note(-1, .25);
                    }
                    else
                    {
                        flute_note(40, .125);
                        flute_note(40, .125);
                    }                    
                    ///////////
                   
                }   
                
                flute_note(42, .75);
                flute_note(50, 1.25);
                                          
            }
            else
            {
                for (0=>int i; i<2; i++)
                {
                    flute_note(-1, .25);
                    flute_note(55, .125);
                    flute_note(55, .125);
                    flute_note(55, .5);
                    
                    flute_note(-1, .25);
                    flute_note(55, .125);
                    flute_note(55, .125);
                    flute_note(55, .5);
                    
                    flute_note(55, .5);
                    flute_note(52, .375);
                    flute_note(53, .125);
                    
                    flute_note(54, .5);
                    flute_note(-1, .5);
                    
                    ///////////////////
                    
                    flute_note(-1, .25);
                    flute_note(53, .125);
                    flute_note(53, .125);
                    flute_note(53, .5);
                    
                    flute_note(-1, .25);
                    flute_note(53, .125);
                    flute_note(53, .125);
                    flute_note(53, .5);
                    
                    flute_note(53, .5);
                    flute_note(52, .375);
                    flute_note(51, .125);
                    
                    flute_note(50, .5);
                    flute_note(-1, .5);
                }
                
                for (0=>int i; i<2; i++)
                {
                    flute_note(-1, .25);
                    flute_note(46, .125);
                    flute_note(45, .125);
                    flute_note(46, .125);
                    flute_note(45, .125);
                    flute_note(46, .125);
                    flute_note(50, .125);
                    
                    flute_note(52, .25);
                    flute_note(48, .25);
                    flute_note(48, .25);
                    flute_note(48, .125);
                    flute_note(45, .125);
                    //////
                    flute_note(-1, .25);
                    flute_note(46, .125);
                    flute_note(45, .125);
                    flute_note(46, .125);
                    flute_note(45, .125);
                    flute_note(46, .125);
                    flute_note(50, .125);
                    
                    flute_note(52, .25);
                    flute_note(48, .25);
                    flute_note(48, .25);
                    flute_note(48, .125);
                    flute_note(45, .125);
                    ///////////
                    flute_note(-1, .25);
                    flute_note(41, .125);
                    flute_note(41, .125);
                    flute_note(41, .5);
                    
                    flute_note(41, .125);
                    flute_note(38, .125);
                    flute_note(38, .5);
                    flute_note(-1, .25);    

                    flute_note(36, .125);
                    flute_note(35, .125);
                    flute_note(36, 1);
                    
                    //flute_note(-1, 1);
                    
                    flute_note(-1, .5);
                    
                    if (i == 0)
                    {
                        flute_note(-1, .25);
                    }
                    else
                    {
                        flute_note(36, .125);
                        flute_note(36, .125);
                    }                    
                    ///////////
                   
                }   
                
                flute_note(38, .75);
                flute_note(45, 1.25);
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
        spork ~ play();
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

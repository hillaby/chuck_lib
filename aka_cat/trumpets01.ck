public class Trumpets01
{
    Brass  s => Chorus c => Pan2 pan;
    pan.left=>Gain gainLeft;
    pan.right=>Gain gainRight;
    //Brass  s => Gain gain;
    //Chorus c;
    pan => Echo e => HPF hpf => Gain fb => pan;
    .7=>fb.gain;
    
    1200 => hpf.freq;
    
    1::AATimer.get_T()/.125::AATimer.get_T() => c.modFreq; //- ( float , READ/WRITE ) - modulation frequency
    .3 => c.modDepth; //- ( float , READ/WRITE ) - modulation depth
    .38 => c.mix; //- ( float , READ/WRITE ) - effect mix
    //.38 => c.mix; //- ( float , READ/WRITE ) - effect mix

    
    // set feedback
    //.95 => feedback.gain;
    // set effects mix
    //.6 => d.gain; 
    
    //(1.0/16.0)::T => d.delay => d.max;
    //(1.0/4.0)::T => d.delay => d.max;
    (1.0/4.0)::AATimer.get_T() => e.delay;
    .25 => e.mix;
    1::AATimer.get_T() => e.max;
    
    .6 => s.gain;
    .6 => s.volume;

    .7 => s.lip;
    .9 => s.slide;
    2 => s.vibratoFreq;
    .9 => s.vibratoGain;
    
    0 => int what_to_play;
    
    off();
    spork ~ play();
    spork ~ movePan();
    
    public void notesOn(float f)
    {

        Std.mtof(f + Std.randf() * .02) => s.freq;

        3.0 => s.startBlowing;
    }
    
    public void notesOff()
    {
        10 => s.stopBlowing;

    }
    
    public void movePan()
    {
        while(true)
        {
            for(0=>int i; i < 100; i++)
            {
                Math.sin(((i/50.0)-0.5)*pi) * 0.5=> pan.pan;
                1.0/100.0 => AATimer.advance;
            }
        }        
    }

    public void play()
    {
        // infinite time loop
        while( true )
        {
            if (what_to_play == 0)
            {
                //.8 => s.startBlowing;
                notesOn(91);
                .125 => AATimer.advance;
                notesOff();
                notesOn(94);
                .125 => AATimer.advance;   
                notesOff();   
                .125 => AATimer.advance;          
                notesOn(94);
                .125 => AATimer.advance;  
                notesOff(); 
                .5=>AATimer.advance;
                
                //////////
                
                 //.8 => s.startBlowing;
                notesOn(93);
                .125 => AATimer.advance;
                notesOff();
                notesOn(89);
                .125 => AATimer.advance;   
                notesOff();   
                .125 => AATimer.advance;          
                notesOn(89);
                .125 => AATimer.advance;  
                notesOff(); 
                .5=>AATimer.advance;   

                ///////////////

                //.8 => s.startBlowing;
                notesOn(91);
                .125 => AATimer.advance;
                notesOff();
                notesOn(88);
                .125 => AATimer.advance;   
                notesOff();   
                .125 => AATimer.advance;          
                notesOn(88);
                .125 => AATimer.advance;  
                notesOff(); 
                .5=>AATimer.advance;
                
                //////////
                
                 //.8 => s.startBlowing;
                notesOn(88);
                .125 => AATimer.advance;
                notesOff();
                notesOn(89);
                .125 => AATimer.advance;   
                notesOff();   
                .125 => AATimer.advance;          
                //notesOn(89);
                .125 => AATimer.advance;  
                notesOff(); 
                .5=>AATimer.advance;       
            }
            else
            {
                .125 => AATimer.advance;  
                notesOn(94);
                .125 => AATimer.advance;   
                notesOff();   
                .125 => AATimer.advance;          
                notesOn(94);
                .125 => AATimer.advance;  
                notesOff();  
                .125 => AATimer.advance;  
                notesOn(94);
                .125 => AATimer.advance;   
                notesOff();   
                .125 => AATimer.advance;          
                notesOn(94);
                .125 => AATimer.advance;  
                notesOff(); 
                /////////////////////////  
                .125 => AATimer.advance;  
                notesOn(93);
                .125 => AATimer.advance;   
                notesOff();   
                .125 => AATimer.advance;          
                notesOn(93);
                .125 => AATimer.advance;  
                notesOff();  
                .125 => AATimer.advance;  
                notesOn(93);
                .125 => AATimer.advance;   
                notesOff();   
                .125 => AATimer.advance;          
                notesOn(93);
                .125 => AATimer.advance;  
                notesOff();                 
            }
        }
    }
    
    public void mod_trumpets()
    {
        LPF lpf2 => HPF hpf => pan;
        c =< pan;
        c => lpf2;
        float t;
        float step;
        while(true)
        {
            //<<< 90 + (Math.sin(t * pi) * 30.0 => Std.fabs) => Std.mtof >>>;
            90 + (Math.sin(t * pi) * 30.0 => Std.fabs) => Std.mtof => lpf2.freq;
            60 + (Math.sin(t * pi) * 30.0 => Std.fabs) => Std.mtof => hpf.freq;
            .025 +=> t;
            .05 => AATimer.advance;
        }
    }
    public void modulate_trumpets()
    {
        spork ~ mod_trumpets();
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
    
    public void set_what_to_play(int w)
    {
        w => what_to_play;
    }
}

public class Lead
{
    HPF hpf=>LPF lpf => Chorus ch => ADSR adsr => Pan2 pan;
    pan.left => Gain gainLeft;
    pan.right => Gain gainRight;
    adsr.set( 40::ms, 4::ms, .9, 1000::ms ); 
    ABSndBuf piano[3];
    300=>hpf.freq;
    .8=>ch.mix;
    8.0/(AATimer.get_T()/1::second) => ch.modFreq;
    .01=>ch.modDepth;
    
    for (0 => int i; i < piano.cap(); i++)
    {
        piano[i].connect(hpf);
        piano[i].read(
            //"../instruments/Berklee44V4/piano_D4.wav",
            //"../instruments/OpenPathMusic44V4/organ-tonewheel-octave2.wav",
            //"../instruments/OpenPathMusic44V4/piano-electric-tine-octave2.wav",
            "organ-tonewheel-octave2-mod.wav",
            48
        );
        piano[i].set_start_pos(0);
    }
    
    public void wah()
    {
        for (19=>int i; i < 1000; i++)
        {   
            //<<<i>>>;
            i*20 => lpf.freq;
            .007=>AATimer.advance;
        }       
    }
    
    public void lead_note(float n, float d)
    {
        spork~wah() @=> Shred ww;
        adsr.keyOn();
        piano[0].note(n, d*.9);
        adsr.keyOff();
        d*.1=>AATimer.advance;
        ww.exit();
    }
    
    
    off();
    spork ~ play();
    spork ~ movePan();
    
    0=>int what_to_play;
    
    public void movePan()
    {
        float t;
        while(true)
        {
            //<<<Math.sin(t)>>>;
            Math.cos(t) / 1.6 => pan.pan;
            (.06125/4)*pi+=>t;
            .06125=>AATimer.advance;
        }        
    }
    
    public void play()
    {
        while(true)
        {
            if (what_to_play == 0)
            {
                // D F G#
                lead_note(62, .5);
                lead_note(59, .25);
                lead_note(59, 1.75);
                lead_note(-1, .25);
                
                lead_note(56, .25);
                lead_note(59, .5);
                lead_note(62, .5); 

                lead_note(60, .333);
                lead_note(62, .333);
                lead_note(60, .166);                 
                lead_note(59, .167);                 
                lead_note(60, 1.5);   

                lead_note(-1, 1.5);     

                
                lead_note(60, .5);
                lead_note(57, .25);
                lead_note(57, 1.75);
                lead_note(-1, .25);
                
                lead_note(54, .25);
                lead_note(57, .5);
                lead_note(60, .5); 

                lead_note(58, .333);
                lead_note(60, .333);
                lead_note(58, .166);                 
                lead_note(57, .167);                 
                lead_note(58, 1.5);   

                lead_note(-1, 1.5);    
                

                lead_note(58, .5);
                lead_note(54, .25);
                lead_note(54, 1.75);
                lead_note(-1, .25);
                
                lead_note(54, .25);
                lead_note(56, .5);
                lead_note(58, .5); 

                lead_note(60, .333);
                lead_note(61, .333);
                lead_note(60, .166);                 
                lead_note(58, .167);                 
                lead_note(60, 1.5);   

                lead_note(-1, .25);

                lead_note(60, .25);
                lead_note(61, .5);
                lead_note(63, .5);
                
                lead_note(65, 4);
                
                lead_note(-1, 3.625);
                lead_note(65, .125);
                lead_note(64, .125);
                lead_note(63, .125);
            }
            else
            {                
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
public class Piano
{
    Gain gainLeft;
    Gain gainRight;
    LPF lpfLeft=>gainLeft;
    LPF lpfRight=>gainRight;
    lpfRight.freq(3000);
    lpfLeft.freq(3000);
    ABSndBuf piano[10];
    Pan2 pan[10];
    for (0 => int i; i < piano.cap(); i++)
    {
        piano[i].connect(pan[i]);
        ((i % 2) - 0.5) * 0.8 => pan[i].pan;
        pan[i].left => lpfLeft;
        pan[i].right => lpfRight;
        piano[i].read(
            //"../instruments/Berklee44V4/piano_D4.wav",
            //"../instruments/OpenPathMusic44V4/organ-tonewheel-octave2.wav",
            //"../instruments/OpenPathMusic44V4/piano-electric-tine-octave2.wav",
            //"../instruments/OpenPathMusic44V4/organ-tonewheel-octave2-mod-2.wav",
            "piano_D4.wav",
            50
        );
        piano[i].set_gain(.4);
    }
    
    
    off();
    spork ~ play();
    
    0=>int what_to_play;
    
    public void chord(float arr[], float dur)
    {
        if (arr[0]== -1)
        {
            dur=>AATimer.advance;
            return;
        }
        for (0 => int i; i < arr.cap(); i++)
        {
            spork~piano[i].note(arr[i], dur);
        }            
        dur=>AATimer.advance;
    }
   
    public void play()
    {
        chord([-1.0], .25);
        while(true)
        {
            if (what_to_play == 0)
            {
                // A
                //chord([-1.0], .25);

                if (0)//Std.randf() > -0.3)
                {
                    chord([45.0, 49.0, 52.0, 57.0], .25);
                    chord([49.0, 49.0, 52.0, 57.0], .25);
                }
                else
                {
                    chord([45.0, 49.0, 52.0, 57.0], .5);
                }
                
                // D                
                //chord([-1.0], .25);
                chord([52.0, 52.0, 57.0, 57.0], .5);
                if (1)//Std.randf() > -0.3)
                {
                    chord([45.0, 50.0, 54.0, 57.0], .25);      
                    chord([50.0, 50.0, 54.0, 57.0], .25);  
                }
                else
                {
                    chord([45.0, 50.0, 54.0, 57.0], .5);
                }                
                    
                // G 
                //chord([-1.0], .25);  
                chord([54.0, 54.0, 57.0, 57.0], .5);
                if (0)//Std.randf() > -0.3)
                {                    
                    chord([47.0, 50.0, 55.0, 59.0], .25);     
                    chord([50.0, 50.0, 55.0, 59.0], .25);  
                }
                else
                {
                    chord([47.0, 50.0, 55.0, 59.0], .5);
                }                
                     
                // E    
                //chord([-1.0], .25);
                chord([55.0, 55.0, 59.0, 59.0], .5);

                if (1)//Std.randf() > -0.3)
                {                  
                    chord([47.0, 52.0, 56.0, 59.0], .25);               
                    chord([52.0, 52.0, 56.0, 59.0], .25);  
                }
                else
                {  
                    chord([47.0, 52.0, 56.0, 59.0], .5); 
                }                
                 

                chord([56.0, 56.0, 59.0, 59.0], .5); 
               
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
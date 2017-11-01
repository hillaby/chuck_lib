public class Bass
{
    ABSndBuf bass;
    bass.connect(Gain gain);
    bass.read(
        "bass-elec2-E-octave0.wav",
        16
    );
    
    
    off();
    spork ~ play();
    
    0=>int what_to_play;
    
   
    public void play()
    {
        while(true)
        {
            if (what_to_play == 0)
            {
                bass.note(32, .75);
                bass.note(32, .25);
                
                bass.note(26, .5);
                bass.note(29, .5);
                
                bass.note(32, .75);
                bass.note(32, .25);
                
                bass.note(26, .5);
                bass.note(29, .5);
                
                
                bass.note(31, .75);
                bass.note(31, .25);
                
                bass.note(24, .5);
                bass.note(27, .5);  
                
                bass.note(31, .75);
                bass.note(31, .25);
                
                bass.note(24, .5);
                bass.note(27, .5); 
                

                bass.note(30, .75);
                bass.note(30, .25);
                
                bass.note(24, .5);
                bass.note(27, .5);  
                
                bass.note(30, .75);
                bass.note(30, .25);
                
                bass.note(24, .5);
                bass.note(27, .5);  
                
                
                bass.note(29, .75);
                bass.note(29, .25);
                
                bass.note(22, .5);
                bass.note(26, .5);  
                
                bass.note(29, .75);
                bass.note(29, .25);
                
                bass.note(22, .5);
                bass.note(26, .5);   
                
                
                bass.note(28, .75);
                bass.note(28, .25);
                
                bass.note(22, .5);
                bass.note(25, .5); 

                bass.note(28, .75);
                bass.note(28, .25);
                
                bass.note(22, .5);
                bass.note(25, .5); 
                
                
                
                bass.note(27, .75);
                bass.note(27, .25);
                
                bass.note(21, .5);
                bass.note(24, .5);  
                
            }
            else
            {           
                bass.note(-1, .75);               
                bass.note(17, .25);
                bass.note(19, .25);
                bass.note(22, .5);                                
                bass.note(19, .25);   
            }            
                
                
            if (what_to_play == 0)
            {  
                bass.note(27, .75);
                bass.note(27, .25);
                
                bass.note(21, .5);
                bass.note(24, .5); 
                
                bass.note(26, .75);
                bass.note(26, .25);
                
                bass.note(17, .5);
                bass.note(22, .5);  
                
                bass.note(26, .75);
                bass.note(26, .25);
                
                bass.note(17, .5);
                bass.note(22, .5);    
                
                

                bass.note(25, .75);
                bass.note(25, .25);
                
                bass.note(17, .5);
                bass.note(22, .5);  
                
                bass.note(25, .75);
                bass.note(25, .25);
                
                bass.note(29, .5);
                bass.note(31, .5);    
                
            }
            else
            {             
                bass.note(24.0, .75);
                bass.note(27.0, .25);
                bass.note(23.0, .5);
                bass.note(22.0, .25);                                
                bass.note(22.0, .25);               
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
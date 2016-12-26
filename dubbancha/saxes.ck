public class Saxes
{
    ABSndBuf saxes[2];
    Pan2 pans[2];
    saxes[0].connect(pans[0]);
    saxes[1].connect(pans[1]);
    saxes[0].set_gain(1.3);
    saxes[1].set_gain(1.0);
    saxes[0].read("saxophone-tenor-C-octave1.wav", 48);
    saxes[1].read("saxophone-tenor-C-octave1.wav", 48);

    saxes[0].set_start_pos(2000);
    saxes[1].set_start_pos(2000);
    
    pans[0].left => Gain gainLeft;
    pans[0].right => Gain gainRight;
    pans[1].left =>  gainLeft;
    pans[1].right =>  gainRight;
    
    pans[0].pan(0.5);
    pans[1].pan(-0.5);
    
    off();
    spork ~ play();
    
    0=>int what_to_play;
    
    public void sax_note(float n1, float n2, float d)
    {
        spork~saxes[0].note(n1, d);
        saxes[1].note(n2, d);
    }
    
    public void play()
    {
        while(true)
        {
            if (what_to_play == 0)
            {
                sax_note(-1, -1, 1.75);
                sax_note(54, 49, .25);
                sax_note(55, 50, .25);
                sax_note(52, 47, .25);
                sax_note(-1, -1, .25);
                sax_note(50, 45, .25);
                sax_note(-1, -1, .25);
                sax_note(49, 42, .25);
                sax_note(-1, -1, .25);
                sax_note(47, 44, .25);
                sax_note(-1, -1, 4);
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
    
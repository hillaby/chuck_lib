public class Trumpets
{
    ABSndBuf trumpets[2];
    Pan2 pans[2];
    trumpets[0].connect(pans[0]);
    trumpets[1].connect(pans[0]);
    trumpets[0].set_gain(1.2);
    trumpets[1].set_gain(1.0);
    trumpets[0].read("trpt-C-hi.wav", 60);
    trumpets[1].read("trpt-C-hi.wav", 60);

    
    pans[0].left => Gain gainLeft;
    pans[0].right => Gain gainRight;
    pans[1].left =>  gainLeft;
    pans[1].right =>  gainRight;
    
    pans[0].pan(-0.5);
    pans[1].pan(0.5);
    
    off();
    spork ~ play();
    
    0=>int what_to_play;
    
    public void trp_note(float n1, float n2, float d)
    {
        spork~trumpets[0].note(n1, d);
        trumpets[1].note(n2, d);
    }
    
    public void play()
    {
        while(true)
        {
            if (what_to_play == 0)
            {
                trp_note(-1, -1, .5);
                trp_note(69, 64, .25);
                trp_note(66, 62, 1.25);
                trp_note(-1, -1, 2);
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
    
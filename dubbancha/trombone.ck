public class Trombone
{
    ABSndBuf trombone[1];
    Pan2 pans[1];
    trombone[0].connect(pans[0]);
    trombone[0].set_gain(1.8);
    trombone[0].read("Trombone4.wav", 41);
    trombone[0].set_start_pos(6000);
    
    pans[0].left => Gain gainLeft;
    pans[0].right => Gain gainRight;
    
    pans[0].pan(0.5);
    
    off();
    spork ~ play();
    
    0=>int what_to_play;
    
    public void trb_note(float n1, float d)
    {
        trombone[0].note(n1, d);
    }
    
    public void play()
    {
        while(true)
        {
            if (what_to_play == 0)
            {
                trb_note(-1, 4);
                trb_note(-1, 1.75);
                trombone[0].gliss(42, 43, .5);
                trb_note(47, .5);
                trombone[0].gliss(43, 44, .5);
                trb_note(48, .75);
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
    
public class Piano01
{
    Pan2 pan1;
    Gain gainLeft;
    Gain gainRight;
    pan1.left=>gainLeft;
    pan1.right=>gainRight;
    SndBuf p => pan1;
    "piano_G6.wav" => p.read;
    0 => p.gain;
    
    Pan2 pan2;
    pan2.left=>gainLeft;
    pan2.right=>gainRight;
    SndBuf p2 => pan2;
    "piano_G6.wav" => p2.read;
    0 => p2.gain;
    
    pan1.pan(.5);
    pan2.pan(-0.5);
    
    off();
    spork ~ play();
    
    public void note(SndBuf p, float n)
    {
        // 91 => g6
        Std.mtof(n)/Std.mtof(91) => p.rate;
        0=>p.pos;
    }
    
    public void play()
    {
        while(true)
        {
            .22 => p.gain;
            .22 => p2.gain;
            note(p, 90);
            note(p2, 93);
            .125 => AATimer.advance;
                
            note(p, 91);
            note(p2, 94);
            .125 => AATimer.advance;
            
            note(p, 91);
            note(p2, 94);
            .125 => AATimer.advance;
            
            note(p, 91);
            note(p2, 94);
            .125 => AATimer.advance;
            
            note(p, 91);
            note(p2, 94);
            .125 => AATimer.advance;
            
            note(p, 91);
            note(p2, 94);
            .125 => AATimer.advance;
            
            note(p, 91);
            note(p2, 94);
            .125 => AATimer.advance;
            
            note(p, 91);
            note(p2, 94);
            .125 => AATimer.advance;
            
            /////////////////
            
            .4 => p.gain;
            .4 => p2.gain;
            note(p, 88);
            note(p2, 92);
            .125 => AATimer.advance;
                
            note(p, 89);
            note(p2, 93);
            .125 => AATimer.advance;
            
            note(p, 89);
            note(p2, 93);
            .125 => AATimer.advance;
            
            note(p, 89);
            note(p2, 93);
            .125 => AATimer.advance;
            
            note(p, 89);
            note(p2, 93);
            .125 => AATimer.advance;
            
            note(p, 89);
            note(p2, 93);
            .125 => AATimer.advance;
            
            note(p, 89);
            note(p2, 93);
            .125 => AATimer.advance;
            
            note(p, 89);
            note(p2, 93);
            .125 => AATimer.advance;
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
}
public class Conguero01
{
    // slap
    SndBuf slap;
    "conga-slap-1.wav" => slap.read;
    0 => slap.gain;
    
    SndBuf conga_open;
    "conga-open-1.wav" => conga_open.read;
    0 => conga_open.gain;
    
    SndBuf tumba_open;
    "tumba-open-1.wav" => tumba_open.read;
    0 => tumba_open.gain;
    
    SndBuf heel;
    "conga-muffled-1.wav" => heel.read;
    0 => heel.gain;
    
    Pan2 rightPan;
    conga_open=>rightPan;
    heel=>rightPan;
    slap=>rightPan;
    rightPan.left=>Gain gainLeft;
    rightPan.right=>Gain gainRight;
    rightPan.pan(-0.5);
    
    Pan2 leftPan;
    leftPan.left=>gainLeft;
    leftPan.right=>gainRight;
    leftPan.pan(0.5);
    tumba_open=>leftPan;  
    
   
    off();
    spork ~ play();
    
    // endless loop to play
    public void play()
    {
        while(true)
        {
            .3 => heel.gain;
            0 => heel.pos;
            
            .125 => AATimer.advance;
            
            .3 => slap.gain;
            0 => slap.pos;
            
            .125 => AATimer.advance;
            
            .8 => slap.gain;
            0 => slap.pos;
            
            .125 => AATimer.advance;
            
            .3 => slap.gain;
            0 => slap.pos;
            
            .125 => AATimer.advance;
            
            .3 => heel.gain;
            0 => heel.pos;
            
            .125 => AATimer.advance;
            
            .3 => slap.gain;
            0 => slap.pos;
            
            .125 => AATimer.advance;
            
            .9 => conga_open.gain;
            0 => conga_open.pos;
            
            .125 => AATimer.advance;       
            
            .7 => conga_open.gain;
            0 => conga_open.pos;
            
            .125 => AATimer.advance;

            //////////////////////////    

            .3 => heel.gain;
            0 => heel.pos;
            
            .125 => AATimer.advance;
            
            0 => int tumba_here;
            if (Std.randf() > 0.4) 1 => tumba_here;
            
            if (!tumba_here)
            {
                .3 => slap.gain;
                0 => slap.pos;
            }
            else
            {
                .5 => tumba_open.gain;
                0 => tumba_open.pos;               
            }
            
            .125 => AATimer.advance;
            
            .5 => slap.gain;
            0 => slap.pos;
            
            .125 => AATimer.advance;
            
            if (tumba_here || Std.randf() > -0.2)
            {
                                
                .7 => tumba_open.gain;
                0 => tumba_open.pos;
                
                .125 => AATimer.advance;       
                
                .5 => tumba_open.gain;
                0 => tumba_open.pos;
                
            }
            else
            {
            
                
                .3 => slap.gain;
                0 => slap.pos;
                
                .125 => AATimer.advance;
                
                .3 => heel.gain;
                0 => heel.pos;
                
            }
            
            .125 => AATimer.advance;     

            .3 => slap.gain;
            0 => slap.pos;
            
            .125 => AATimer.advance;
            
            .9 => conga_open.gain;
            0 => conga_open.pos;
            
            .125 => AATimer.advance;       
            
            .7 => conga_open.gain;
            0 => conga_open.pos;
            
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

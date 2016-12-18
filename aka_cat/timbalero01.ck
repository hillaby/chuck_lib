public class Timbalero01
{
    // stick
    SndBuf stick;
    "timbale-hi-crosstick-1.wav" => stick.read;
    0 => stick.gain;

    SndBuf cowbell;
    "cowbell-small-open.wav" => cowbell.read;
    0 => cowbell.gain;    
    
    SndBuf timballow;
    "timbale-lo-open-1.wav" => timballow.read;
    0 => timballow.gain;  
    
    SndBuf timbalhigh;
    "timbale-hi-open-1.wav" => timbalhigh.read;
    0 => timbalhigh.gain; 

    Pan2 rightPan;
    stick=>rightPan;
    timballow=>rightPan;
    rightPan.left=>Gain gainLeft;
    rightPan.right=>Gain gainRight;
    rightPan.pan(-0.5);
    
    Pan2 leftPan;
    leftPan.left=>gainLeft;
    leftPan.right=>gainRight;
    leftPan.pan(0.5);
    cowbell=>leftPan;
    timbalhigh=>leftPan;    
    
    
    off();
    spork ~ play();
    
    public void play()
    {
        while(true)
        {
            .3 => cowbell.gain;
            0 => cowbell.pos;
            
            .25 => AATimer.advance;
            
            .8 => stick.gain;
            0 => stick.pos;
            
            .25 => AATimer.advance;
            
            0 => stick.pos;    
            0 => cowbell.pos;    
            
            if (Std.randf() > -0.2)
            {
                .4 => timballow.gain;
                0 => timballow.pos;
            }

            .25 => AATimer.advance; 

            .4 => timbalhigh.gain;
            0 => timbalhigh.pos;                      
            
            .125 => AATimer.advance;
            
            .125 => AATimer.advance;
            
            ///////////
            
            0 => cowbell.pos;
            0 => stick.pos;  
            
            .125 => AATimer.advance;
            
            .25 => AATimer.advance;
            
            0 => stick.pos;    
            
            .125 => AATimer.advance;
            
            0 => cowbell.pos;

            .25 => AATimer.advance;
            
            0 => stick.pos; 
            
            .25 => AATimer.advance;            
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

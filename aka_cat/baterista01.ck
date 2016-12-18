public class Baterista01
{
    Gain mono => Gain gainLeft;
    mono => Gain gainRight;
    
    SndBuf hihat;
    "cymbal-hihat-open-stick-1.wav" => hihat.read;
    0 => hihat.gain;
    
    SndBuf hhclose;
    "cymbal-hihat-stick.wav" => hhclose.read;
    0 => hhclose.gain;
    
    SndBuf snare;
    "drum-snare-tap.wav" => snare.read;
    0 => snare.gain;

    SndBuf bass => mono;
    "drum-bass-lo-1.wav" => bass.read;
    0 => bass.gain;
    
    
    Pan2 snarePan;
    snare=>snarePan;
    snarePan.left=>gainLeft;
    snarePan.right=>gainRight;
    snarePan.pan(0.5);
    
    Pan2 hihatPan;
    hihatPan.left=>gainLeft;
    hihatPan.right=>gainRight;
    hihatPan.pan(-0.5);
    hihat=>hihatPan;
    hhclose=>hihatPan;

   
    off();
    spork ~ play();
    
    public void play()
    {
        while(true)
        {
            //<<<"lkjloj">>>;
            .5 => hhclose.gain;
            0 => hhclose.pos;
            
            1 => bass.gain;
            0 => bass.pos;
            
            .25 => AATimer.advance;
             
            .2 => hhclose.gain;
            0 => hhclose.pos;  
            
            .125 => AATimer.advance;
            
            .2 => hhclose.gain;
            0 => hhclose.pos;            
            .125 => AATimer.advance;
            
            0 => bass.pos;
            
            .5 => hhclose.gain;
            0 => hhclose.pos;          
            .25 => AATimer.advance; 

            //.4 => hhclose.gain;
            //0 => hhclose.pos;  
            0 => bass.pos;
            1 => snare.gain;
            0 => snare.pos;
            .125 => AATimer.advance;
            
            //.4 => hhclose.gain;
           // 0 => hhclose.pos;   
            .125 => AATimer.advance;
            
            ///////////
            
            if(Std.randf() > 0.4)
            {
                .7 => hihat.gain;
                0 => hihat.pos;
            }
            else
            {
                .5 => hhclose.gain;
                0 => hhclose.pos;                 
            }

            .25 => AATimer.advance;
            
            .2 => hhclose.gain;
            0 => hhclose.pos;              
            .125 => AATimer.advance;
            
            if(Std.randf() > -0.3)
            {
                1 => snare.gain;
                0 => snare.pos;
            }
            else
            {
                .2 => hhclose.gain;
                0 => hhclose.pos;  
            }
            
            .125 => AATimer.advance;
 
            .25 => AATimer.advance;
            
            0 => bass.pos;
            1 => snare.gain;
            0 => snare.pos;
            if(Std.randf() > 0.4)
            {
                .5 => hihat.gain;
                0 => hihat.pos;
                .25 => AATimer.advance;  
            }
            else
            {
                 .2 => hhclose.gain;
                0 => hhclose.pos;              
                .125 => AATimer.advance;
                
                .2 => hhclose.gain;
                0 => hhclose.pos;  
                .125 => AATimer.advance;               
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
}
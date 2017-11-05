public class Baterista
{
    Gain gainLeft;
    Gain gainRight;

    Echo echoLeft => gainLeft => Gain feedbackLeft => echoLeft;

    (1.0/8.0)::AATimer.get_T() => echoLeft.delay;
    .2 => echoLeft.mix;
    //.0=>echo.mix;
    1::AATimer.get_T() => echoLeft.max;
    .6 => feedbackLeft.gain;
    
    Echo echoRight => gainRight => Gain feedbackRight => echoRight;

    (1.0/8.0)::AATimer.get_T() => echoRight.delay;
    .2 => echoRight.mix;
    //.0=>echo.mix;
    1::AATimer.get_T() => echoRight.max;
    .6 => feedbackRight.gain;
    
    Pan2 rightPan;
    rightPan.left => echoLeft;
    rightPan.right => echoRight;
    rightPan.pan(0.4);
    
    Pan2 leftPan;
    leftPan.left => echoLeft;
    leftPan.right => echoRight;
    leftPan.pan(-0.4);
    
    Gain mono;
    mono=>echoLeft;
    mono=>echoRight;
        
    SndBuf hihat => rightPan;
    "cymbal-hihat-open-stick-1.wav" => hihat.read;
    0 => hihat.gain;
    
    SndBuf hhclose => rightPan;
    "cymbal-hihat-stick.wav" => hhclose.read;
    0 => hhclose.gain;
    
    SndBuf snare => leftPan;
    "drum-snare-tap.wav" => snare.read;
    0 => snare.gain;

    SndBuf bass => mono;
    "drum-bass-lo-1.wav" => bass.read;
    0 => bass.gain;
    
    SndBuf tom => leftPan;
    "drum-tom-hi-tap.wav" => tom.read;
    0 => tom.gain; 
        
    SndBuf snroll => leftPan;
    "drum-snare-roll-long.wav" => snroll.read;
    0 => snroll.gain;  
    
    
    off();
    spork ~ play();
    
    0=>int what_to_play;
    
    public void play()
    {
        while(true)
        {
            if (what_to_play == 0)
            {
                1=>bass.gain;
                0 => bass.pos;
                .125=>AATimer.advance;
                .7=>tom.gain;
                0=>tom.pos;
                .125=>AATimer.advance;
                .5=>hihat.gain;
                0=>hihat.pos;
                .25=>AATimer.advance;
                0=>bass.pos;
                .25=>AATimer.advance;
                1=>snroll.gain;
                0=>snroll.pos;
                .25 => AATimer.advance;
                0 => bass.pos;
                .25 => AATimer.advance;
                0=>snroll.gain;
                1=>snare.gain;
                0=>snare.pos;
                .25=>AATimer.advance;
                0 => bass.pos;
                .125=>AATimer.advance;
                0=>tom.pos;
                .125=>AATimer.advance;
                0=>hihat.pos;
                .25=>AATimer.advance;           
            }
            else
            {
                .4 => hhclose.gain;
                0 => hhclose.pos;
                
                1 => bass.gain;
                0 => bass.pos;
                
                .25 => AATimer.advance;
                 
                .3 => hhclose.gain;
                0 => hhclose.pos;  
                
                .125 => AATimer.advance;
                
                0 => hhclose.pos;            
                .125 => AATimer.advance;
                
                0 => bass.pos;
                
                .4 => hhclose.gain;
                0 => hhclose.pos;          
                .25 => AATimer.advance; 

                0 => bass.pos;
                1.2 => snare.gain;
                0 => snare.pos;
                .125 => AATimer.advance;
                
                .125 => AATimer.advance;
                
                ///////////
                
                if(Std.randf() > 0.4)
                {
                    .55 => hihat.gain;
                    0 => hihat.pos;
                }
                else
                {
                    0 => hhclose.pos;                 
                }

                .25 => AATimer.advance;
                
                .3 => hhclose.gain;
                0 => hhclose.pos;              
                .125 => AATimer.advance;
                
                if(Std.randf() > -0.3)
                {
                    1.2 => snare.gain;
                    0 => snare.pos;
                }
                else
                {
                    0 => hhclose.pos;  
                }
                
                .125 => AATimer.advance;
     
                .25 => AATimer.advance;
                
                0 => bass.pos;
                1.2 => snare.gain;
                0 => snare.pos;
                if(Std.randf() > 0.4)
                {
                    .4 => hihat.gain;
                    0 => hihat.pos;
                    .25 => AATimer.advance;  
                }
                else
                {
                     .2 => hhclose.gain;
                    0 => hhclose.pos;              
                    .125 => AATimer.advance;
                    
                    0 => hhclose.pos;  
                    .125 => AATimer.advance;               
                }

                
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
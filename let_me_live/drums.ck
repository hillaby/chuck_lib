public class Drums
{
    Gain mono => Gain gainLeft;
    mono => Gain gainRight;
    ABSndBuf snare;
    Pan2 snarePan;
    snare.connect(snarePan);
    snarePan.left=>gainLeft;
    snarePan.right=>gainRight;
    snarePan.pan(-0.4);
    snare.set_gain(1.4);
    "drum-snare-tap.wav" => snare.read;

    ABSndBuf bass;
    bass.connect(mono);
    bass.set_gain(2.6);
    "drum-bass-lo-1.wav" => bass.read;

    ABSndBuf drag;
    drag.connect(snarePan);
    drag.set_gain(1.2);
    "drum-snare-roll-short.wav" => drag.read; 

    ABSndBuf tom;
    Pan2 tomPan;
    tom.connect(tomPan);  
    tomPan.left => gainLeft;
    tomPan.right => gainRight;
    tomPan.pan(0.4);
    tom.set_gain(1.6);    
    "drum-tom-hi-tap.wav" => tom.read;
    
    ABSndBuf sizzle;
    sizzle.connect(tomPan);
    sizzle.set_gain(.7);    
    "cymbal-ride-bell.wav" => sizzle.read;
    
    off();
    spork ~ play();
    
    0=>int what_to_play;
    
   
    public void play()
    {
        while(true)
        {
            if (what_to_play == 0)
            {
                //<<<1>>>;
                spork~sizzle.note(0, 1);
                spork~snare.note(0, .25);
                bass.note(0, .25);
                //<<<2>>>;
                /*rim.note(0, .083);
                rim.note(0, .083);
                rim.note(0, .084);*/
                drag.note(0, .25);
                //<<<3>>>;
                snare.note(0, .25);
                //hhclose.note(0, .25);
                //<<<4>>>;
                snare.note(0, .25);
                
                spork~sizzle.note(0, .5);
                snare.note(0, .25);
                //hhclose.note(0, .25);
                
                spork~bass.note(0, .25);
               
                snare.note(0, .25);
                //spork~hihat.note(0, .5);
                spork~sizzle.note(0, .5);
                tom.note(0, .25);
                bass.note(0, .25);
            }
            else if (what_to_play == 1)
            {   
                spork~sizzle.note(0, .5);
                spork~snare.note(0, .25);
                bass.note(0, .25);
                //<<<2>>>;
                /*rim.note(0, .083);
                rim.note(0, .083);
                rim.note(0, .084);*/
                drag.note(0, .25);
                //<<<3>>>;
                spork~sizzle.note(0, .5);
                snare.note(0, .25);
                //hhclose.note(0, .25);
                //<<<4>>>;
                spork~snare.note(0, .25);
                bass.note(0, .25);
                spork~sizzle.note(0, .5);
                bass.note(0, .25);
                
                
                snare.note(0, .25);
                //hhclose.note(0, .25);
                
                //spork~hihat.note(0, .5);
                spork~sizzle.note(0, .5);
                spork~bass.note(0, .25);
                tom.note(0, .25);
                tom.note(0, .25);                                
            }
            else
            {
                sizzle.note(0, 1);
                //AATimer.advance(.5);
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
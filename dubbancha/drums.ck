public class Drums
{
    Gain mono => Gain gainLeft;
    mono => Gain gainRight;
    Pan2 snarePan;
    snarePan.left=>gainLeft;
    snarePan.right=>gainRight;
    snarePan.pan(-0.2);

    /**/
    ABSndBuf bass;
    bass.connect(mono);
    bass.set_gain(2.4);
    "drum-bass-lo-1.wav" => bass.read;

    Pan2 tomPan;
    tomPan.left => gainLeft;
    tomPan.right => gainRight;
    tomPan.pan(0.2);
    
    /**/
    ABSndBuf sizzle;
    sizzle.connect(tomPan);
    sizzle.set_gain(.7);    
    "cymbal-ride-bell.wav" => sizzle.read;
    
    /**/
    ABSndBuf hh;
    hh.connect(snarePan);
    hh.set_gain(.7);    
    "cymbal-hihat-stick.wav" => hh.read;
    
    /**/
    ABSndBuf hho;
    hho.connect(snarePan);
    hho.set_gain(.5);    
    "cymbal-hihat-openclose-stick.wav" => hho.read;

    /**/
    ABSndBuf ttt;
    ttt.connect(tomPan);
    ttt.set_gain(2);    
    "drum-tom-hi-tap.wav" => ttt.read;   
    
    off();
    spork ~ play();
    
    0=>int what_to_play;
    
   
    public void play()
    {
        0=>int i;
        while(true)
        {
            if (what_to_play == 0)
            {
                if (i % 2 == 0) {
                    spork~sizzle.note(0,1);
                } else {
                    spork~hho.note(0,1);
                }
                spork~bass.note(0, 1);
                hh.note(0,.25);
                hh.note(0,.25);
                hh.note(0,.25);
                hh.note(0,.25);
                if (i % 2 == 0) {
                    hho.note(0,.5);
                }else{
                    hh.note(0,.25);
                    hh.note(0,.25);
                }
                spork~ttt.note(0, 1);
                if (i % 2 == 0) {
                    hh.note(0,.25);
                } else {
                    spork~hho.note(0,1);
                    .25=>AATimer.advance;
                }
                spork~bass.note(0, .25);
                if (i % 2 == 0) {
                    hh.note(0,.25);
                } else {
                    .25=>AATimer.advance;
                }
            }  
            i++;            
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
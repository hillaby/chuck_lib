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
    snare.set_gain(2.8);
    "drum-snare-tap.wav" => snare.read;

    ABSndBuf bass;
    bass.connect(mono);
    bass.set_gain(1.8);
    "drum-bass-lo-1.wav" => bass.read;

    ABSndBuf tom;
    Pan2 tomPan;
    tom.connect(snarePan);  
    tomPan.left => gainLeft;
    tomPan.right => gainRight;
    tomPan.pan(0.6);
    tom.set_gain(1.6);    
    "drum-tom-hi-tap.wav" => tom.read;
    
    ABSndBuf sizzle;
    sizzle.connect(tomPan);
    sizzle.set_gain(1.2);    
    "cymbal-ride-bell.wav" => sizzle.read;
    
 
    ABSndBuf hhclose;
    hhclose.connect(tomPan);
    hhclose.set_gain(.7); 
    "cymbal-hihat-stick.wav" => hhclose.read;
 
    ABSndBuf hh;
    hh.connect(tomPan);
    hh.set_gain(.7); 
    "cymbal-hihat-open-stick-1.wav" => hh.read;
  
   
    off();
    spork ~ play();
    
    1=>int what_to_play;
    
   
    public void play()
    {
        0=>int which_turn;
        0 => int bass_where;
        0 => int tom_where;
        while(true)
        {
            if (what_to_play == 0)
            {
                if (bass_where == 0)
                {
                    spork~bass.note(0, 1);
                }
                spork~snare.note(0, .5);
                hhclose.note(0, .333);
                hhclose.note(0, .167);
                spork~bass.note(0, .333);
                spork~snare.note(0, 1);
                hhclose.note(0, .333);
                hhclose.note(0, .167);     
                hh.note(0, .333);
                hhclose.note(0, .167);
                spork~bass.note(0, 1);
                hhclose.note(0, .333);
                hhclose.note(0, .167);
                hhclose.note(0, .333);     
                       
                spork~snare.note(0, .5);
                spork~bass.note(0, 1);                
                hhclose.note(0, .167);     
                hh.note(0, .333);
                hhclose.note(0, .167);  
       
            }
            else
            {
                //<<<"lkjlkj">>>;
                for(0=>int i; i<6; i++)
                {
                    hhclose.note(0, .5);  
                }
                
            }
            
            if (what_to_play == 0)
            {
                if (Std.randf() > 0.3)
                {
                    spork~snare.note(0, 1);
                    0 => tom_where;
                }
                else
                {
                    //spork~tom.note(0, .166);
                    1 => tom_where;
                }
                spork~bass.note(0, .333);
                if (tom_where)
                {
                    spork~tom.note(0, .333);
                    hhclose.note(0, .333);
                }
                else
                {
                    snare.note(0, .166); 
                    snare.note(0, .167);
                }
                
                if (true /*Std.randf() > -0.5*/)
                {
                    1 => bass_where;
                    spork~bass.note(0, 1);
                }
                else
                {
                    0 => bass_where;
                }
                if (tom_where)
                {
                    spork~tom.note(0, .333);
                    hhclose.note(0, .167);  
                }
                else
                {
                    snare.note(0, .167);    
                }
                               
            }
            else
            {
                hh.note(0, .5);
            }
            which_turn++;
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
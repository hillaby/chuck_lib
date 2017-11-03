public class Drums
{
    Gain mono => Gain gainLeft;
    mono => Gain gainRight;
    ABSndBuf snare;
    Pan2 snarePan;
    NRev rev=>snarePan;
    .05=>rev.mix;
    1.8=>rev.gain;
    snare.connect(rev);
    snarePan.left=>gainLeft;
    snarePan.right=>gainRight;
    snarePan.pan(-0.4);
    snare.set_gain(2.4);
    "drum-snare-tap.wav" => snare.read;

    ABSndBuf bass;
    bass.connect(mono);
    bass.set_gain(2.5);
    // "drum-bass-lo-1.wav" => bass.read;
    "../lib/instruments/s_bass_drum/DT Kick.wav"=>bass.read;

    ABSndBuf tom;
    Pan2 tomPan;
    tom.connect(tomPan);
    tomPan.left => gainLeft;
    tomPan.right => gainRight;
    tomPan.pan(0.4);
    tom.set_gain(1.8);
    "drum-tom-hi-tap.wav" => tom.read;

    ABSndBuf sizzle;
    sizzle.connect(tomPan);
    sizzle.set_gain(1.2);
    "cymbal-ride-bell.wav" => sizzle.read;


    ABSndBuf hhclose;
    hhclose.connect(tomPan);
    hhclose.set_gain(.8);
    "cymbal-hihat-stick.wav" => hhclose.read;

    ABSndBuf hhclosed;
    hhclosed.connect(tomPan);
    hhclosed.set_gain(.5);
    "../lib/instruments/s_hihat/cymbal-hihat-foot-2.wav" => hhclosed.read;

    off();
    spork ~ play();

    0=>int what_to_play;


    public void play()
    {
        0=>int turn;
        while(true)
        {
            if (what_to_play == 0)
            {
    spork~bass.note(0, .5);
                if (turn % 2 == 0)
                {
                    spork~sizzle.note(0, 2);
                }
                hhclose.note(0, .25);
                hhclosed.note(0, .25);
    spork~bass.note(0, .5);
                hhclose.note(0, .5);
    //hhclosed.note(0, .25);
                //hhclose.note(0, .25);
                spork~snare.note(0, .5);
                spork~bass.note(0, .5);
                hhclose.note(0, .25);
    if (Std.randf() > .6) {
    spork~snare.note(0, .5);
    }
    hhclosed.note(0, .25);
                spork~bass.note(0, .5);
                hhclose.note(0, .25);
    spork~hhclosed.note(0, .25);
                //spork~hhclose.note(0, .25);
    if (Std.randf() > 0) {
    tom.note(0, .25);
                } else {
    snare.note(0, .25);
    }
    turn++;
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

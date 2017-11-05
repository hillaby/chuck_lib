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

    ABSndBuf rim;
    rim.connect(snarePan);
    rim.set_gain(3.4);
    "drum-snare-rim.wav" => rim.read;

    ABSndBuf bass;
    bass.connect(mono);
    bass.set_gain(1.9);
    "drum-bass-lo-1.wav" => bass.read;

    ABSndBuf tom;
    Pan2 tomPan;
    tom.connect(snarePan);
    tomPan.left => gainLeft;
    tomPan.right => gainRight;
    tomPan.pan(0.4);
    tom.set_gain(1.4);
    "drum-tom-hi-tap.wav" => tom.read;

    ABSndBuf sizzle;
    sizzle.connect(snarePan);
    sizzle.set_gain(1);
    "cymbal-ride-bell.wav" => sizzle.read;


    ABSndBuf hhclose;
    hhclose.connect(tomPan);
    hhclose.set_gain(.4);
    "cymbal-hihat-stick.wav" => hhclose.read;

    ABSndBuf hh;
    hh.connect(tomPan);
    hh.set_gain(.33);
    "cymbal-hihat-open-stick-1.wav" => hh.read;


    off();
    spork ~ play();

    0=>int what_to_play;


    public void play()
    {
        0=>int which_turn;
        while(true)
        {
            if (what_to_play == 0)
            {
                spork~bass.note(0, 1);
                bass.note(-1, .25);
                spork~hh.note(0, .5);
                bass.note(-1, .25);
                spork~rim.note(0, 1);
                bass.note(-1, .25);
                if (which_turn % 4 == 3)
                {
                    spork~tom.note(0, 1);
                }
                hh.note(0, .5);
                spork~hh.note(0, .5);
                bass.note(-1, .25);
                spork~bass.note(0, 1);

                //<<<which_turn>>>;
                which_turn % 32 => int cycle;
                if ((cycle < 16 && (cycle % 8 == 2 ||
                    cycle % 8 == 3 ||
                    cycle % 8 == 4 ||
                    cycle % 8 == 5 ||
					cycle % 8 == 6)) || (cycle >= 15 && cycle < 31))
                {
                    spork~sizzle.note(0, 2);
                }
                if (which_turn % 2 == 1)
                {
                    spork~rim.note(0, 1);
                    tom.note(-1, .25);
                    spork~hh.note(0, .5);
                    spork~tom.note(0, 1);
                    tom.note(-1, .25);
                }
                else
                {
                    spork~rim.note(0, 1);
                    bass.note(-1, .25);
                    spork~hh.note(0, .5);
                    bass.note(-1, .25);
                }

                which_turn++;
            }
            else
            {
                for (0=>int j; j < 2; j++) {
                    spork~sizzle.note(0, 2);
                    bass.note(0, .75);
                    if (j != 1) {
                        spork~sizzle.note(0, 2);
                        bass.note(0, 1.25);
                    }
                    else
                    {
                        bass.note(-1, 1.25);
                    }
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

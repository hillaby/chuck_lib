public class Guitar2
{
    Gain gainLeft;
    Gain gainRight;

    Pan2 pan;
    NRev rev=>pan;
    .05=>rev.mix;
    1.8=>rev.gain;

    pan.pan(-0.3);
    pan.left=>gainLeft;
    pan.right=>gainRight;
    ABSndBuf loop;
    loop.connect(rev);
    loop.set_gain(.48);

    "2.wav" => loop.read;
    541000 => loop.set_start_pos;
    //2000 => loop.set_start_pos;
    .001=>loop.set_release;

    off();
    spork ~ play();


    0=>int what_to_play;
    public void play()
    {
        while(true)
        {
            if (what_to_play == 0)
            {
                541000 => loop.set_start_pos;
                loop.note(0, 64);
            }
            else
            {
                541000 + (56*44100) => loop.set_start_pos;
                loop.note(0, 8);

            }
            //.5=>AATimer.advance;
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

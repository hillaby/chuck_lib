public class Guitar
{
    HPF hpf;
    300=>hpf.freq;
    Pan2 pan;

    NRev rev=>pan;
    .03=>rev.mix;
    1=>rev.gain;
    Gain gainLeft;
    Gain gainRight;

    hpf=>rev;
    pan.left=>gainLeft;
    pan.right=>gainRight;

    pan.pan(-0.2);

    ABSndBuf loop;
    loop.connect(hpf);
    loop.set_gain(.6);

    "0204-2.wav" => loop.read;
    000 => loop.set_start_pos;
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
                AATimer.advance(.21);
                loop.note(0, 27.79);
            }
            else
            {

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

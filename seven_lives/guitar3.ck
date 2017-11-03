public class Guitar3
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
    ADSR adsr;
    loop.connect(adsr);
    loop.set_gain(1);

    "0204-3.wav" => loop.read;
    22000 => loop.set_start_pos;
    //2000 => loop.set_start_pos;
    .001=>loop.set_release;

    adsr => rev;
    adsr.set( 300::ms, 4::ms, .9, 100::ms );

    off();


    0=>int what_to_play;
    public void play()
    {
        while(true)
        {
            if (what_to_play == 0)
            {
                loop.note(0, 140);
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

    public void start(float g)
    {
        spork ~ play();
        g => gainLeft.gain;
        g => gainRight.gain;
    }

    public void on()
    {
        adsr.keyOn();
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

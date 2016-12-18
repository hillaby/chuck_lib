public class Guitar
{
    SndBuf loop => ADSR loop_adsr => Gain gain;
    //"../instruments/Audio Track-3.wav" => loop.read;
    "Audio Track-5.wav" => loop.read;
    loop.samples() => loop.pos;
    loop_adsr.set( 1::ms, 4::ms, .9, 100::ms ); 
    1=>loop.gain;
   
    off();
    spork ~ play();
    
  
    0=>int what_to_play;
    public void play()
    {
        while(true)
        {
            if (what_to_play == 0)
            {
                //192000=>loop.pos; //3.wav
                161300=>loop.pos; //5.wav
                loop_adsr.keyOn();
                33.8=>AATimer.advance;
                loop_adsr.keyOff();
                .2=>AATimer.advance;
            }
            else
            {

            }
            //.5=>AATimer.advance;
        }            
    }
    
    public void set_what_to_play(int w)
    {
        w=>what_to_play;
    }
    
    public void connect(UGen ug)
    {
        gain => ug;
    }
    
    public void on(float g)
    {
        g=>gain.gain;
    }
    
    public void off()
    {
        0=>gain.gain;
    }
}
public class Baterista
{
 
    SndBuf wbl;
    "woodblock.wav" => wbl.read;
    wbl.samples() => wbl.pos;
    1.5 => wbl.gain;
    
    SndBuf afuche;
    "cymbal-hihat-stick.wav" => afuche.read;
    afuche.samples() => afuche.pos;
    .6 => afuche.gain;
     
    SndBuf tumba;
    "tumba-open-1.wav" => tumba.read;
    tumba.samples() => tumba.pos;
    2 => tumba.gain;
    
    SndBuf conga;
    "conga-open-1.wav" => conga.read;
    conga.samples() => conga.pos;
    2 => conga.gain;
    
    Pan2 rightPan;
    conga=>rightPan;
    afuche=>rightPan;
    rightPan.left=>Gain gainLeft;
    rightPan.right=>Gain gainRight;
    rightPan.pan(-0.4);
    
    Pan2 leftPan;
    leftPan.left=>gainLeft;
    leftPan.right=>gainRight;
    leftPan.pan(0.4);
    tumba=>leftPan;
    wbl=>leftPan;    
  
    off();
    spork ~ play();
    
    0=>int what_to_play;
    
    100=>int wbl_where;
    
    public void play()
    {
        while(true)
        {
            if (what_to_play == 0)
            {
                0=>afuche.pos;
                wbl_where=>wbl.pos;
                .125=>AATimer.advance;
                wbl_where=>wbl.pos;
                .25=>AATimer.advance;
                wbl_where=>wbl.pos;
                .125=>AATimer.advance;
                
                0=>afuche.pos;
                wbl_where=>wbl.pos;
                .125=>AATimer.advance;
                wbl_where=>wbl.pos;
                .125=>AATimer.advance;
                0=>conga.pos;
                .125=>AATimer.advance;                
                wbl_where=>wbl.pos;
                .125=>AATimer.advance;
                
                0=>afuche.pos;
                wbl_where=>wbl.pos;
                .25=>AATimer.advance;
                0=>afuche.pos;
                wbl_where=>wbl.pos;
                .25=>AATimer.advance;
                
                0=>afuche.pos;
                wbl_where=>wbl.pos;
                .125=>AATimer.advance;
                wbl_where=>wbl.pos;
                .125=>AATimer.advance;
                0=>tumba.pos;
                .125=>AATimer.advance;
                wbl_where=>wbl.pos;
                .125=>AATimer.advance;
            }
            else
            {                
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
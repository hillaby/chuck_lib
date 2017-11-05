public class ABSndBuf
{
    SndBuf sndBuf => ADSR adsr;
    adsr.set( 30::ms, 4::ms, .9, 100::ms ); 
    0 => float base_note;
    public void read(string path)
    {
        read(path, 0);
    }
    public void read(string path, float base)
    {
        path=>sndBuf.read;
        sndBuf.samples() => sndBuf.pos;
        base=>base_note;
    }
    public void set_gain(float g)
    {
        g=>sndBuf.gain;
    }
    int start_pos;
    public void set_start_pos(int pos)
    {
        pos=>start_pos;
    }
    public void connect(UGen u)
    {
        adsr => u;
    }
    
    .2=>float releaseTime;
    public void set_release(float r)
    {
        r=>releaseTime;
    }
    
    public void note(float n, float d)
    {
        if (n != 0 && base_note != 0)
        {
            Std.mtof(n)/Std.mtof(base_note)=> sndBuf.rate;
        }
        
        if (n < 0)
        {
            d=>AATimer.advance;
            return;
        }
        
        start_pos=>sndBuf.pos;

        adsr.keyOn();
        (1-releaseTime)*d=>AATimer.advance;
        
        releaseTime*d::AATimer.get_T() => adsr.releaseTime;
        
        adsr.keyOff();
        
        releaseTime*d=>AATimer.advance;
    }   

    public void gliss(float n1, float n2, float d)
    {
        if (n1 != 0 && base_note != 0)
        {
            Std.mtof(n1)/Std.mtof(base_note)=> sndBuf.rate;
        }
        
        if (n1 < 0)
        {
            d=>AATimer.advance;
            return;
        }
        
        start_pos=>sndBuf.pos;

        adsr.keyOn();
        
        (.35)*d=>AATimer.advance;
        
        for(0=>int ii; ii < 1000; ii++)
        {
            Std.mtof(n1 + ii*0.001*(n2-n1))/Std.mtof(base_note)=> sndBuf.rate;
            (.15/1000.0)*d=>AATimer.advance;
        }
        
        (.3)*d=>AATimer.advance;
                
        .2*d::AATimer.get_T() => adsr.releaseTime;
        
        adsr.keyOff();
        
        .2*d=>AATimer.advance;
    }     
}
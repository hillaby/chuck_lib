// a timer class, intended for skipping part of the music temporarily (start_at())
// and setting beat length (set_T())
// 1::minute / 130. =>Timer.set_T;
// 0=>Timer.start_at;
// ...
// 8=>Timer.advance;

public class Timer
{
    static dur T;
    static dur min_T;
    static time start;

    // sets beat length
    public static void set_T(dur t)
    {
        //<<<t>>>;
        <<<"1 frac == ", (t/1::samp), " sample">>>;
        t=>T;
    }    

    // gets beat length
    public static dur get_T()
    {
        return T;    
    }

    // advances time to a given number of measures
    public static void advance(float frac)
    {
        <<<"at: ", now/1::second, " seconds">>>;
		if (frac == 0.) return;
		//<<<"dur: ", frac>>>;
		//<<<"T: ", T>>>;
		//<<<"start: ", start>>>;
        if (now >= start)
        {
            frac::T=>now;
        }
        else
        {
            if (now + frac::min_T <= start)
            {
                frac::min_T=>now;
            }
            else
            {
                // first part
                (start-now)/min_T => float frac1;
                frac1::min_T=>now;
                (frac-frac1)::T=>now;
            }
        }
    }

    // starts playing at the given measure
    public static void start_at(float frac)
    {
        1::samp=>min_T;
        now + frac*min_T=>start;
    }
}


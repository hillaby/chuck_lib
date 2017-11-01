public class AATimer
{
    static dur T;
    static dur min_T;
    static time start;
    public static void set_T(dur t)
    {
        //<<<t>>>;
        <<<"1 frac == ", (t/1::samp), " sample">>>;
        t=>T;
    }
    public static dur get_T()
    {
        return T;
    }
    public static void advance(float frac)
    {
        //<<<"adv: ", frac>>>;
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
                (start-now)/min_T => float frac1;
                frac1::min_T=>now;
                (frac-frac1)::T=>now;
            }
        }
    }
    public static void start_at(float frac)
    {
        1::samp=>min_T;
        now + frac*min_T=>start;
    }
}

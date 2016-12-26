// random pan effect

public class RandPan extends StereoEffect 
{
	input => Pan2 pan;
	pan.left => outputLeft;
	pan.right => outputRight;
	-1. => float minPan;
	1. => float maxPan;
	
	// sets min. and max. pan
	public void setMinMax(float min, float max)
	{
		min => minPan;
		max => maxPan;
	}
	
	// changes pan...
	public void changePan()
	{
		while (1)
		{
			Std.rand2f(minPan, maxPan) => float nextPan;
			nextPan - pan.pan() => float diff;
			Std.rand2(50, 500) => int division;
			for (0 => int i; i < division; i++)
			{
				pan.pan() + diff/division => pan.pan;
				100::samp=>now;
			}
		}
	}
	spork~changePan();
}

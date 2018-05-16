import java.util.Random;

public class Generator {
	Random ran_gen = new Random();
	char[] pw;
	int max_length;
	
	//constructors
	public Generator()
	{
		pw = new char[14];
		max_length = 14;
		System.out.println("0");
	}
	
	public Generator(int n)
	{
		pw = new char[n];
		max_length = n;
	}
	
	//methods
	public char[] generatePW()
	{
		for(int i = 0; i<max_length; i++)
		{
			pw[i] = generatePWChar();
		}
		return pw;
	}
	
	public char generatePWChar()
	{
		int category,value = 0,potential_symbol_category;
		category = ran_gen.nextInt(4)+1;
		switch(category)
		{
			case 1:	//capitals
				value = ran_gen.nextInt(26)+65;
				break;
			case 2:	//lowercases
				value = ran_gen.nextInt(26)+97;
				break;
			case 3: //digits
				value = ran_gen.nextInt(10)+48;
				break;
			case 4:	//symbols
				potential_symbol_category = ran_gen.nextInt(4)+1;
				switch(potential_symbol_category)
				{
					case 1:	
						value = ran_gen.nextInt(15)+33;
						break;
					case 2:	
						value = ran_gen.nextInt(7)+58;
						break;
					case 3: 
						value = ran_gen.nextInt(6)+91;
						break;
					case 4:	
						value = ran_gen.nextInt(4)+123;
						break;
					default:
						value = 0;
				}
				break;
			default:
				value = 0;
		}
		return (char) value;
	}
	
	public String toString()
	{
		String output = new String(pw);
		return output;
	}
}

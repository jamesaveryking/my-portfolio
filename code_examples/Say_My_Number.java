import java.io.IOException;

import javax.swing.JOptionPane;







public class Say_JAK {
	
	public static String say(long n)
	{
		String info = "";
		String[] num = new String[] {"zero","one","two","three","four","five","six","seven","eight","nine"};
		String[] numty = new String[] {"twenty","thirty","forty","fifty","sixty","seventy","eighty","ninety"};
		String[] numteen = new String[] {"ten","eleven","twelve","thirteen","fourteen","fifteen","sixteen","seventeen","eighteen","nineteen"};
		//add bigger stuff up here		
		
		
		
		if(n>=1000000000000000L)
			info = say(n/1000000000000000L)+" quadrillion" + say(n%1000000000000000L);
		else if (n>=1000000000000L)
			info = say(n/1000000000000L) + " trillion" + say(n%1000000000000L);
		else if (n>=1000000000L)
			info = say(n/1000000000L) + " billion "+ say(n%1000000000L);		
		else if (n>=1000000)
			info = say(n/1000000)+" million "+say(n%1000000);		
		else if (n>=1000)
			info = say(n/1000) + " thousand " + say(n%1000);		
		else if (n>=100)
			info = say(n/100) + " hundred " + say(n%100);		
		else if (n>=20)
			info = numty[(int) ((n/10)-2)] + " " + say(n%10);
		else if (n>=10)
			info = numteen[(int) n-10] + " " ;
		else if (n>0&&n<=9)
			info = num[(int)n] ;
		else if(info.isEmpty()&&n == 0)
			return "";
		return info;
		
		
	}
	
	
	

	public static void main(String[] args) throws IOException, NumberFormatException
	{
		// TODO Auto-generated method stub
		String theNumber = JOptionPane.showInputDialog("Please enter a number and I will say it");
		long num = Long.parseLong(theNumber);
		JOptionPane.showMessageDialog(null, "You entered: " + say(num));
		
	}

}

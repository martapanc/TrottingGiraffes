package org.trotting;

class TESTorgowasphtmlEncoding{
	
	public static void main(String[] args){
		try{
			String theOracle = args[1];
			String theTest = args[0];

			String result = org.owasp.html.Encoding.decodeHtml(theTest);

			theOracle = theOracle.replaceAll("\"", "\\\\\"");
			theOracle = theOracle.replaceAll("\\\\", "\\\\\\\\");

			theTest = theTest.replaceAll("\"", "\\\\\"");
			theTest = theTest.replaceAll("\\\\", "\\\\\\\\");
			theTest = theTest.replaceAll("&", "&amp;");

			result = result.replaceAll("\"", "\\\\\"");
			result = result.replaceAll("\\\\", "\\\\\\\\");
			result = result.replaceAll("\n", "\\\\\\\\n");

			if((result).compareTo(theOracle) == 0){
				try{
					System.out.println("org.owasp.html.Encoding");
					System.out.println("decodeHtml(String)");
					System.out.println(theTest);
					System.out.println(result);
					System.out.println(theOracle);
					System.out.println("passed\n");
				
				}catch(Exception e){
					e.printStackTrace();	
				}

			}
			else{
				try{
					System.out.println("org.owasp.html.Encoding");
					System.out.println("decodeHtml(String)");
					System.out.println(theTest);
					System.out.println(result);
					System.out.println(theOracle);
					System.out.println("failed\n");
					
				}catch(Exception e){
					e.printStackTrace();
				}
			}
		}catch(Exception e){
			System.out.println("Exception: Possibly incorrect number of arguments.");
			e.printStackTrace();
		}
	
	}	
}

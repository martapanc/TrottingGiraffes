package org.trotting;

class TESTorgowasphtmlEncoding{
	
	public static void main(String[] args){
		try{
			String theOracle = args[1];
			String theTest = args[0];

			String result = org.owasp.html.Encoding.decodeHtml(theTest);
			if(theOracle.contains("\\n")){
				//System.out.println("Oracle contains: \\n");
				 theOracle = theOracle.replace("\\n","\n");
			}
	

			if((result).equals(theOracle)){
				try{

					System.out.println("passed\n");
					System.out.println("org.owasp.html.Encoding.decodeHtml("+theTest+")\n");
				
				}catch(Exception e){
					e.printStackTrace();	
				}

			}
			else{
				try{
					System.out.println("failed\n");
					System.out.println("org.owasp.html.Encoding.decodeHtml("+theTest+")\n");
					
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
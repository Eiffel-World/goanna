
import java.io.*;
import java.net.*;
import java.util.*;
import org.apache.soap.util.xml.*;
import org.apache.soap.*;
import org.apache.soap.rpc.*;

public class TestSOAPClient
{

	String encodingStyleURI;
	URL url;
	String op;
	String arg1, arg2;

    public TestSOAPClient(String name)
    {
    }

	public void doCall(String method, Object value) throws Exception
	{
		Call call = new Call ();
		call.setTargetObjectURI ("urn:testSOAP");
		call.setMethodName (method);
		call.setEncodingStyleURI(encodingStyleURI);

		Vector params = new Vector ();
		params.addElement (new Parameter("in", value.getClass(), value, null));
		call.setParams (params);

		// make the call: note that the action URI is empty because the
		// XML-SOAP rpc router does not need this. This may change in the
		// future.
		Response resp = call.invoke (url, "");

		// Check the response.
		if (resp.generatedFault ())
		{
			Fault fault = resp.getFault ();
			System.out.println ("Ouch, the call failed: ");
			System.out.println ("  Fault Code   = " + fault.getFaultCode ());
			System.out.println ("  Fault String = " + fault.getFaultString ());
		}
		else
		{
			Parameter result = resp.getReturnValue ();
			System.out.println ("Call succeeded: ");
			System.out.println ("Result = " + result.getValue ());
        }
    }

	public static void main (String[] args) throws Exception
	{
		int maxargs = 2;
		if (args.length != (maxargs-1)
		   && (args.length != maxargs || !args[0].startsWith ("-")))
		{
			System.err.println ("Usage: java " + TestSOAPClient.class.getName () +
			                   " [-encodingStyleURI] SOAP-router-URL");
			System.exit (1);
        }

		TestSOAPClient t = new TestSOAPClient ("Test SOAP");

		int offset = maxargs - args.length;
		t.encodingStyleURI = (args.length == maxargs) ? args[0].substring(1) : Constants.NS_URI_SOAP_ENC;
		t.url = new URL (args[1 - offset]);

		// test all types
		t.doCall("testBoolean", new Boolean(true));
		t.doCall("testBoolean", new Boolean(false));
		t.doCall("testDecimal", new Integer(100));
		//t.doCall("testReal", new Real(100.5));
		t.doCall("testDouble", new Double(100.54));
		t.doCall("testString", new String("test"));
    }

}

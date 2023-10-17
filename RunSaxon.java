import java.io.*;
import java.net.*;
import javax.net.ssl.*;

class RunSaxon {
protected static class ExitException extends SecurityException 
    {
        public final int status;
        public ExitException(int status) 
        {
            super("There is no escape! "+status);
            this.status = status;
        }
    }

    private static class NoExitSecurityManager extends SecurityManager 
    {
        @Override
        public void checkPermission(java.security.Permission perm) 
        {
            // allow anything.
        }
        @Override
        public void checkPermission(java.security.Permission perm, Object context) 
        {
            // allow anything.
        }
        @Override
        public void checkExit(int status) 
        {
            super.checkExit(status);
            throw new ExitException(status);
        }
    }

	public static void main(String args[]) {
		try {
			System.setSecurityManager(new NoExitSecurityManager());
			for (int a = 0; a < args.length; a++) {
				String source = args[a];
				System.err.println("BEGIN "+source);
				String out = "out.js";
				try {
					net.sf.saxon.Transform.main(new String[] {

								"-warnings:recover",
  								"--suppressXsltNamespaceCheck:on",
								"-o:"+out,
								"-s:"+source,
								"-xsl:jslt.xslt" });
					System.err.println("END "+source);
				} catch (Throwable e) {
					System.err.println("FATAL "+source+" > "+out);
					System.err.println(e.getMessage());
				}
			}
			System.setSecurityManager(null); // or save and restore original
		} catch (ExitException ee) {
			ee.printStackTrace();
		}
	}
}

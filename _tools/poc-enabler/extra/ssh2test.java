/*
 * java -cp .:/opt/APG/Collecting/Remote-Shell-Collector/Default/lib/trilead-ssh2-w4n-r856.jar Basic
 * javac -d . -cp /opt/APG/Collecting/Remote-Shell-Collector/Default/lib/trilead-ssh2-w4n-r856.jar Basic
 */

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import com.trilead.ssh2.Connection;
import com.trilead.ssh2.Session;
import com.trilead.ssh2.StreamGobbler;


/*
 * This is a very basic example that shows
 * how one can login to a machine and execute a command.
 *  
 * @author Christian Plattner, plattner@trilead.com
 *  @version $Id: Basic.java,v 1.4 2007/10/15 12:49:57 cplattne Exp $
 */
public class ssh2test
{
        public static void main(String[] args)
        {
                String hostname = args[0];
                String username = args[1];
                String password = args[2];

                try
                {
                        /* Create a connection instance */

                        Connection conn = new Connection(hostname);

                        /* Now connect */

                        conn.connect();

			/* Authenticate.
			 * If you get an IOException saying something like
			 * "Authentication method password not supported by the server at this stage."
			 * then please check the FAQ.
			 */

                        boolean isAuthenticated = conn.authenticateWithPassword(username, password);

                        if (isAuthenticated == false)
                                throw new IOException("Authentication failed.");

                        /* Create a session */

                        Session sess = conn.openSession();

                        sess.execCommand("uname");

                        System.out.println("Here is some information about the remote host:");

                        /* 
                         * This basic example does not handle stderr, which is sometimes dangerous
                         * (please read the FAQ).
                         */

                        InputStream stdout = new StreamGobbler(sess.getStdout());

                        BufferedReader br = new BufferedReader(new InputStreamReader(stdout));

                        while (true)
                        {
                                String line = br.readLine();
                                if (line == null)
                                        break;
                                System.out.println(line);
                        }

                        /* Show exit status, if available (otherwise "null") */

                        System.out.println("ExitCode: " + sess.getExitStatus());

                        /* Close this session */

                        sess.close();

                        /* Close the connection */

                        conn.close();

                }
                catch (IOException e)
                {
                        e.printStackTrace(System.err);
                        System.exit(2);
                }
        }
}

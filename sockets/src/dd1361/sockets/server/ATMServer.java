package dd1361.sockets.server;

import java.net.*;
import java.io.*;

/**
 * Main entry point for the server. It should start listening for new
 * connections and hand off new sockets to a ATMClientConnectionThread.
 */
public class ATMServer {
	private static final int connectionPort = 8989;

	public static void main(String[] args) throws IOException {
		ServerSocket serverSocket = null;

		try {
			serverSocket = new ServerSocket(connectionPort);
		} catch (IOException e) {
			System.err.println("Could not listen on port: " + connectionPort);
			System.exit(1);
		}

		System.out.println("Bank started listening on port: " + connectionPort);

		while (!Thread.interrupted())
			new ATMClientConnectionThread(serverSocket.accept()).start();

		serverSocket.close();
	}
}
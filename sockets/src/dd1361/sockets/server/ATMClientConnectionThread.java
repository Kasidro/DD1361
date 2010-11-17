package dd1361.sockets.server;

import java.io.*;
import java.net.*;

import dd1361.sockets.ATMSocketMessage;

public class ATMClientConnectionThread extends Thread {
	private Socket socket;

	private InputStream in;
	private OutputStream out;

	public ATMClientConnectionThread(Socket aSocket) {
		socket = aSocket;
	}

	public void run() {
		try {
			out = socket.getOutputStream();
			in = socket.getInputStream();
			
			byte[] authChallenge = {ATMSocketMessage.AUTH_CHALLENGE, 0, 0, 0, 0, 0, 0, 0, 0, 0};

			out.close();
			in.close();

			socket.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
}
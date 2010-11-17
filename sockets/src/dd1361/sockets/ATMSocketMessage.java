package dd1361.sockets;

/**
 * Specifies the messages that may be sent between a ATM server and a ATM
 * client.
 */
public class ATMSocketMessage {
	/*
	 * All messages sent between the server and a client are 10 bytes 
	 * in length. The first byte is always the command and the rest are
	 * empty unless otherwise said so.
	 * 
	 * Some messages such as the MOTD_PUT come with a payload after the 
	 * command. The size of this payload is specified in the command.
	 * 
	 * All command sent to the other end of the connection should be 
	 * answered by either a ACCEPTED or a DECLINED message.
	 * 
	 * If the server doesn't respond within 5 seconds of a command that 
	 * expects a response, the client should send TIMEOUT followed by 
	 * AUTH_LOGOUT, close the connection and return to the login screen.
	 * 
	 * If the client doesn't respond within 5 seconds of a command that 
	 * expects a response, the server should send TIMEOUT followed by
	 * AUTH_LOGOUT and close the connection.
	 */
	
	public static final byte ACCEPTED = 1;
	public static final byte DECLINED = 2;
	
	public static final byte TIMEOUT = 3;
	
	/*
	 * Sent by the server to the client after a connection has been 
	 * established. The first byte in the message is the command,
	 * then there's five unused bytes and the final four bytes
	 * signifies the length of the motd in characters that is sent 
	 * after the command.
	 */
	public static final byte MOTD_PUT = 4;
	
	/*
	 * TODO
	 */
	public static final byte LANG_LIST = 5;
	/*
	 * TODO
	 */
	public static final byte LANG_GET = 6;
	
	/*
	 * Sent by the server to tell the client that it needs to authenticate
	 * it's user before the server accepts any other commands. The client must 
	 * always accept the command. It should react by presenting a login prompt.
	 * 
	 * RESPONSE:
	 * 		ACCEPTED
	 */
	public static final byte AUTH_CHALLENGE = 7;
	/*
	 * TODO
	 */
	public static final byte AUTH_LOGIN = 8;
	/*
	 * May be sent by either the server or the client to initiate a logout. The 
	 * other end of the connection must always accept the command.
	 * 
	 * Response:
	 * 		ACCEPTED
	 */
	public static final byte AUTH_LOGOUT = 9;
	
	
	/*
	 * Sent by the client to update the balance of the account. The first byte 
	 * is the command, the second is unused. The remaining 8 bytes is a long
	 * that determines how many magic cookies to remove from the account.
	 * 
	 * Response:
	 * 		ACCEPTED: The balance has been updated
	 * 		DECLINED: The balance was not accepted
	 * 
	 * Example:
	 * 		byte[] command = {BALANCE_PUT, 0, 0, 0, 0, 0, 0, 0, 0, 100};
	 */
	public static final byte BALANCE_PUT = 10;
	/*
	 * Sent by the client to the server to ask for the current balance. The server
	 * will return a long or timeout.
	 * 
	 * Response:
	 * 		A long signifying the number of magic cookies in the users account
	 */
	public static final byte BALANCE_GET = 11;
}

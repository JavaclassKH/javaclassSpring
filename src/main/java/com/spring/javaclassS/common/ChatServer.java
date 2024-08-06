package com.spring.javaclassS.common;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/chatserver")
public class ChatServer {
	// 채팅서버에 접속한 클라이언트 목록을 저장할 객체 생성
	private static List<Session> userList = new ArrayList<Session>();
	
	
	private void print(String msg) {
		System.out.printf("[%tT] %s\n", Calendar.getInstance(), msg);
	}
	
	
	@OnOpen // 채팅서버에 최초 접속 시 처음 수행
	public void handleOpen(Session session) {
		print("클라이언트 연결 : sessionID : " + session.getId());
		userList.add(session); 
	}
	
	
	
	@OnMessage // 클라이언트가 메세지 호출 시 이곳을 반드시 통과 (ws.send())
	public void handleMessage(String msg, Session session) {	
		
		
		
		int index = msg.indexOf("#", 2);	// 메세지와 색상을 찾는다
		String no = msg.substring(0, 1);	// 1: 로그인 / 2: 대화 / 3: 종료
		String user = msg.substring(2, index);	
		
		String txt = msg.substring(index + 1);	
		
		// 로그인 시 색상을 넣었다면 아래 코드가 실행
		if(txt.indexOf("@") != -1) {		
			txt = txt.substring(0, txt.lastIndexOf("@"));	
			String chatColor = msg.substring(msg.lastIndexOf("@")+1);	
			
			txt = " <font color=\""+chatColor+"\">"+txt+"</font>";	
		}
		
		
		if (no.equals("1")) {  
			for (Session s : userList) {	
				if (s != session) { 
					try {	 
						s.getBasicRemote().sendText("1#" + user + "#");
					} catch (IOException e) {e.printStackTrace();}
				}
			}
		}
		
		else if(no.equals("2")) {  
			for (Session s : userList) {
				if (s != session) { 
					try {
						s.getBasicRemote().sendText("2#" + user + ":" + txt);	
					} catch (IOException e) {e.printStackTrace();}
				}
			} 
		}
		
		else if (no.equals("3")) { 
			for (Session s : userList) {
				if (s != session) { 
					try {
						s.getBasicRemote().sendText("3#" + user + "#");
					} catch (IOException e) {e.printStackTrace();}
				}
			}
			
			userList.remove(session);	
		}
		
	}

	
	@OnClose
	public void handleClose(Session session) {
		System.out.println("Websocket Close");
		userList.remove(session);	
	}
	
	
	@OnError
	public void handleError(Throwable t) {
		System.out.println("웹소켓 전송 에러입니다.");
	}
}
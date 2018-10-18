package db.data;

public class Notification {
	
	private int notificationId;
	 
	private String user;
	
	private String name;
	
	private String content;
		
	

	public Notification(int notificationId, String user, String name, String content) {
		super();
		this.notificationId = notificationId;
		this.user = user;
		this.name = name;
		this.content = content;
	}
	

	public Notification(int notificationId, String user, String content) {
		super();
		this.notificationId = notificationId;
		this.user = user;
		this.content = content;
	}



	public int getNotificationId() {
		return notificationId;
	}

	public void setNotificationId(int notificationId) {
		this.notificationId = notificationId;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	
	

}

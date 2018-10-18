package db.data;

public class Message {
	
    private int messageId;
	
	private String from;
	
	private String Content;
	
	private Boolean IsRead;

	
	public Message() {
		super();
	}

	public Message(int messageId, String from, String content, Boolean isRead) {
		super();
		this.messageId = messageId;
		this.from = from;
		Content = content;
		IsRead = isRead;
	}
	
	

	public int getMessageId() {
		return messageId;
	}

	public void setMessageId(int messageId) {
		this.messageId = messageId;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public String getContent() {
		return Content;
	}

	public void setContent(String content) {
		Content = content;
	}

	public Boolean getIsRead() {
		return IsRead;
	}

	public void setIsRead(Boolean isRead) {
		IsRead = isRead;
	}



	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + messageId;
		return result;
	}



	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Message other = (Message) obj;
		if (messageId != other.messageId)
			return false;
		return true;
	}



	@Override
	public String toString() {
		return "Message [messageId=" + messageId + ", from=" + from + ", Content=" + Content + "]";
	}
	
	
	

}

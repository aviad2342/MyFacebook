package db.data;

public class Comments {

    private int commentId;
	
	private String byUser;
	
	private String byUserName;
	
	private String Content;
	
	
	
	public Comments() {
		super();
	}

	
	
	public Comments(int commentId, String byUser, String byUserName, String content) {
		super();
		this.commentId = commentId;
		this.byUser = byUser;
		this.byUserName = byUserName;
		Content = content;
	}



	public Comments(int commentId, String byUser, String content) {
		super();
		this.commentId = commentId;
		this.byUser = byUser;
		Content = content;
	}

	
	
	public String getByUserName() {
		return byUserName;
	}

	public void setByUserName(String byUserName) {
		this.byUserName = byUserName;
	}

	public int getCommentId() {
		return commentId;
	}

	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}

	public String getByUser() {
		return byUser;
	}

	public void setByUser(String byUser) {
		this.byUser = byUser;
	}

	public String getContent() {
		return Content;
	}

	public void setContent(String content) {
		Content = content;
	}
	
	
	
}

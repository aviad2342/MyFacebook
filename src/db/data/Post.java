package db.data;

import java.sql.Date;
import java.util.ArrayList;

public class Post {

    private int postId;
	 
	private String toUser;
	
	private String byUser;
	
	private String byUserName;
	
	private Date date;
	
	private String Content;
	
	ArrayList<Comments> comments;
	
	

	public Post() {
		super();
	}

	
	
	public Post(int postId, String toUser, String byUser, String byUserName, Date date, String content) {
		super();
		this.postId = postId;
		this.toUser = toUser;
		this.byUser = byUser;
		this.byUserName = byUserName;
		this.date = date;
		Content = content;
		
	}



	public Post(int postId, String toUser, String byUser, Date date, String content) {
		super();
		this.postId = postId;
		this.toUser = toUser;
		this.byUser = byUser;
		this.date = date;
		Content = content;
	}



	public Post(String toUser, String byUser, Date date, String content) {
		super();
		this.toUser = toUser;
		this.byUser = byUser;
		this.date = date;
		Content = content;
		comments = new ArrayList<>();
	}

	public Post(int postId, String toUser, String byUser, Date date, String content, ArrayList<Comments> comments) {
		super();
		this.postId = postId;
		this.toUser = toUser;
		this.byUser = byUser;
		this.date = date;
		Content = content;
		this.comments = comments;
	}

	
	
	
	public Post(int postId, String toUser, String byUser, String byUserName, Date date, String content,
			ArrayList<Comments> comments) {
		super();
		this.postId = postId;
		this.toUser = toUser;
		this.byUser = byUser;
		this.byUserName = byUserName;
		this.date = date;
		Content = content;
		this.comments = comments;
	}



	public String getByUserName() {
		return byUserName;
	}



	public void setByUserName(String byUserName) {
		this.byUserName = byUserName;
	}



	public int getPostId() {
		return postId;
	}

	public void setPostId(int postId) {
		this.postId = postId;
	}

	public String getToUser() {
		return toUser;
	}

	public void setToUser(String toUser) {
		this.toUser = toUser;
	}

	public String getByUser() {
		return byUser;
	}

	public void setByUser(String byUser) {
		this.byUser = byUser;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getContent() {
		return Content;
	}

	public void setContent(String content) {
		Content = content;
	}

	public ArrayList<Comments> getComments() {
		return comments;
	}

	public void setComments(ArrayList<Comments> comments) {
		this.comments = comments;
	}
	
	public boolean addComment(Comments comment){
		if(comment != null){
			return comments.add(comment);
		}
		return false;
	}



	@Override
	public String toString() {
		return "Post [postId=" + postId + ", toUser=" + toUser + ", byUser=" + byUser + ", byUserName=" + byUserName
				+ ", date=" + date + ", Content=" + Content + ", comments=" + comments + "]";
	}
	

}

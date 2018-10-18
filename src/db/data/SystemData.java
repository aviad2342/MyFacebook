package db.data;

import java.util.ArrayList;

import java.sql.*;



public class SystemData implements java.io.Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private ArrayList<Users> users;
	
	private ArrayList<Message> messages;
	
	//private ArrayList<Post> posts;
	
	Connection conn;
	
	public SystemData() {
		super();
		users = new ArrayList<Users>();
		messages = new ArrayList<Message>();
		//posts = new ArrayList<Post>();
		try {
			conn = new MyConnection().getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	

	//*************************************************************** Insert Methods ************************************************************
	
	public boolean addUser(Users user){
		int val = user.getOnLine()? 1 : 0;
		
   try {
		conn.setAutoCommit(false);
		PreparedStatement ps = conn.prepareStatement("insert into users(UserName, FirstName, LastName, Mail, Password, ProfilePicture, CoverImag, IsConnected) values (?, ?, ?, ?, ?, ?, ?, ?)");
		
        ps.setString(1, user.getUserName());
        ps.setString(2, user.getFirstName().substring(0, 1).toUpperCase()+user.getFirstName().substring(1));
        ps.setString(3, user.getLastName().substring(0, 1).toUpperCase()+user.getLastName().substring(1));
        ps.setString(4, user.getEmail());
        ps.setString(5, user.getPassword());
        ps.setString(6, user.getPicture());
        ps.setString(7, user.getCoverImag());
        ps.setInt(8,  val);
        ps.executeUpdate();
        conn.commit();
        ps.close(); 
	} catch (SQLException e) {
		e.printStackTrace();
		return false;
	}
   return true;
	}// END Of 
	

	
	public boolean addFriend(String userName, String friendUserName){
   try {
		conn.setAutoCommit(false);
		PreparedStatement ps = conn.prepareStatement("insert into friends(UserID1, UserID2) values (?, ?)");
		
        ps.setString(1, userName);
        ps.setString(2, friendUserName);

        ps.executeUpdate();

        conn.commit();
        ps.close(); 
        
	} catch (SQLException e) {
		e.printStackTrace();
		return false;
	}
   return true;
	}// END Of
	
	public boolean addNotification(String userName, String content){
		   try {
				conn.setAutoCommit(false);
				PreparedStatement ps = conn.prepareStatement("insert into notifications(User, NotificationContent) values (?, ?)");
				
		        ps.setString(1, userName);
		        ps.setString(2, content);

		        ps.executeUpdate();

		        conn.commit();
		        ps.close(); 
		        
			} catch (SQLException e) {
				e.printStackTrace();
				return false;
			}
		   return true;
			}// END Of
	
	public int addPost(Post post){
		int i = 0;
   try {
		conn.setAutoCommit(false);
		PreparedStatement ps = conn.prepareStatement("insert into posts(ToUser, ByUser, Date, PostContent) values (?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
		
        ps.setString(1, post.getToUser());
        ps.setString(2, post.getByUser());
        ps.setDate(3, post.getDate());
        ps.setString(4, post.getContent());
        
        ps.executeUpdate();
        ResultSet rs = ps.getGeneratedKeys();
    
        if(rs.next()){
			i = rs.getInt(1);
		 }
        conn.commit();
        ps.close(); 
        return i;
	} catch (SQLException e) {
		e.printStackTrace();
		return i;
	}
	}// END Of
	
	public boolean addComment(Comments comment){
		
		   try {
				conn.setAutoCommit(false);
				PreparedStatement ps = conn.prepareStatement("insert into comments(PostNumber, CommentBy, Comment) values (?, ?, ?)");
				
		        ps.setInt(1, comment.getCommentId());
		        ps.setString(2, comment.getByUser());
		        ps.setString(3, comment.getContent());
		        

		        ps.executeUpdate();
		        conn.commit();
		        ps.close(); 
			} catch (SQLException e) {
				e.printStackTrace();
				return false;
			}
		   return true;
			}// END Of
	
	public boolean IsUserExists(String userName, String password){
		try {
			Statement stat = conn.createStatement();
			ResultSet rs = stat.executeQuery("SELECT count(*) as userFound FROM users where UserName = '"+userName+"' and Password = '"+password+"'");
			 
			 if(rs.next()){
				 if(rs.getInt("userFound") > 0){
					 return true;
				 }
			 }
			 rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		return false;
	}// END Of
	
	//*************************************************************** Remove Methods ************************************************************
	
	
	
	
	//*************************************************************** Update Methods ************************************************************
	
	public void updateUserLogin(String userName, boolean isOnOff){
		int isOn = isOnOff? 1 : 0;
   try {
	   Connection c = new MyConnection().getConnection();
	   Statement st = c.createStatement();
       
	   st.executeUpdate("update users set IsConnected = "+isOn+" WHERE UserName ='"+userName+"'"); 
	} catch (Exception e) {
		e.printStackTrace();	
	}
	}// END Of
	
	
	//*************************************************************** Get Methods ************************************************************
	
	public Users getLogUser(String userName){
		try {
			Statement stat = conn.createStatement();
			ResultSet rs = stat.executeQuery("SELECT * FROM users where UserName = '"+userName+"'");
			 if(rs.next()){ 
              return new Users(rs.getString("FirstName"), rs.getString("LastName"), userName, rs.getString("Password"), rs.getString("Mail"), rs.getString("CoverImag"), rs.getString("ProfilePicture"), true);
			 }
			 rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		return null;
	}// END Of
  
	public String getLogUserName(String userName){
		String name = "";
		try {
			Statement stat = conn.createStatement();
			ResultSet rs = stat.executeQuery("SELECT FirstName,LastName FROM users where UserName = '"+userName+"'");
			 if(rs.next()){ 
				 name = rs.getString("FirstName")+" "+ rs.getString("LastName"); 
			 }
			 rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return name;
		}
		return name;
	}// END Of
	
	
	public ArrayList<Message> getUserMessages(String userName){
		ArrayList<Message> mess = new ArrayList<Message>();
		try {
			Statement stat = conn.createStatement();
			String query = "SELECT MessageID,FirstName, LastName, Content, IsRead FROM users join message on UserName = FromUser where ToUser = '"+userName+"'";
			ResultSet rs = stat.executeQuery(query);
			 
			 while(rs.next()){
				 mess.add(new Message(rs.getInt("MessageID"), rs.getString("FirstName")+" "+rs.getString("LastName"), rs.getString("Content"), rs.getBoolean("IsRead")));
			 }
			 rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		return mess;
	}// END Of
	
	public ArrayList<Users> getUserFriends(String userName){
		ArrayList<Users> friends = new ArrayList<Users>();
		try {
			Statement stat = conn.createStatement();
			String query = "SELECT distinct UserName,FirstName,LastName,Mail,Password,CoverImag,ProfilePicture,IsConnected FROM users join friends where UserName in (SELECT  UserID1 FROM  friends where UserID2 = '"+userName+"') or UserName in (SELECT  UserID2 FROM  friends where UserID1 = '"+userName+"')";
			ResultSet rs = stat.executeQuery(query);
			 
			 while(rs.next()){
				 friends.add(new Users(rs.getString("FirstName"), rs.getString("LastName"), rs.getString("UserName"), rs.getString("Password"), rs.getString("Mail"), rs.getString("CoverImag"), rs.getString("ProfilePicture"), rs.getBoolean("IsConnected")));
			 }
			 rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		return friends;
	}// END Of
	
	public ArrayList<Notification> getUserNotifications(String userName){
		ArrayList<Notification> notification = new ArrayList<Notification>();
		try {
			Statement stat = conn.createStatement();
			String query = "SELECT distinct NotificationID,UserName,FirstName,LastName,NotificationContent FROM users join notifications on UserName = User where User in (SELECT distinct  UserID1 FROM  friends where UserID2 = '"
			+userName+"' union select distinct UserID2 FROM  friends where UserID1 = '"+userName+"')";
			ResultSet rs = stat.executeQuery(query);
			 
			 while(rs.next()){
				 notification.add(new Notification(rs.getInt("NotificationID"), rs.getString("UserName"), rs.getString("FirstName")+" "+rs.getString("LastName"), rs.getString("NotificationContent")));
			 }
			 rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		return notification;
	}// END Of
	
	public boolean isAfriend(String userName,  String friendUserName){
		try {
			Statement stat = conn.createStatement();
			String query = "SELECT distinct UserName FROM users join friends where UserName in (SELECT  UserID1 FROM  friends where UserID2 = '"+userName+"') or UserName in (SELECT  UserID2 FROM  friends where UserID1 = '"+userName+"')";
			ResultSet rs = stat.executeQuery(query);
			 
			 while(rs.next()){
				 if(rs.getString("UserName").equals(friendUserName)){
					 return true;
				 }
				 
			 }
			 rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}// END Of
	
	public ArrayList<Users> getAllRegisteredUser(String userName){
		ArrayList<Users> users = new ArrayList<Users>();
		try {
			Statement stat = conn.createStatement();
			String query = "SELECT * FROM users";
			ResultSet rs = stat.executeQuery(query);
			 
			 while(rs.next()){
				 if(!rs.getString("UserName").equals(userName)){
				 users.add(new Users(rs.getString("FirstName"), rs.getString("LastName"), rs.getString("UserName"), rs.getString("Password"), rs.getString("Mail")));
				 }
			 }
			 rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		return users;
	}// END Of
	
	public ArrayList<Post> getUserPosts(String userName){
		try {
			Statement stat = conn.createStatement();
			String query = "SELECT ToUser,ByUser,PostID,FirstName,LastName,posts.Date ,PostContent FROM posts join users on ByUser = UserName where ToUser ='"+userName+"'";
			ResultSet rs = stat.executeQuery(query);
			ArrayList<Post> posts = new ArrayList<Post>();
			 while(rs.next()){	
				 Statement stat1 = conn.createStatement();
				 String query1 = "SELECT CommentId,FirstName,LastName,CommentBy,Comment FROM comments join users on CommentBy = UserName where PostNumber = "+rs.getInt("PostID")+"";
				 ResultSet rs1 = stat1.executeQuery(query1);
				 ArrayList<Comments> comments = new ArrayList<Comments>();
				 while(rs1.next()){
					 comments.add(new Comments(rs1.getInt("CommentId"), rs1.getString("CommentBy"),rs1.getString("FirstName")+" "+rs1.getString("LastName"), rs1.getString("Comment")));
				 }
				 if(comments.isEmpty()){
				     posts.add(new Post(rs.getInt("PostID"), rs.getString("ToUser"), rs.getString("ByUser"), rs.getString("FirstName")+" "+rs.getString("LastName"),rs.getDate("Date"), rs.getString("PostContent")));
				 }else{
					 posts.add(new Post(rs.getInt("PostID"), rs.getString("ToUser"), rs.getString("ByUser"), rs.getString("FirstName")+" "+rs.getString("LastName"),rs.getDate("Date"), rs.getString("PostContent"),comments)); 
				 }
				 }
			 return posts;
	 
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		
	}// END Of
	
	//*************************************************************** Get Methods ************************************************************
	
	public ArrayList<Message> getMessages() {
		return messages;
	}

	public ArrayList<Users> getUsers() {
		return users; 
	}
	
	public void setMessages(ArrayList<Message> messages) {
		this.messages = messages;
	}

	public boolean removeUser(Users user){
		if(user != null && users.contains(user)){
			return users.remove(user);
		}
		return false;
	}

}

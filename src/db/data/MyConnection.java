package db.data;

import java.sql.*;


public class MyConnection {
	
	private Connection conn;
	static private final String URL = "jdbc:mysql://localhost/facebookdb?useSSL=false";
	static private final String USERNAME = "root";
	static private final String PASSWORD = "1234";

	
	static{
		try {
			//register with DriverManeger
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	  }
		
        public MyConnection() throws Exception {
		super();
		this.conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
	}

        public Connection getConnection(){
	    return conn;
        }

}

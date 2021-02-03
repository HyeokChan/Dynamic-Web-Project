package boardExample;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BoardDAO {
	// DB 연결 정보
	private static final String URL = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
	private static final String USER = "scott";
	private static final String PASSWORD = "tiger";
	private static final String DRIVER_NAME = "oracle.jdbc.driver.OracleDriver";

	// 데이터베이스 연결 메소드
	public Connection getConn() {
		Connection conn = null;
		try {
			Class.forName(DRIVER_NAME);
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
		} catch (ClassNotFoundException e) {
			// syso 후 Ctrl + space ==> System.out.println(); 자동완성됨!
			System.out.println("드라이버를 찾지 못했습니다!");
			e.printStackTrace(); // 상세히 출력
		} catch (SQLException e) {
			System.out.println("연결 실패!");
			e.printStackTrace();
		}
		return conn;
	}

	// JDBC 4단계 : 1. 연결, 2. 명령, 3. 결과, 4. 해제
	// 게시판에 글을 하나 저장
	public int boardInsert(BoardDTO dto) {
		int affected = 0;
		Connection conn = getConn();
		PreparedStatement st = null;
		String sql = "INSERT INTO board(num,title,writer,pwd,content) "
		+ "VALUES((select nvl(max(num),0)+1 as num from board),?,?,?,?)";
		try {
			st = conn.prepareStatement(sql);
			st.setString(1, dto.getTitle());
			st.setString(2, dto.getWriter());
			st.setString(3, dto.getPwd());
			st.setString(4, dto.getContent());
			affected = st.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			// 자원 해제(연결 해제), insert, update, delete 할때
			close(conn, st);
			
		}
		return affected;
	}
	
	public ArrayList<BoardDTO> boardList(int begin, int end){
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		Connection conn = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		// 제일안쪽 select : 정렬위해서
		// 중간 select : rownum, 끝 글번호 위해서
		// 바깥 select : 시작글 번호 위해서
		String sql = 
				"SELECT * FROM (SELECT rownum as rn, A.* "
				+ "FROM (SELECT * FROM board ORDER BY num DESC) A WHERE rownum <= ?) "
				+ "WHERE rn >= ?";
		try{
			conn = getConn();
			st = conn.prepareStatement(sql);
			st.setInt(1, end);
			st.setInt(2, begin);
			rs = st.executeQuery();
			while(rs.next()){
				BoardDTO dto = new BoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setTitle(rs.getString("title"));
				dto.setWriter(rs.getString("writer"));
				dto.setPwd(rs.getString("pwd"));
				dto.setContent(rs.getString("content"));
				dto.setRegdate(rs.getDate("regdate"));
				dto.setHit(rs.getInt("hit"));
				list.add(dto);
			}
		}catch(Exception e){
			System.out.println("boardList 예외 발생");
		}finally{
			close(rs, conn, st);
		}
		return list;
	}
	
	// 페이징 처리 안된 boardList메소드
	/*public ArrayList<BoardDTO> boardList(){
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		Connection conn = null;
		PreparedStatement st = null;
		// 결과 모음, 테이블 데이터
		ResultSet rs = null;
		String sql="SELECT num, title, writer, pwd, content, regdate, hit "
				+ "FROM board ORDER BY num DESC";
		try{
			conn = getConn();//1.연결
			st = conn.prepareStatement(sql);//2.명령
			rs = st.executeQuery(); //select는 Query, 나머지는 Update
			while(rs.next()){
				BoardDTO dto = new BoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setTitle(rs.getString("title"));
				dto.setWriter(rs.getString("writer"));
				dto.setPwd(rs.getString("pwd"));
				dto.setContent(rs.getString("content"));
				dto.setRegdate(rs.getDate("regdate"));
				dto.setHit(rs.getInt("hit"));
				list.add(dto);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			//자원해제 , select 할때
			close(rs, conn, st);
			
		}
		return list;
	}*/

	// 글의 수 얻기
	public int boardCount(){
		int cnt=0;
		Connection conn = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		String sql = "SELECT count(*) cnt FROM board";
		try{
			conn = getConn();
			st = conn.prepareStatement(sql);
			rs = st.executeQuery();
			if(rs.next()){
				cnt = rs.getInt("cnt");
			}
		}catch(Exception e){
			System.out.println("boardCount 예외발생.");
			e.printStackTrace();
		}finally{
			close(rs, conn, st);
		}
		
		return cnt;
	}
	
	// 글 하나 읽기 : select
	public BoardDTO boardRead(int num){
		BoardDTO dto = new BoardDTO();
		Connection conn = null;
		PreparedStatement st = null;
		ResultSet rs = null;
		String sql="SELECT * FROM board WHERE num=?";
		try{
			conn = getConn();//1.연결
			st = conn.prepareStatement(sql);//2.명령
			st.setInt(1, num);
			rs = st.executeQuery(); //select는 Query, 나머지는 Update
			if(rs.next()) {
				dto.setNum(rs.getInt("num"));
				dto.setTitle(rs.getString("title"));
				dto.setWriter(rs.getString("writer"));
				dto.setPwd(rs.getString("pwd"));
				dto.setContent(rs.getString("content"));
				dto.setRegdate(rs.getDate("regdate"));
				dto.setHit(rs.getInt("hit"));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			//자원해제 , select 할때
			close(rs, conn, st);
			
		}
		return dto;
	}
	
	//조회수 증가 메소드
	public void boardUpdateHit(int num) {
		Connection conn = null;
		PreparedStatement st = null;
		String sql = "UPDATE board SET hit=hit+1 WHERE num=?";
		try {
			conn = getConn();
			st = conn.prepareStatement(sql);
			st.setInt(1, num);
			st.executeUpdate();
		}
		catch (Exception e){
			System.out.println("boardUpdateHit 예외 발생");
			e.printStackTrace();
		}finally {
			close(conn, st);
		}		
	}
	
	//글 수정
	public int boardUpdate(BoardDTO dto) {
		int affected=0;
		Connection conn=null;
		PreparedStatement st = null;
		String sql="UPDATE board SET title=?, writer=?, content=? WHERE num=? AND pwd=?";
		try {
			// MyBatis로 대체
			conn = getConn();
			st = conn.prepareStatement(sql);			
			st.setString(1, dto.getTitle());
			st.setString(2, dto.getWriter());
			st.setString(3, dto.getContent());
			st.setInt(4, dto.getNum());
			st.setString(5, dto.getPwd());
			affected = st.executeUpdate();
		}catch(Exception e) {
			System.out.println("boardUpdate 예외발생");
			e.printStackTrace();
		}finally {
			close(conn, st);
		}
		return affected;
	}
	// 글 삭제
	public int boardDelete(BoardDTO dto) {
		int affected=0;
		Connection conn = null;
		PreparedStatement st = null;
		String sql="DELETE FROM board WHERE num=? AND pwd=?";
		try {
			conn = getConn();
			st = conn.prepareStatement(sql);
			st.setInt(1, dto.getNum());
			st.setString(2, dto.getPwd());
			affected = st.executeUpdate();
		}catch(Exception e) {
			System.out.println("boardDelete 예외 발생!");
			e.printStackTrace();
		}finally {
			close(conn, st);
		}
		return affected;
	}
	
	private void close(Connection conn, PreparedStatement st) {
		
		if(st != null){
			try {
				st.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if(conn!=null){
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	private void close(ResultSet rs, Connection conn, PreparedStatement st) {
		if(rs!=null){
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		close(conn, st);
	}
}

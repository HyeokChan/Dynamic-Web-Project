package boardExample;
import java.util.Date;
public class BoardDTO {
	private int num;
	private String title;
	private String writer;
	private String pwd;
	private String content;
	private Date regdate;
	private int hit;
	// 우클릭 > Source > Generate Getters and Setters > 
	// Select ALL > OK
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	@Override
	public String toString() {
		return "BoardDTO [num=" + num + ", title=" + title + ", writer=" + writer + ", pwd=" + pwd + ", content="
				+ content + ", regdate=" + regdate + ", hit=" + hit + "]";
	}
	
	//toString 생성
	
}
//create table board(
//  num number not null, 
//  title varchar2(100) not null,
//  writer varchar2(50) not null,
//  pwd varchar2(50) not null,
//  content varchar2(2000) not null,
//  regdate date default sysdate,
//  hit number default 0,
//  constraint pk_board primary key(num)
//);

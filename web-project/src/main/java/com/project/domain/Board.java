package com.project.domain;

import java.sql.Timestamp;

public class Board {
    private Integer num;
    private String name;
    private String passwd;
    private String subject;
    private String content;
    private String ip;
    private Timestamp reg_date;
    private Integer readcount;
    private Integer re_ref;
    private Integer re_lev;
    private Integer re_seq;
    private String filename;   
    private String notice;
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Board [num=");
		builder.append(num);
		builder.append(", name=");
		builder.append(name);
		builder.append(", passwd=");
		builder.append(passwd);
		builder.append(", subject=");
		builder.append(subject);
		builder.append(", content=");
		builder.append(content);
		builder.append(", ip=");
		builder.append(ip);
		builder.append(", reg_date=");
		builder.append(reg_date);
		builder.append(", readcount=");
		builder.append(readcount);
		builder.append(", re_ref=");
		builder.append(re_ref);
		builder.append(", re_lev=");
		builder.append(re_lev);
		builder.append(", re_seq=");
		builder.append(re_seq);
		builder.append(", filename=");
		builder.append(filename);
		builder.append(", notice=");
		builder.append(notice);
		builder.append("]");
		return builder.toString();
	}
	
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public Integer getReadcount() {
		return readcount;
	}
	public void setReadcount(Integer readcount) {
		this.readcount = readcount;
	}
	public Integer getRe_ref() {
		return re_ref;
	}
	public void setRe_ref(Integer re_ref) {
		this.re_ref = re_ref;
	}
	public Integer getRe_lev() {
		return re_lev;
	}
	public void setRe_lev(Integer re_lev) {
		this.re_lev = re_lev;
	}
	public Integer getRe_seq() {
		return re_seq;
	}
	public void setRe_seq(Integer re_seq) {
		this.re_seq = re_seq;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getNotice() {
		return notice;
	}
	public void setNotice(String notice) {
		this.notice = notice;
	}
    
    
}
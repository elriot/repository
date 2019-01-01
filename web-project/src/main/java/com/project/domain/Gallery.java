package com.project.domain;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Gallery {

    private Integer num;
    private String name;
    private String subject;
    private String content;
    private String ip;
    private Timestamp reg_date;
    private String filename;
    
    private List<Gallery_Reply> repList = new ArrayList<Gallery_Reply>();
    
    public List<Gallery_Reply> getRepList() {
        return repList;
    }

    public void setRepList(List<Gallery_Reply> repList) {
        this.repList = repList;
    }

    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("Gallery [num=");
        builder.append(num);
        builder.append(", name=");
        builder.append(name);
        builder.append(", subject=");
        builder.append(subject);
        builder.append(", content=");
        builder.append(content);
        builder.append(", ip=");
        builder.append(ip);
        builder.append(", reg_date=");
        builder.append(reg_date);
        builder.append(", filename=");
        builder.append(filename);
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

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }
    
    
    
}
    
    
    
    

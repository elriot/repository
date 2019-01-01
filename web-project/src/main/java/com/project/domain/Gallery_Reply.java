package com.project.domain;

import java.sql.Timestamp;

public class Gallery_Reply {
    private Integer num;
    private Integer origin_num;
    private String name;
    private String content;
    private String ip;
    private Timestamp reg_date;
    private Integer re_ref;
    private Integer re_lev;
    private Integer re_seq;
    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("Gallery_Reply [num=");
        builder.append(num);
        builder.append(", origin_num=");
        builder.append(origin_num);
        builder.append(", name=");
        builder.append(name);
        builder.append(", content=");
        builder.append(content);
        builder.append(", ip=");
        builder.append(ip);
        builder.append(", reg_date=");
        builder.append(reg_date);
        builder.append(", re_ref=");
        builder.append(re_ref);
        builder.append(", re_lev=");
        builder.append(re_lev);
        builder.append(", re_seq=");
        builder.append(re_seq);
        builder.append("]");
        return builder.toString();
    }
    public Integer getNum() {
        return num;
    }
    public void setNum(Integer num) {
        this.num = num;
    }
    public Integer getOrigin_num() {
        return origin_num;
    }
    public void setOrigin_num(Integer origin_num) {
        this.origin_num = origin_num;
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
    
    
    

}
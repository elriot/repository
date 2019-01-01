package com.project.domain;

import java.sql.Timestamp;

public class Omember {
    private String id;
    private String passwd;
    private String battletag;
    private String gender;
    private String email;
    private String playmain;
    private String birthday;
    private Timestamp reg_date;
    private String approved;
    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("Omember [id=");
        builder.append(id);
        builder.append(", passwd=");
        builder.append(passwd);
        builder.append(", battletag=");
        builder.append(battletag);
        builder.append(", gender=");
        builder.append(gender);
        builder.append(", email=");
        builder.append(email);
        builder.append(", playmain=");
        builder.append(playmain);
        builder.append(", birthday=");
        builder.append(birthday);
        builder.append(", reg_date=");
        builder.append(reg_date);
        builder.append(", approved=");
        builder.append(approved);
        builder.append("]");
        return builder.toString();
    }
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getPasswd() {
        return passwd;
    }
    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }
    public String getBattletag() {
        return battletag;
    }
    public void setBattletag(String battletag) {
        this.battletag = battletag;
    }
    public String getGender() {
        return gender;
    }
    public void setGender(String gender) {
        this.gender = gender;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getPlaymain() {
        return playmain;
    }
    public void setPlaymain(String playmain) {
        this.playmain = playmain;
    }
    public String getBirthday() {
        return birthday;
    }
    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }
    public Timestamp getReg_date() {
        return reg_date;
    }
    public void setReg_date(Timestamp reg_date) {
        this.reg_date = reg_date;
    }
    public String getApproved() {
        return approved;
    }
    public void setApproved(String approved) {
        this.approved = approved;
    }

    
}

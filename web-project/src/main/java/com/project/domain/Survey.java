package com.project.domain;

import java.sql.Timestamp;

public class Survey {
    private Integer num;
    private String id;
    private Timestamp reg_date;
    private Integer readcount;
    private String finished;
    private String question;
    private String answer1;
    private String answer2;
    private String answer3;
    private String answer4;
    private String answer5;
    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("Survey [num=");
        builder.append(num);
        builder.append(", id=");
        builder.append(id);
        builder.append(", reg_date=");
        builder.append(reg_date);
        builder.append(", readcount=");
        builder.append(readcount);
        builder.append(", finished=");
        builder.append(finished);
        builder.append(", question=");
        builder.append(question);
        builder.append(", answer1=");
        builder.append(answer1);
        builder.append(", answer2=");
        builder.append(answer2);
        builder.append(", answer3=");
        builder.append(answer3);
        builder.append(", answer4=");
        builder.append(answer4);
        builder.append(", answer5=");
        builder.append(answer5);
        builder.append(", getClass()=");
        builder.append(getClass());
        builder.append(", hashCode()=");
        builder.append(hashCode());
        builder.append(", toString()=");
        builder.append(super.toString());
        builder.append("]");
        return builder.toString();
    }
    public Integer getNum() {
        return num;
    }
    public void setNum(Integer num) {
        this.num = num;
    }
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
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
    public String getFinished() {
        return finished;
    }
    public void setFinished(String finished) {
        this.finished = finished;
    }
    public String getQuestion() {
        return question;
    }
    public void setQuestion(String question) {
        this.question = question;
    }
    public String getAnswer1() {
        return answer1;
    }
    public void setAnswer1(String answer1) {
        this.answer1 = answer1;
    }
    public String getAnswer2() {
        return answer2;
    }
    public void setAnswer2(String answer2) {
        this.answer2 = answer2;
    }
    public String getAnswer3() {
        return answer3;
    }
    public void setAnswer3(String answer3) {
        this.answer3 = answer3;
    }
    public String getAnswer4() {
        return answer4;
    }
    public void setAnswer4(String answer4) {
        this.answer4 = answer4;
    }
    public String getAnswer5() {
        return answer5;
    }
    public void setAnswer5(String answer5) {
        this.answer5 = answer5;
    }
    
    
    
}


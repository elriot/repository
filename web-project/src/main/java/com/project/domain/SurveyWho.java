package com.project.domain;

public class SurveyWho {
    private Integer num;
    private String id;
    private Integer vote;
    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("SurveyWho [num=");
        builder.append(num);
        builder.append(", id=");
        builder.append(id);
        builder.append(", vote=");
        builder.append(vote);
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
    public Integer getVote() {
        return vote;
    }
    public void setVote(Integer vote) {
        this.vote = vote;
    }
    
    
    
}

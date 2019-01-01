package com.project.domain;

public class SurveyCount {
    private Integer num;
    private Integer count1;
    private Integer count2;
    private Integer count3;
    private Integer count4;
    private Integer count5;
    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("SurveyCount [num=");
        builder.append(num);
        builder.append(", count1=");
        builder.append(count1);
        builder.append(", count2=");
        builder.append(count2);
        builder.append(", count3=");
        builder.append(count3);
        builder.append(", count4=");
        builder.append(count4);
        builder.append(", count5=");
        builder.append(count5);
        builder.append("]");
        return builder.toString();
    }
    public Integer getNum() {
        return num;
    }
    public void setNum(Integer num) {
        this.num = num;
    }
    public Integer getCount1() {
        return count1;
    }
    public void setCount1(Integer count1) {
        this.count1 = count1;
    }
    public Integer getCount2() {
        return count2;
    }
    public void setCount2(Integer count2) {
        this.count2 = count2;
    }
    public Integer getCount3() {
        return count3;
    }
    public void setCount3(Integer count3) {
        this.count3 = count3;
    }
    public Integer getCount4() {
        return count4;
    }
    public void setCount4(Integer count4) {
        this.count4 = count4;
    }
    public Integer getCount5() {
        return count5;
    }
    public void setCount5(Integer count5) {
        this.count5 = count5;
    }
    
    
    
    }

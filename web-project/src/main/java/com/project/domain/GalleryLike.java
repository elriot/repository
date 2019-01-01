package com.project.domain;

public class GalleryLike {
    
    private Integer num;
    private String name;
    
    @Override
    public String toString() {
        StringBuilder builder = new StringBuilder();
        builder.append("Like [num=");
        builder.append(num);
        builder.append(", name=");
        builder.append(name);
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
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    
    
    
}

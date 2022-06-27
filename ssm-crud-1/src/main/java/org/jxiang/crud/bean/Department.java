package org.jxiang.crud.bean;

public class Department {
    private Integer depId;

    private String depName;

    public Department(Integer depId, String depName) {
        this.depId = depId;
        this.depName = depName;
    }

    public Department() {
    }

    public Integer getDepId() {
        return depId;
    }

    public void setDepId(Integer depId) {
        this.depId = depId;
    }

    public String getDepName() {
        return depName;
    }

    public void setDepName(String depName) {
        this.depName = depName == null ? null : depName.trim();
    }
}
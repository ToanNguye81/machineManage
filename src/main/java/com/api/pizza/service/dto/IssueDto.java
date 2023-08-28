package com.api.pizza.service.dto;

import java.util.Date;
import java.util.List;

import com.api.pizza.entity.ChangedPart;

public class IssueDto {
    // private Integer id;
    private String error;
    private String description;
    private Boolean bigIssue;
    private String ycsc;
    private String notes;
    private Date issueDate;
    private Date start;
    private Date end;
    private String downtime;
    private String status;
    private String createBy;
    private String updateBy;
    private String action;
    private Date updatedDate;
    private Date createDate;
    private List<ChangedPart> changedParts;

    private Integer departmentId;
    private Integer equipmentId;

    // // Constructors, getters, setters
    // public Integer getId() {
    //     return id;
    // };

    // public void setId(Integer id) {
	// 	this.id=id;
	// };

    public String getError() {
        return error;
    };

    public void setError(String error) {
        this.error=error;
    };

    public String getDescription() {
        return description;
    };

    public void setDescription(String description) {
        this.description=description;
    };

    public Boolean getBigIssue() {
        return bigIssue;
    };

    public void setBigIssue(Boolean bigIssue) {
        this.bigIssue=bigIssue;
    };

    public String getYcsc() {
        return ycsc;
    };

    public void setYcsc(String ycsc) {
        this.ycsc=ycsc;
    };

    public String getNotes() {
        return notes;
    };

    public void setNotes(String notes) {
        this.notes=notes;
    };

    public Date getIssueDate() {
        return issueDate;
    };

    public void setIssueDate(Date issueDate) {
        this.issueDate=issueDate;
    };

    public Date getStart() {
        return start;
    };

    public void setStart(Date start) {
        this.start=start;
    };

    public Date getEnd() {
        return end;
    };

    public void setEnd(Date end) {
        this.end=end;
    };

    public String getDowntime() {
        return downtime;
    };

    public void setDowntime(String downtime) {
        this.downtime=downtime;
    };

    public String getStatus() {
        return status;
    };

    public void setStatus(String status) {
        this.status=status;
    };

    public String getCreateBy() {
        return createBy;
    };

    public void setCreateBy(String createBy) {
        this.createBy=createBy;
    };

    public String getUpdateBy() {
        return updateBy;
    };

    public void setUpdateBy(String updateBy) {
        this.updateBy=updateBy;
    };

    public String getAction() {
        return action;
    };

    public void setAction(String action) {
        this.action=action;
    };

    public Date getUpdatedDate() {
        return updatedDate;
    };

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate=updatedDate;
    };

    public Date getCreateDate() {
        return createDate;
    };

    public void setCreateDate(Date createDate) {
        this.createDate=createDate;
    };

    public List<ChangedPart> getChangedParts() {
		return changedParts;
	}
  
    public void setChangedParts(List<ChangedPart> changedParts) {
        this.changedParts=changedParts;
    };

    public void setDepartmentId(Integer departmentId){
        this.departmentId=departmentId;
        
    };
    public Integer  getDepartmentId(){
        return departmentId; 
    };
    public void setEquipmentId(Integer equipmentId){
        this.equipmentId=equipmentId;
        
    };
    public Integer  getEquipmentId(){
        return equipmentId; 
    };

}

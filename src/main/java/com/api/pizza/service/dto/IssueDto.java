package com.api.pizza.service.dto;

import com.api.pizza.entity.ChangedPart;
import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;
import java.util.List;


@Getter
@Setter
public class IssueDto {

    private int id;
    private int departmentId;
    private int equipmentId;
    private String error;
    private String description;
    private Boolean bigIssue;
    private String ycsc;
    private String workOrder;
    // private String notes;


    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+7")
    private Date issueDate;

    @JsonFormat(pattern = "HH:mm:ss", timezone = "GMT+7")
    private Date start;

    @JsonFormat(pattern = "HH:mm:ss", timezone = "GMT+7")
    private Date end;

    @JsonFormat(pattern = "HH:mm:ss", timezone = "GMT+7")
    private String downtime;

    private String status;
    private String action;
    private List<ChangedPart> changedParts;
}
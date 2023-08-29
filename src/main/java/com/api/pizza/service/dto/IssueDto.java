package com.api.pizza.service.dto;

import com.api.pizza.entity.ChangedPart;
import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;

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
    private String notes;

    @JsonFormat(pattern = "HH:mm:ss yyyy-MM-dd", timezone = "GMT+7")
    private String createDate;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+7")
    private String issueDate;

    @JsonFormat(pattern = "HH:mm:ss", timezone = "GMT+7")
    private String start;

    @JsonFormat(pattern = "HH:mm:ss", timezone = "GMT+7")
    private String end;

    @JsonFormat(pattern = "HH:mm:ss", timezone = "GMT+7")
    private String downtime;

    @JsonFormat(pattern = "HH:mm:ss yyyy-MM-dd", timezone = "GMT+7")
    private String updatedDate;

    private String status;
    private String createBy;
    private String updateBy;
    private String action;
    private List<ChangedPart> changedParts;
}
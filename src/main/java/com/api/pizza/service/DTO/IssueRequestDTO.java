package com.api.pizza.service.DTO;
import java.util.Date;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;

import com.api.pizza.entity.Equipment;
public class IssueRequestDTO {
    private Integer departmentId;
    private Integer equipmentId;
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
    private List<ChangedPartDTO> changedParts;
    public Integer getDepartmentId() {
        return null;
    }

// Constructors, getters, setters
}


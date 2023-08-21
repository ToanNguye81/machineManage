package com.api.pizza.entity;

import java.time.LocalTime;
import java.util.Date;
import java.util.List;

import javax.persistence.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "issue")
public class Issue {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", unique = true)
    private int id;

    @Column(name = "department")
    private String department;

    @Column(name = "equipment")
    private String equipment;

    @Column(name = "error")
    private String error;

    @Column(name = "description")
    private String description;

    @Column(name = "big_issue")
    private Boolean bigIssue;

    @Column(name = "ycsc")
    private String ycsc;

    @Column(name = "notes")
    private String notes;

    @Column(name = "create_date")
    @Temporal(TemporalType.TIMESTAMP)
    @CreatedDate
    @JsonFormat(pattern = "HH:mm:ss yyyy-MM-dd", timezone = "GMT+7")
    private Date createDate;

    @Column(name = "issue_date")
    @Temporal(TemporalType.DATE) // Changed to DATE type
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+7")
    private Date issueDate;

    @Column(name = "start")
    @Temporal(TemporalType.TIME)
    @JsonFormat(pattern = "HH:mm:ss", timezone = "GMT+7")
    private Date start; // Changed to Date type

    @Column(name = "end")
    @Temporal(TemporalType.TIME)
    @JsonFormat(pattern = "HH:mm:ss", timezone = "GMT+7")
    private Date end; // Changed to Date type

    @Column(name = "downtime")
    @JsonFormat(pattern = "HH:mm:ss", timezone = "GMT+7")
    private String downtime;

    @Column(name = "updated_date", nullable = true)
    @Temporal(TemporalType.TIMESTAMP)
    @LastModifiedDate
    @JsonFormat(pattern = "HH:mm:ss yyyy-MM-dd", timezone = "GMT+7")
    private Date updatedDate;

    @Column(name = "status")
    private String status;

    @Column(name = "createBy")
    private String createBy;

    @Column(name = "updateBy")
    private String updateBy;

    @Column(name = "action")
    private String action;

    @OneToMany(mappedBy = "issue")
    private List<ChangedPart> changedParts;

}

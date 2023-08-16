package com.api.pizza.entity;

import java.time.Duration;
import java.util.Date;
import java.util.List;

import javax.persistence.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonGetter;

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
    @JsonFormat(pattern = "hh:mm:ss yyyy-MM-dd", timezone = "GMT+7")
    private Date createDate;

    @Column(name = "issue_date")
    @Temporal(TemporalType.TIMESTAMP)
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+7")
    private Date issueDate;

    @Column(name = "start")
    @Temporal(TemporalType.TIMESTAMP)
    @JsonFormat(pattern = "hh:mm:ss yyyy-MM-dd", timezone = "GMT+7")
    private Date start;

    @Column(name = "end")
    @Temporal(TemporalType.TIMESTAMP)
    @JsonFormat(pattern = "hh:mm:ss yyyy-MM-dd", timezone = "GMT+7")
    private Date end;

    @Column(name = "downtime")
    private Duration downtime;

    @Column(name = "updated_date", nullable = true)
    @Temporal(TemporalType.TIMESTAMP)
    @LastModifiedDate
    @JsonFormat(pattern = "hh:mm:ss yyyy-MM-dd", timezone = "GMT+7")
    private Date updatedDate;

    @Column(name = "status")
    private String status;

    @Column(name = "createBy")
    private String createBy;

    @Column(name = "updateBy")
    private String updateBy;

    @Column(name = "action")
    private String action;

    @OneToMany(mappedBy = "issue", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<ChangedPart> changedParts;

}

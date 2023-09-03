package com.api.pizza.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "issue")
@EntityListeners(AuditingEntityListener.class) 
public class Issue {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", unique = true)
    private int id;

    @ManyToOne
    @NotNull(message = "input department")
    @JoinColumn(name = "department_id")
    private Department department;
   
    @ManyToOne
    @NotNull(message = "input equipment")
    @JoinColumn(name = "equipment_id")
    private Equipment equipment;

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

    @CreatedDate
    @Column(name = "create_date")
    @Temporal(TemporalType.TIMESTAMP)
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

    @LastModifiedDate
    @Column(name = "updated_date", nullable = true)
    @Temporal(TemporalType.TIMESTAMP)
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

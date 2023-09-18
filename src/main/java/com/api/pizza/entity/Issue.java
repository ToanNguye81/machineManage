package com.api.pizza.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

// import org.springframework.data.annotation.CreatedDate;
// import org.springframework.data.annotation.LastModifiedDate;
// import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;

@Table(name = "issue")
@Entity
@Getter
@Setter
public class Issue extends BaseEntity {

    // @Id
    // @GeneratedValue(strategy = GenerationType.IDENTITY)
    // @Column(name = "id", unique = true)
    // private int id;

    @ManyToOne
    @NotNull(message = "Department is required")
    @JoinColumn(name = "department_id")
    private Department department;

    @ManyToOne
    @NotNull(message = "Equipment is required")
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

    @Column(name = "status")
    private String status;

    @Column(name = "action")
    private String action;

    @OneToMany(mappedBy = "issue", cascade = CascadeType.ALL)
    private List<ChangedPart> changedParts;

    @Column(name = "createdByUsername")
    private String createdByUsername;

    @Column(name = "updatedByUsername")
    private String updatedByUsername;

    // @LastModifiedDate
    // @Column(name = "updated_date")
    // @Temporal(TemporalType.TIMESTAMP)
    // @JsonFormat(pattern = "HH:mm:ss yyyy-MM-dd", timezone = "GMT+7")
    // private Date updatedDate;

    // @CreatedDate
    // @Column(name = "created_date", updatable = false)
    // @Temporal(TemporalType.TIMESTAMP)
    // @JsonFormat(pattern = "HH:mm:ss yyyy-MM-dd", timezone = "GMT+7")
    // private Date createDate;

}

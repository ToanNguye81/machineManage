package com.api.pizza.entity;

import java.util.Set;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "workOrder")
public class WorkOrder {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", unique = true)
    private int id;

    @Column(name = "code", unique = true)
    private String code;

    @JsonIgnore
    @OneToOne
    @JoinColumn(name = "issue_id") // Tên cột khóa ngoại trong bảng "issue"
    private Issue issue;

}

package com.api.pizza.entity;

import java.util.List;
import java.util.Set;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "department")
public class Department {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", unique = true)
    private int id;

    @Column(name = "code", unique = true)
    @NotNull(message = "input department code")
    private String code;

    @Column(name = "name")
    @NotNull(message = "input department name")
    private String name;


    // @OneToMany(mappedBy = "department", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    // @JsonIgnore
    // private Set<Equipment> equipments;

    @ManyToMany
    @JsonIgnore
    @JoinTable(name = "department_equipment", joinColumns = @JoinColumn(name = "department_id"), inverseJoinColumns = @JoinColumn(name = "equipment_id"))
    private Set<Equipment> equipments;

    @ManyToMany
    @JsonIgnore
    @JoinTable(name = "department_error", joinColumns = @JoinColumn(name = "department_id"), inverseJoinColumns = @JoinColumn(name = "error_id"))
    private Set<Error> errors;

    @OneToMany(mappedBy = "department",cascade = CascadeType.ALL)
    @JsonIgnore
    private List<Issue> issues;
}

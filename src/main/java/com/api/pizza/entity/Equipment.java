package com.api.pizza.entity;

import java.util.List;
import java.util.Set;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "equipment")
public class Equipment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", unique = true)
    private int id;

    @Column(name = "code", unique = true)
    private String code;

    @Column(name = "name", unique = true)
    private String name;

    @ManyToOne
    @JoinColumn(name = "owner_id")
    private Employee employee;
    
    @ManyToMany(mappedBy = "equipments")
    private Set<Component> components;

    @OneToMany(mappedBy = "equipment", cascade = CascadeType.ALL)
    @JsonIgnore
    private List<Issue> issues;

    @ManyToMany(mappedBy = "equipments")
    @JsonIgnore
    private Set<Department> departments;

}

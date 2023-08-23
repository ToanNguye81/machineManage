package com.api.pizza.entity;
import java.util.Set;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "component")
public class Component {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", unique = true)
    private int id;

    @Column(name = "name", unique = true)
    private String name;

    @Column(name = "code", unique = true)
    private String code;

    @Column(name = "description")
    private String description;

    @ManyToMany
    @JsonIgnore
    @JoinTable(name = "component_equipment", joinColumns = @JoinColumn(name = "component_id"), inverseJoinColumns = @JoinColumn(name = "equipment_id"))
    private Set<Equipment> equipments;

}

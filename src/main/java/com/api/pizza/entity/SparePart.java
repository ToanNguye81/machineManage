package com.api.pizza.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "spare_part")
public class SparePart {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", unique = true)
    private int id;

    @Column(name = "code",unique = true)
    private String code;
  
    @Column(name = "spc",unique = true)
    private String spc;

    @Column(name = "name")
    private String name;

    @Column(name = "price")
    private int price;
    
    @Column(name = "min")
    private int min;
    
    @Column(name = "max")
    private int max;
   
    @Column(name = "position")
    private String position;
    
    // @Column(name = "department")
    // private String department;
   
    @Column(name = "unit")
    private String unit;



    @Column(name = "in_Stock")
    private int inStock;



    @Column(name = "image_Url")
    private String imageUrl; // Sử dụng kiểu dữ liệu byte[] cho ảnh
}
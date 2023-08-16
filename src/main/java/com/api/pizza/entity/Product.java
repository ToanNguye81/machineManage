package com.api.pizza.entity;

import java.util.Date;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.data.annotation.LastModifiedDate;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "products")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", unique = true)
    private int id;

    @Column(name = "product_code", unique = true)
    @NotNull(message = "input product code")
    @Size(min = 2, message = "input product code at least 2 characters")
    private String productCode;

    @Column(name = "product_name", unique = true)
    @NotNull(message = "input product name")
    @Size(min = 2, message = "input product name at least 2 characters")
    private String productName;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_date", nullable = true)
    @LastModifiedDate
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+7")
    private Date createdDate;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "updated_date", nullable = true)
    @LastModifiedDate
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+7")
    private Date updatedDate;

}

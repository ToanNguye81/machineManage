package com.api.pizza.entity;

import java.util.Date;
import java.util.List;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "ycsc")
public class Ycsc extends BaseEntity {

    @Column(name = "title")
    private String title;
   
    @Column(name = "number")
    private String number;
    

}

package com.api.pizza.repository;

import java.util.List;

import javax.validation.Valid;

import org.springframework.data.jpa.repository.JpaRepository;

import com.api.pizza.entity.Equipment;

public interface IEquipmentRepository extends JpaRepository<Equipment, Integer> {

    List<Equipment> findByDepartmentsId(@Valid Integer departmentId);
}

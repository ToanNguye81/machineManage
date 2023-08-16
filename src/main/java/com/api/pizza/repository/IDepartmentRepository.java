package com.api.pizza.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.api.pizza.entity.Department;

public interface IDepartmentRepository extends JpaRepository<Department, Integer> {

}

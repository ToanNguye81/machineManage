package com.api.pizza.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.api.pizza.entity.Employee;

public interface IEmployeeRepository extends JpaRepository<Employee, Integer> {

    Employee findByUserId(Long userId);

}

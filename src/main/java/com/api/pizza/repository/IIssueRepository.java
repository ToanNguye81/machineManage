package com.api.pizza.repository;

import java.util.List;
import java.util.Optional;

import javax.validation.Valid;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;

import com.api.pizza.entity.Department;
import com.api.pizza.entity.Equipment;
import com.api.pizza.entity.Issue;

public interface IIssueRepository extends JpaRepository<Issue, Long> {

    List<Issue> findAll(Specification<Issue> specification);

    long countIssuesByEquipmentId(int equipmentId);

    long countIssuesByEquipment(Equipment equipment);

    List<Issue> findByEquipment(Equipment equipment);

    long countIssuesByDepartment(Department department);

    List<Issue> findByEquipmentId(Long equipmentIds);

}
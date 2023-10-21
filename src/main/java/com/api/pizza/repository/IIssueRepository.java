package com.api.pizza.repository;

import java.util.List;

import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;

import com.api.pizza.entity.Issue;

public interface IIssueRepository extends JpaRepository<Issue, Integer> {

    List<Issue> findAll(Specification<Issue> specification);

    long countIssuesByEquipmentId(int equipmentId);

}
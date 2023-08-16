package com.api.pizza.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.api.pizza.entity.Issue;

public interface IIssueRepository extends JpaRepository<Issue, Integer> {

}

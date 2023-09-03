package com.api.pizza.repository;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.api.pizza.entity.ChangedPart;

public interface IChangedPartRepository extends JpaRepository<ChangedPart, Integer> {

    List<ChangedPart> findByIssueId(int issueId);


}

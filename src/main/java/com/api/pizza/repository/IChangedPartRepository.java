package com.api.pizza.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.api.pizza.entity.ChangedPart;

public interface IChangedPartRepository extends JpaRepository<ChangedPart, Integer> {

}

package com.api.pizza.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.api.pizza.entity.SparePart;

public interface ISparePartRepository extends JpaRepository<SparePart, Integer> {

}

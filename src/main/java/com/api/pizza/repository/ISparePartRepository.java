package com.api.pizza.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.api.pizza.entity.SparePart;

public interface ISparePartRepository extends JpaRepository<SparePart, Integer> {

    List<SparePart> findByCodeContainingOrNameContaining(String keyWord, String keyWord2);

}

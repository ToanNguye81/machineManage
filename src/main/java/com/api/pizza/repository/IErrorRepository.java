package com.api.pizza.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.api.pizza.entity.Error;

public interface IErrorRepository extends JpaRepository<Error, Integer> {

}

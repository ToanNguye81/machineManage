package com.api.pizza.controller;

import java.util.List;
import java.util.Optional;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.api.pizza.entity.Department;
import com.api.pizza.repository.IDepartmentRepository;

@RestController
@CrossOrigin
@RequestMapping("/")
public class DepartmentController {
    @Autowired
    IDepartmentRepository departmentRepository;

    // get all Department
    @GetMapping("/department")
    public ResponseEntity<List<Department>> getAllDepartments() {
        try {
            List<Department> departmentList = departmentRepository.findAll();
            Long totalElement = (long) departmentList.size();

            return ResponseEntity.ok()
                    .header("totalCount", String.valueOf(totalElement))
                    .body(departmentList);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // create new de
    @PostMapping("/department")
    public ResponseEntity<Object> createNewDepartment(
            @Valid @RequestBody Department pDepartment) {
        try {
            Department vDepartment = new Department();
            vDepartment.setName(pDepartment.getName());
            vDepartment.setCode(pDepartment.getCode());
            Department vDepartmentSave = departmentRepository.save(vDepartment);
            return new ResponseEntity<>(vDepartmentSave, HttpStatus.CREATED);
        } catch (Exception e) {
            return ResponseEntity.unprocessableEntity()
                    .body("Failed to Create specified Department: " + e.getCause().getCause().getMessage());
        }

    }

    // get de by id
    @GetMapping("/department/{departmentId}")
    public ResponseEntity<Object> getNameById(
            @PathVariable Integer departmentId) {
        Optional<Department> vDepartmentData = departmentRepository.findById(departmentId);
        if (vDepartmentData.isPresent()) {
            try {
                Department vDepartment = vDepartmentData.get();
                return new ResponseEntity<>(vDepartment, HttpStatus.OK);
            } catch (Exception e) {
                return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            Department vDepartmentNull = new Department();
            return new ResponseEntity<>(vDepartmentNull, HttpStatus.NOT_FOUND);
        }
    }

    // Update de by id
    @PutMapping("/department/{departmentId}")
    public ResponseEntity<Object> updateDepartment(
            @PathVariable Integer departmentId,
            @Valid @RequestBody Department pDepartment) {
        Optional<Department> vDepartmentData = departmentRepository.findById(departmentId);
        if (vDepartmentData.isPresent()) {
            try {
                Department vDepartment = vDepartmentData.get();
                vDepartment.setName(pDepartment.getName());
                vDepartment.setCode(pDepartment.getCode());

                Department vDepartmentSave = departmentRepository.save(vDepartment);
                return new ResponseEntity<>(vDepartmentSave, HttpStatus.OK);
            } catch (Exception e) {
                return ResponseEntity.unprocessableEntity()
                        .body("Failed to Update specified Department: " + e.getCause().getCause().getMessage());
            }
        } else {
            Department vDepartmentNull = new Department();
            return new ResponseEntity<>(vDepartmentNull, HttpStatus.NOT_FOUND);
        }
    }

    // Delete de by id
    @DeleteMapping("/department/{departmentId}")
    public ResponseEntity<Object> deleteDepartmentById(
            @PathVariable Integer departmentId) {
        Optional<Department> vDepartmentData = departmentRepository.findById(departmentId);
        if (vDepartmentData.isPresent()) {
            try {
                departmentRepository.deleteById(departmentId);
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            } catch (Exception e) {
                return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            Department vDepartmentNull = new Department();
            return new ResponseEntity<>(vDepartmentNull, HttpStatus.NOT_FOUND);
        }
    }

}

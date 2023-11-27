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

import com.api.pizza.entity.Equipment;
import com.api.pizza.entity.Department;
import com.api.pizza.repository.IDepartmentRepository;
import com.api.pizza.repository.IEquipmentRepository;

@RestController
@CrossOrigin
@RequestMapping("/")
public class EquipmentController {
    @Autowired
    IEquipmentRepository equipmentRepository;
    @Autowired
    IDepartmentRepository departmentRepository;

    // get all Equipment
    @GetMapping("/equipment")
    public ResponseEntity<List<Equipment>> getAllEquipments() {
        try {
            List<Equipment> equipmentList = equipmentRepository.findAll();
            Long totalElement = (long) equipmentList.size();

            return ResponseEntity.ok()
                    .header("totalCount", String.valueOf(totalElement))
                    .body(equipmentList);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // get equipment by id
    @GetMapping("/equipment/{equipmentId}")
    public ResponseEntity<Object> getEquipmentById(@PathVariable Integer equipmentId) {
        Optional<Equipment> vEquipmentData = equipmentRepository.findById(equipmentId);
        if (vEquipmentData.isPresent()) {
            try {
            Equipment vEquipment = vEquipmentData.get();
            return new ResponseEntity<>(vEquipment, HttpStatus.OK);
            } catch (Exception e) {
                return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            Equipment vEquipmentNull = new Equipment();
            return new ResponseEntity<>(vEquipmentNull, HttpStatus.NOT_FOUND);
        }
    }

    // create new equipment
    @PostMapping("/department/{departmentId}/equipment")
    public ResponseEntity<Object> createNewEquipment(@Valid @RequestBody Equipment pEquipment,
            @PathVariable Integer departmentId) {
        Optional<Department> vDepartmentData = departmentRepository.findById(departmentId);
        if (vDepartmentData.isPresent()) {
            try {
                Equipment vEquipment = new Equipment();

                vEquipment.setCode(pEquipment.getCode());
                vEquipment.setName(pEquipment.getName());

                // save equipment & return
                Equipment vSavedEquipment = equipmentRepository.save(vEquipment);
                return new ResponseEntity<>(vSavedEquipment, HttpStatus.CREATED);
            } catch (Exception e) {
                return ResponseEntity.unprocessableEntity()
                        .body("Failed to Create specified Equipment: " + e.getCause().getCause().getMessage());
            }
        } else {
            Department vDepartmentNull = new Department();
            return new ResponseEntity<>(vDepartmentNull, HttpStatus.NOT_FOUND);
        }

    }


    @GetMapping("/department/{departmentId}/equipment")
public ResponseEntity<Object> getEquipmentByDepartmentId(@Valid @PathVariable Integer departmentId) {
    List<Equipment> equipmentList = equipmentRepository.findByDepartmentsId(departmentId);
    return new ResponseEntity<>(equipmentList, HttpStatus.OK);
}

    // Update equipment by id
    @PutMapping("/department/{departmentId}/equipment/{equipmentId}")
    public ResponseEntity<Object> updateEquipment(
            @PathVariable Integer departmentId,
            @PathVariable Integer equipmentId,
            @Valid @RequestBody Equipment pEquipment) {
        Optional<Equipment> vEquipmentData = equipmentRepository.findById(equipmentId);
        if (vEquipmentData.isPresent()) {
            Optional<Department> vDepartmentData = departmentRepository.findById(departmentId);
            if (vDepartmentData.isPresent()) {
                try {
                    Equipment vEquipment = vEquipmentData.get();

                    vEquipment.setCode(pEquipment.getCode());
                    vEquipment.setName(pEquipment.getName());

                    Equipment vSavedEquipment = equipmentRepository.save(vEquipment);
                    return new ResponseEntity<>(vSavedEquipment, HttpStatus.OK);
                } catch (Exception e) {
                    return ResponseEntity.unprocessableEntity()
                            .body("Failed to Update specified Department: " + e.getCause().getCause().getMessage());
                }
            } else {
                Equipment vEquipmentNull = new Equipment();
                return new ResponseEntity<>(vEquipmentNull, HttpStatus.NOT_FOUND);
            }
        } else {
            Department vDepartmentNull = new Department();
            return new ResponseEntity<>(vDepartmentNull, HttpStatus.NOT_FOUND);
        }
    }

    // Delete equipment by id
    @DeleteMapping("/equipment/{equipmentId}")
    public ResponseEntity<Object> deleteEquipmentById(@PathVariable Integer equipmentId) {
        Optional<Equipment> vEquipmentData = equipmentRepository.findById(equipmentId);
        if (vEquipmentData.isPresent()) {
            try {
                equipmentRepository.deleteById(equipmentId);
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            } catch (Exception e) {
                return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            Equipment vEquipmentNull = new Equipment();
            return new ResponseEntity<>(vEquipmentNull, HttpStatus.NOT_FOUND);
        }
    }

}

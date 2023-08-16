package com.api.pizza.controller;

import java.util.List;
import java.util.Optional;
import java.util.Set;

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

import com.api.pizza.entity.Error;
import com.api.pizza.entity.Department;
import com.api.pizza.repository.IDepartmentRepository;
import com.api.pizza.repository.IErrorRepository;

@RestController
@CrossOrigin
@RequestMapping("/")
public class ErrorController {
    @Autowired
    IErrorRepository gErrorRepository;
    @Autowired
    IDepartmentRepository gDepartmentRepository;

    // get all Error
    @GetMapping("/error")
    public ResponseEntity<List<Error>> getAllErrors() {
        try {
            List<Error> errorList = gErrorRepository.findAll();
            Long totalElement = (long) errorList.size();

            return ResponseEntity.ok()
                    .header("totalCount", String.valueOf(totalElement))
                    .body(errorList);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // get error by id
    @GetMapping("/error/{errorId}")
    public ResponseEntity<Object> getErrorById(@PathVariable Integer errorId) {
        Optional<Error> vErrorData = gErrorRepository.findById(errorId);
        if (vErrorData.isPresent()) {
            try {
                Error vError = vErrorData.get();
                return new ResponseEntity<>(vError, HttpStatus.OK);
            } catch (Exception e) {
                return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            Error vErrorNull = new Error();
            return new ResponseEntity<>(vErrorNull, HttpStatus.NOT_FOUND);
        }
    }

    // create new error
    @PostMapping("/department/{departmentId}/error")
    public ResponseEntity<Object> createNewError(@Valid @RequestBody Error pError,
            @PathVariable Integer departmentId) {
        Optional<Department> vDepartmentData = gDepartmentRepository.findById(departmentId);
        if (vDepartmentData.isPresent()) {
            try {
                Error vError = new Error();

                vError.setDescription(pError.getDescription());
                vError.setName(pError.getName());

                // save error & return
                Error vSavedError = gErrorRepository.save(vError);
                return new ResponseEntity<>(vSavedError, HttpStatus.CREATED);
            } catch (Exception e) {
                return ResponseEntity.unprocessableEntity()
                        .body("Failed to Create specified Error: " + e.getCause().getCause().getMessage());
            }
        } else {
            Department vDepartmentNull = new Department();
            return new ResponseEntity<>(vDepartmentNull, HttpStatus.NOT_FOUND);
        }

    }

    // get error by department id
    @GetMapping("/department/{departmentId}/error")
    public List<Error> getErrorsByDepartmentId(@PathVariable int departmentId) {
        Department department = gDepartmentRepository.findById(departmentId).orElse(null);
        if (department != null) {
            Set<Error> errors = department.getErrors();
            return List.copyOf(errors);
        }
        return null; // Hoặc trả về một ResponseEntity khác để xử lý trường hợp không tìm thấy thiết
                     // bị
    }

    // Update error by id
    @PutMapping("/department/{departmentId}/error/{errorId}")
    public ResponseEntity<Object> updateError(
            @PathVariable Integer departmentId,
            @PathVariable Integer errorId,
            @Valid @RequestBody Error pError) {
        Optional<Error> vErrorData = gErrorRepository.findById(errorId);
        if (vErrorData.isPresent()) {
            Optional<Department> vDepartmentData = gDepartmentRepository.findById(departmentId);
            if (vDepartmentData.isPresent()) {
                try {
                    Error vError = vErrorData.get();

                    vError.setDescription(pError.getDescription());
                    vError.setName(pError.getName());

                    Error vSavedError = gErrorRepository.save(vError);
                    return new ResponseEntity<>(vSavedError, HttpStatus.OK);
                } catch (Exception e) {
                    return ResponseEntity.unprocessableEntity()
                            .body("Failed to Update specified Department: " + e.getCause().getCause().getMessage());
                }
            } else {
                Error vErrorNull = new Error();
                return new ResponseEntity<>(vErrorNull, HttpStatus.NOT_FOUND);
            }
        } else {
            Department vDepartmentNull = new Department();
            return new ResponseEntity<>(vDepartmentNull, HttpStatus.NOT_FOUND);
        }
    }

    // Delete error by id
    @DeleteMapping("/error/{errorId}")
    private ResponseEntity<Object> deleteErrorById(@PathVariable Integer errorId) {
        Optional<Error> vErrorData = gErrorRepository.findById(errorId);
        if (vErrorData.isPresent()) {
            try {
                gErrorRepository.deleteById(errorId);
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            } catch (Exception e) {
                return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            Error vErrorNull = new Error();
            return new ResponseEntity<>(vErrorNull, HttpStatus.NOT_FOUND);
        }
    }

}

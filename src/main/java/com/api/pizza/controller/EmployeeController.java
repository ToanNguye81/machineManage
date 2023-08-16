package com.api.pizza.controller;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.api.pizza.entity.Employee;
import com.api.pizza.entity.User;
import com.api.pizza.repository.IEmployeeRepository;
import com.api.pizza.repository.UserRepository;
import com.api.pizza.security.UserPrincipal;

@RestController
@CrossOrigin
@RequestMapping("/")
public class EmployeeController {
    @Autowired
    IEmployeeRepository employeeRepository;
    @Autowired
    UserRepository userRepository;

    // get all Employee
    @GetMapping("/employee")
    public ResponseEntity<List<Employee>> getAllEmployees() {
        try {
<<<<<<< HEAD
            List<Employee> employeeList = employeeRepository.findAll();
            Long totalElement = (long) employeeList.size();
=======
            // tạo ra một đối tượng Pageable để đại diện cho thông tin về phân trang.
            Pageable pageable = PageRequest.of(page, size);
            Page<Employee> employeePage = gEmployeeRepository.findAll(pageable);
            List<Employee> employeeList = employeePage.getContent();
            Long totalElement = employeePage.getTotalElements();
>>>>>>> 4bae4ffc16fb9c5849f13c41e8b82191c15ab5c4

            return ResponseEntity.ok()
                    .header("totalCount", String.valueOf(totalElement))
                    .body(employeeList);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // create new employee
    @PostMapping("/employee")
    public ResponseEntity<Object> createNewEmployee(
            @Valid @RequestBody Employee pEmployee,
            @AuthenticationPrincipal UserPrincipal currentUser) {
        try {
            // Kiểm tra xem bản ghi khách hàng đã tồn tại với ID người dùng này chưa
            Employee existingEmployee = employeeRepository.findByUserId(currentUser.getUserId());
            if (existingEmployee != null) {
                return ResponseEntity.badRequest()
                        .body("A employee record already exists for this user.");
            }

            // Lấy thông tin người dùng từ bảng User
            User user = userRepository.findByUsername(currentUser.getUsername());
            // Tạo employee
            Employee vEmployee = new Employee();
            vEmployee.setCreatedDate(new Date());
            vEmployee.setCode(pEmployee.getCode());
            vEmployee.setName(pEmployee.getName());
            vEmployee.setPhone(pEmployee.getPhone());
            vEmployee.setEmail(pEmployee.getEmail());
            vEmployee.setUser(user);
            Employee vEmployeeSave = employeeRepository.save(vEmployee);
            // ghi khách hàng

            return new ResponseEntity<>(vEmployeeSave, HttpStatus.CREATED);
        } catch (Exception e) {
            return ResponseEntity.unprocessableEntity()
                    .body("Failed to Create specified Employee: " + e.getCause().getCause().getMessage());
        }
    }

    // get employee by id
    @GetMapping("/employee/{employeeId}")
    public ResponseEntity<Object> getEmployeeById(
            @PathVariable Integer employeeId) {
        Optional<Employee> vEmployeeData = employeeRepository.findById(employeeId);
        if (vEmployeeData.isPresent()) {
            try {
                Employee vEmployee = vEmployeeData.get();
                return new ResponseEntity<>(vEmployee, HttpStatus.OK);
            } catch (Exception e) {
                return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            Employee vEmployeeNull = new Employee();
            return new ResponseEntity<>(vEmployeeNull, HttpStatus.NOT_FOUND);
        }
    }

    // Update employee by id
    @PutMapping("/employee/{employeeId}")
    public ResponseEntity<Object> updateEmployee(
            @PathVariable Integer employeeId,
            @Valid @RequestBody Employee pEmployee) {
        Optional<Employee> vEmployeeData = employeeRepository.findById(employeeId);
        if (vEmployeeData.isPresent()) {
            try {
                Employee vEmployee = new Employee();
                vEmployee.setUpdatedDate(new Date());
                vEmployee.setCode(pEmployee.getCode());
                vEmployee.setName(pEmployee.getName());
                vEmployee.setPhone(pEmployee.getPhone());
                vEmployee.setEmail(pEmployee.getEmail());
                Employee vEmployeeSave = employeeRepository.save(vEmployee);
                return new ResponseEntity<>(vEmployeeSave, HttpStatus.OK);
            } catch (Exception e) {
                return ResponseEntity.unprocessableEntity()
                        .body("Failed to Update specified Employee: " + e.getCause().getCause().getMessage());
            }
        } else {
            Employee vEmployeeNull = new Employee();
            return new ResponseEntity<>(vEmployeeNull, HttpStatus.NOT_FOUND);
        }
    }

    // Delete employee by id
    @DeleteMapping("/employee/{employeeId}")
    private ResponseEntity<Object> deleteEmployeeById(
            @PathVariable Integer employeeId) {
        Optional<Employee> vEmployeeData = employeeRepository.findById(employeeId);
        if (vEmployeeData.isPresent()) {
            try {
                employeeRepository.deleteById(employeeId);
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            } catch (Exception e) {
                return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            Employee vEmployeeNull = new Employee();
            return new ResponseEntity<>(vEmployeeNull, HttpStatus.NOT_FOUND);
        }
    }

}

package com.api.pizza.controller;

import com.api.pizza.entity.Issue;
import com.api.pizza.entity.ChangedPart;
import com.api.pizza.entity.Department;
import com.api.pizza.repository.IChangedPartRepository;
import com.api.pizza.repository.IDepartmentRepository;
import com.api.pizza.repository.IEquipmentRepository;
import com.api.pizza.repository.IIssueRepository;
import com.api.pizza.service.dto.IssueDto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;


@RestController
@RequestMapping("/")
public class IssueController {
    @Autowired
    private final IIssueRepository issueRepository;
    
    @Autowired
    IChangedPartRepository changedPartRepository;
    
    @Autowired
    IDepartmentRepository departmentRepository;
    
    @Autowired
    IEquipmentRepository equipmentRepository;

    @Autowired
    public IssueController(IIssueRepository issueRepository) {
        this.issueRepository = issueRepository;
    }

    // Get all issues
    @GetMapping("/issue")
    public List<Issue> getAllIssues() {
        return issueRepository.findAll();
    }

    // Get issue by ID
    @GetMapping("/issue/{id}")
    public ResponseEntity<Issue> getIssueById(@PathVariable int id) {
        Issue issue = issueRepository.findById(id)
                .orElse(null);

        if (issue == null) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.ok(issue);
    }

    // Create a new issue
    @PostMapping("/issue")
    public ResponseEntity<Object> createNewIssue(
            @RequestBody IssueDto pIssueDto) {
        System.out.println("======================");
        try {
            Issue newIssue = convertFromIssueDto(pIssueDto);
            
        Department department = departmentRepository.findById(pIssueDto.getDepartmentId()).orElse(null);
        if (department != null) {
            newIssue.setDepartment(department);
        }
            newIssue.setCreateDate(new Date());
            newIssue.setAction(pIssueDto.getAction());
            newIssue.setIssueDate(pIssueDto.getIssueDate());
            newIssue.setBigIssue(pIssueDto.getBigIssue());
            newIssue.setChangedParts(pIssueDto.getChangedParts());
            newIssue.setCreateBy(pIssueDto.getCreateBy());
            newIssue.setDepartment(pIssueDto.getDepartmentId());
            newIssue.setDescription(pIssueDto.getDescription());
            newIssue.setDowntime(pIssueDto.getDowntime());
            newIssue.setEnd(pIssueDto.getEnd());
            newIssue.setEquipment(pIssueDto.getEquipmentId());
            newIssue.setError(pIssueDto.getError());
            newIssue.setStart(pIssueDto.getStart());
            newIssue.setNotes(pIssueDto.getNotes());
            newIssue.setStatus(pIssueDto.getStatus());
            newIssue.setUpdateBy(pIssueDto.getUpdateBy());
            newIssue.setYcsc(pIssueDto.getYcsc());
            Issue savedIssue = issueRepository.save(newIssue);
            // Set changed parts
            List<ChangedPart> changedParts = pIssueDto.getChangedParts();
            if (changedParts != null) {
                for (ChangedPart changedPart : changedParts) {
                    changedPart.setIssue(savedIssue); // Set the parent Issue
                    changedPart.setCode(changedPart.getCode()); // Set the parent Issue
                    changedPart.setName(changedPart.getName()); // Set the parent Issue
                    changedPart.setPrice(changedPart.getPrice()); // Set the parent Issue
                    changedPart.setQuantity(changedPart.getQuantity()); // Set the parent Issue
                    changedPartRepository.save(changedPart); // Save the associated ChangedParts
                }
            }

            return new ResponseEntity<>(savedIssue, HttpStatus.CREATED);
        } catch (Exception e) {
            return ResponseEntity.unprocessableEntity()
                    .body("Failed to Create specified Issue: " + e.getCause().getCause().getMessage());
        }
    }

    // Update an existing issue
    @PutMapping("/issue/{id}")
    public ResponseEntity<Issue> updateIssue(@PathVariable int id, @RequestBody Issue updatedIssue) {
        Issue issue = issueRepository.findById(id)
                .orElse(null);

        if (issue == null) {
            return ResponseEntity.notFound().build();
        }

        // Update properties of the issue
        issue.setDescription(updatedIssue.getDescription());
        issue.setNotes(updatedIssue.getNotes());
        // Update other properties as needed

        Issue savedIssue = issueRepository.save(issue);
        return ResponseEntity.ok(savedIssue);
    }

    // Delete an issue
    @DeleteMapping("/issue/{id}")
    public ResponseEntity<Void> deleteIssue(@PathVariable int id) {
        Issue issue = issueRepository.findById(id)
                .orElse(null);

        if (issue == null) {
            return ResponseEntity.notFound().build();
        }

        issueRepository.delete(issue);
        return ResponseEntity.noContent().build();
    }
}

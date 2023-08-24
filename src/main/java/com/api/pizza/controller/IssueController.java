package com.api.pizza.controller;

import com.api.pizza.entity.Issue;
import com.api.pizza.entity.ChangedPart;
import com.api.pizza.repository.IChangedPartRepository;
import com.api.pizza.repository.IIssueRepository;
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
            @RequestBody Issue pIssue) {
        System.out.println("======================");
        try {
            Issue newIssue = new Issue();
            newIssue.setCreateDate(new Date());
            newIssue.setAction(pIssue.getAction());
            newIssue.setIssueDate(pIssue.getIssueDate());
            newIssue.setBigIssue(pIssue.getBigIssue());
            newIssue.setChangedParts(pIssue.getChangedParts());
            newIssue.setCreateBy(pIssue.getCreateBy());
            newIssue.setDepartment(pIssue.getDepartment());
            newIssue.setDescription(pIssue.getDescription());
            newIssue.setDowntime(pIssue.getDowntime());
            newIssue.setEnd(pIssue.getEnd());
            newIssue.setEquipment(pIssue.getEquipment());
            newIssue.setError(pIssue.getError());
            newIssue.setStart(pIssue.getStart());
            newIssue.setNotes(pIssue.getNotes());
            newIssue.setStatus(pIssue.getStatus());
            newIssue.setUpdateBy(pIssue.getUpdateBy());
            newIssue.setYcsc(pIssue.getYcsc());
            Issue savedIssue = issueRepository.save(newIssue);
            // Set changed parts
            List<ChangedPart> changedParts = pIssue.getChangedParts();
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

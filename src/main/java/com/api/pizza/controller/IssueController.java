package com.api.pizza.controller;

import com.api.pizza.entity.ChangedPart;
import com.api.pizza.entity.Issue;
import com.api.pizza.repository.IChangedPartRepository;
import com.api.pizza.repository.IDepartmentRepository;
import com.api.pizza.repository.IEquipmentRepository;
import com.api.pizza.repository.IIssueRepository;
import com.api.pizza.service.IssueService;
import com.api.pizza.service.dto.IssueDto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import javax.validation.Valid;


@RestController
@CrossOrigin
@RequestMapping("/")
public class IssueController {
    @Autowired
    private final IIssueRepository issueRepository;
    
    @Autowired
    IChangedPartRepository changedPartRepository;
   
    @Autowired
    IssueService issueService;
    
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
   
    @PostMapping("/issue")
public ResponseEntity<Object> createIssue(@Valid @RequestBody IssueDto issueDto) {
    try {
        System.out.println("===========================");
        // Issue newIssue = issueService.convertToIssue(issueDto);
        System.out.println("=========newIssue==================");
        // System.out.println(newIssue);
        // Save the new issue using the IssueServiceImpl (Assuming you have a save method)
        Issue savedIssue = issueService.saveIssueFromDto(issueDto); // Using saveIssueFromDto method
        List<ChangedPart> changedParts = savedIssue.getChangedParts();
        for (ChangedPart changedPart : changedParts) {
            changedPart.setIssue(savedIssue);
           changedPartRepository.save(changedPart);
        }
        return new ResponseEntity<>(savedIssue, HttpStatus.CREATED);
    } catch (Exception e) {
        String errorMessage = "Failed to create specified Issue: " + e.getMessage();
        return ResponseEntity.unprocessableEntity().body(errorMessage);
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

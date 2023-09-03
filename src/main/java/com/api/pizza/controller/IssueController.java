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
import java.util.Optional;
import java.util.ArrayList;

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
            // Save the new issue using the IssueServiceImpl (Assuming you have a save
            // method)
            Issue newIssue = new Issue();
            Issue savedIssue = issueService.saveIssueFromDto(newIssue, issueDto); // Using saveIssueFromDto method
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

    // Update issue
    @PutMapping("/issue/{issueId}")
    public ResponseEntity<Issue> updateIssue(@PathVariable int issueId, @RequestBody IssueDto issueDto) {
        Issue existingIssue = issueRepository.findById(issueId).orElse(null);

        if (existingIssue == null) {
            return new ResponseEntity<>(null, HttpStatus.NOT_FOUND);
        }

        // Update issue
        Issue updatedIssue = issueService.saveIssueFromDto(existingIssue, issueDto);

        // Delete all old ChangedPart entities by issue ID
        List<ChangedPart> oldChangedParts = changedPartRepository.findByIssueId(issueId);
        for (ChangedPart oldPart : oldChangedParts) {
            changedPartRepository.deleteById(oldPart.getId());
        }

        List<ChangedPart> newChangedParts = new ArrayList<>();

        for (ChangedPart oldChangedPart : updatedIssue.getChangedParts()) {
            ChangedPart newChangedPart = new ChangedPart();
            newChangedPart.setCode(oldChangedPart.getCode());
            newChangedPart.setName(oldChangedPart.getName());
            newChangedPart.setQuantity(oldChangedPart.getQuantity());
            newChangedPart.setIssue(updatedIssue); // Associate with the updated issue
            newChangedParts.add(newChangedPart);
        }
        
        changedPartRepository.saveAll(newChangedParts);
        
        // Return the updated issue
        return ResponseEntity.ok(updatedIssue);
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

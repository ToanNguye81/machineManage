package com.api.pizza.controller;

import com.api.pizza.entity.ChangedPart;
import com.api.pizza.entity.Department;
import com.api.pizza.entity.Equipment;
import com.api.pizza.entity.Issue;
import com.api.pizza.repository.IChangedPartRepository;
import com.api.pizza.repository.IDepartmentRepository;
import com.api.pizza.repository.IEquipmentRepository;
import com.api.pizza.repository.IIssueRepository;
import com.api.pizza.security.UserPrincipal;
import com.api.pizza.service.IssueService;
import com.api.pizza.service.dto.IssueDto;
import com.api.pizza.specification.IssueSpecification;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.time.Duration;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;

import javax.validation.Valid;

@RestController
@CrossOrigin
@RequestMapping("/")
// @PreAuthorize("hasRole('EMPLOYEE')")
public class IssueController {
    @Autowired
    IIssueRepository issueRepository;

    @Autowired
    IChangedPartRepository changedPartRepository;

    @Autowired
    IssueService issueService;

    @Autowired
    IDepartmentRepository departmentRepository;

    @Autowired
    IEquipmentRepository equipmentRepository;

    // get all issue
    @PreAuthorize("hasAnyRole('EMPLOYEE','ADMIN','MANAGER')")
    @GetMapping(value = "/issue")
    public ResponseEntity<List<Issue>> getAllIssue(
            @RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "6000") int size) {
        // tạo ra một đối tượng Pageable để đại diện cho thông tin về phân trang.
        Pageable pageable = PageRequest.of(page, size,Sort.by("createdAt").descending());
        // truy vấn CSDL và trả về một trang của đối tượng CIssue với thông tin trang
        Page<Issue> issuePage = issueRepository.findAll(pageable);
        // để lấy danh sách các đối tượng
        List<Issue> issueList = issuePage.getContent();
        // Đếm tổng phần tử
        Long totalElement = issuePage.getTotalElements();
        // Trả về thành công
        return ResponseEntity.ok()
                .header("totalCount", String.valueOf(totalElement))
                .body(issueList);
    }

    // Ver 1
    // @PreAuthorize("hasAnyRole('EMPLOYEE','ADMIN','MANAGER')")
    @GetMapping(value = "/issue/search")
    public ResponseEntity<List<Issue>> searchIssues(
            @RequestParam(name = "departmentId", required = false) String departmentId,
            @RequestParam(name = "equipmentId", required = false) String equipmentId,
            @RequestParam(name = "error", required = false) String error,
            @RequestParam(name = "ycsc", required = false) String ycsc,
            @RequestParam(name = "issueDateStart", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate issueDateStart,
            @RequestParam(name = "issueDateEnd", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate issueDateEnd,
            @RequestParam(name = "createDateStart", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate createDateStart,
            @RequestParam(name = "createDateEnd", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate createDateEnd,
            @RequestParam(name = "workOrder", required = false) String workOrder,
            @RequestParam(name = "status", required = false) String status
            // @RequestParam(name = "bigIssue", required = false) Boolean bigIssue,
            ) {
        Specification<Issue> specification = IssueSpecification.filterByParameters(
                departmentId, equipmentId, error,
                //  bigIssue,
                 ycsc,
                 workOrder,
                issueDateStart, issueDateEnd, createDateStart, createDateEnd,
                status);

        List<Issue> issues = issueService.getFilteredIssues(specification);

        return ResponseEntity.ok(issues);
    }

    // get issue by id
    @GetMapping("/issue/{issueId}")
    public ResponseEntity<Object> getIssueById(@Valid @PathVariable Long issueId) {
        Optional<Issue> vIssueData = issueRepository.findById(issueId);
        if (vIssueData.isPresent()) {
            Issue vIssue = vIssueData.get();
            return new ResponseEntity<>(vIssue, HttpStatus.OK);
        } else {
            Issue vIssueNull = new Issue();
            return new ResponseEntity<>(vIssueNull, HttpStatus.NOT_FOUND);
        }
    }

    // Create new issue
    @PreAuthorize("hasAnyRole('EMPLOYEE','ADMIN','MANAGER')")
    @PostMapping("/issue")
    public ResponseEntity<Object> createIssue(@Valid @RequestBody IssueDto issueDto, Authentication authentication) {
        try {
            Issue newIssue = new Issue();
            UserPrincipal userPrincipal = (UserPrincipal) authentication.getPrincipal();
            String createdByUsername = userPrincipal.getUsername();
            newIssue.setCreatedByUsername(createdByUsername);

            // Using saveIssueFromDto method to create newIssue
            Issue savedIssue = issueService.saveIssueFromDto(newIssue, issueDto);

            // Add changedPart
            List<ChangedPart> newChangedParts = issueDto.getChangedParts();
            ArrayList<ChangedPart> changedPartArr = new ArrayList<>();
            for (ChangedPart changedPart : newChangedParts) {
                changedPart.setIssue(savedIssue);
                changedPartRepository.save(changedPart);
                changedPartArr.add(changedPart);
            }
            savedIssue.setChangedParts(changedPartArr);
            return new ResponseEntity<>(savedIssue, HttpStatus.CREATED);
        } catch (Exception e) {
            String errorMessage = "Failed to create specified Issue: " + e.getMessage();
            return ResponseEntity.unprocessableEntity().body(errorMessage);
        }
    }

    // Update issue
    @PutMapping("/issue/{issueId}")
    public ResponseEntity<Issue> updateIssue(@PathVariable Long issueId, Authentication authentication,
            @Valid @RequestBody IssueDto issueDto) {
        // Find existingIssue
        Issue existingIssue = issueRepository.findById(issueId).orElse(null);

        if (existingIssue == null) {
            return new ResponseEntity<>(null, HttpStatus.NOT_FOUND);
        }

        // get username update_ing
        UserPrincipal userPrincipal = (UserPrincipal) authentication.getPrincipal();
        String updateByUsername = userPrincipal.getUsername();
        existingIssue.setUpdatedByUsername(updateByUsername);

        // Update issue
        Issue updatedIssue = issueService.saveIssueFromDto(existingIssue, issueDto);

        // Delete all old ChangedPart entities by issue ID
        List<ChangedPart> oldChangedParts = changedPartRepository.findByIssueId(issueId);
        for (ChangedPart oldPart : oldChangedParts) {
            changedPartRepository.deleteById(oldPart.getId());
        }

        // Update changedParts
        List<ChangedPart> newChangedParts = issueDto.getChangedParts();
        for (ChangedPart changedPart : newChangedParts) {
            changedPart.setIssue(updatedIssue);
            changedPartRepository.save(changedPart);
        }

        // Return the updated issue
        return new ResponseEntity<>(updatedIssue, HttpStatus.OK);
    }

    // Delete issue by id
    @DeleteMapping("/issue/{issueId}")
    public ResponseEntity<Object> deleteIssueById(@PathVariable Long issueId) {
        Optional<Issue> vIssueData = issueRepository.findById(issueId);
        if (vIssueData.isPresent()) {
            try {
                issueRepository.deleteById(issueId);
                return new ResponseEntity<>(HttpStatus.NO_CONTENT);
            } catch (Exception e) {
                return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
            }
        } else {
            Issue vIssueNull = new Issue();
            return new ResponseEntity<>(vIssueNull, HttpStatus.NOT_FOUND);
        }
    }

    // Count issue by equipment
    @GetMapping("/issue/equipment/issue-count")
    public ResponseEntity<Object> getIssueCountByEquipment(@RequestParam List<Integer> equipmentIds) {
        try {
            List<Map<String, Object>> issueList = new ArrayList<>();

            for (Integer equipmentId : equipmentIds) {
                Equipment equipment = equipmentRepository.findById(equipmentId).orElse(null);
                if (equipment != null) {
                    long issueCount = issueRepository.countIssuesByEquipment(equipment);
                    Map<String, Object> issueMap = new HashMap<>();
                    issueMap.put("equipmentId", equipmentId);
                    issueMap.put("equipmentName", equipment.getName());
                    issueMap.put("issueCount", issueCount);
                    issueList.add(issueMap);
                }
            }

            return ResponseEntity.ok().body(issueList);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Count issue by department
    @GetMapping("/issue/department/issue-count")
    public ResponseEntity<Object> getIssueCountByDepartment(@RequestParam List<Integer> departmentIds) {
        try {
            List<Map<String, Object>> issueList = new ArrayList<>();

            for (Integer departmentId : departmentIds) {
                Department department = departmentRepository.findById(departmentId).orElse(null);
                if (department != null) {
                    long issueCount = issueRepository.countIssuesByDepartment(department);
                    Map<String, Object> issueMap = new HashMap<>();
                    issueMap.put("departmentId", departmentId);
                    issueMap.put("departmentName", department.getName());
                    issueMap.put("issueCount", issueCount);
                    issueList.add(issueMap);
                }
            }

            return ResponseEntity.ok().body(issueList);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Data for timeline chart
    @GetMapping("/issue/equipment/timeline-count")
    public ResponseEntity<Object> getIssueTimelineByEquipment(@RequestParam List<Integer> equipmentIds) {
        try {
            List<Map<String, Object>> timelineData = new ArrayList<>();

            for (Integer equipmentId : equipmentIds) {
                Equipment equipment = equipmentRepository.findById(equipmentId).orElse(null);
                if (equipment != null) {
                    List<Issue> issues = issueRepository.findByEquipment(equipment);

                    for (Issue issue : issues) {
                        Map<String, Object> event = new HashMap<>();
                        event.put("equipmentId", equipmentId);
                        event.put("equipmentName", equipment.getName());
                        event.put("issueCount", issues.size());
                        event.put("issueDate", issue.getIssueDate()); // Thêm thông tin về thời gian sự kiện

                        timelineData.add(event);
                    }
                }
            }

            return ResponseEntity.ok().body(timelineData);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    
    @GetMapping("/issue/equipment/total-downtime")
    public ResponseEntity<List<Map<String, Object>>> calculateTotalDowntimeByEquipmentIds(@RequestParam List<Integer> equipmentIds) {
        List<Map<String, Object>> equipmentDowntimes = new ArrayList<>();
    
        for (Integer equipmentId : equipmentIds) {
            Equipment equipment = equipmentRepository.findById(equipmentId).orElse(null);
            if (equipment == null) {
                // Handle the case where equipment is not found for the given ID
                Map<String, Object> info = new HashMap<>();
                info.put("equipmentId", equipmentId);
                info.put("equipmentName", "Equipment not found");
                info.put("downtimeTotal", "N/A");
                equipmentDowntimes.add(info);
            } else {
                List<Issue> issues = issueRepository.findByEquipment(equipment);
    
                // Calculate total downtime for the retrieved issues
                Duration totalDowntime = Duration.ZERO;
    
                for (Issue issue : issues) {
                    if (issue.getDowntime() != null) {
                        String[] parts = issue.getDowntime().split(":");
                        if (parts.length == 3) {
                            int hours = Integer.parseInt(parts[0]);
                            int minutes = Integer.parseInt(parts[1]);
                            int seconds = Integer.parseInt(parts[2]);
                            totalDowntime = totalDowntime.plusHours(hours).plusMinutes(minutes).plusSeconds(seconds);
                        }
                    }
                }
    
                // Convert the total downtime duration to a formatted string
                long totalHours = totalDowntime.toHours();
                long totalMinutes = totalDowntime.toMinutesPart();
                long totalSeconds = totalDowntime.toSecondsPart();
    
                Map<String, Object> info = new HashMap<>();
                info.put("equipmentId", equipmentId);
                info.put("equipmentName", equipment.getName());
                info.put("downtimeTotal", String.format("%02d:%02d:%02d", totalHours, totalMinutes, totalSeconds));
                equipmentDowntimes.add(info);
            }
        }
    
        return ResponseEntity.ok(equipmentDowntimes);
    }
    
    

}

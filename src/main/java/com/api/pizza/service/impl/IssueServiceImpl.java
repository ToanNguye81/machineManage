package com.api.pizza.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.api.pizza.entity.Issue;
import com.api.pizza.repository.IDepartmentRepository;
import com.api.pizza.repository.IEquipmentRepository;
import com.api.pizza.repository.IIssueRepository;
import com.api.pizza.service.IssueService;
import com.api.pizza.service.dto.IssueDto;
import com.api.pizza.specification.IssueSpecification;

@Service
public class IssueServiceImpl implements IssueService {

    @Autowired
    private IDepartmentRepository departmentRepository;

    @Autowired
    private IEquipmentRepository equipmentRepository;

    @Autowired
    private IIssueRepository issueRepository;

    @Override
    public Issue saveIssueFromDto(Issue issue, IssueDto dto) {
        Issue savedIssue = convertToIssue(issue, dto); // Chuyển đổi từ DTO sang Issue
        return issueRepository.save(savedIssue); // Lưu đối tượng Issue vào cơ sở dữ liệu
    }

    private Issue convertToIssue(Issue issue, IssueDto dto) {
        issue.setDepartment(departmentRepository.findById(dto.getDepartmentId()).orElse(null));
        issue.setEquipment(equipmentRepository.findById(dto.getEquipmentId()).orElse(null));
        issue.setError(dto.getError());
        issue.setDescription(dto.getDescription());
        issue.setBigIssue(dto.getBigIssue());
        issue.setYcsc(dto.getYcsc());
        issue.setNotes(dto.getNotes());
        issue.setIssueDate(dto.getIssueDate());
        issue.setStart(dto.getStart());
        issue.setEnd(dto.getEnd());
        issue.setDowntime(dto.getDowntime());
        issue.setStatus(dto.getStatus());
        issue.setAction(dto.getAction());
        // issue.setChangedParts(dto.getChangedParts());
        return issue;
    }

    @Override
    public List<Issue> getFilteredIssues(Specification<Issue> specification) {
        return issueRepository.findAll(specification);
    }
}
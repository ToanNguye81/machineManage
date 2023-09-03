package com.api.pizza.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.api.pizza.entity.Issue;
import com.api.pizza.repository.IDepartmentRepository;
import com.api.pizza.repository.IEquipmentRepository;
import com.api.pizza.repository.IIssueRepository;
import com.api.pizza.service.IssueService;
import com.api.pizza.service.dto.IssueDto;


@Service
public class IssueServiceImpl implements IssueService {

    @Autowired
    private IDepartmentRepository departmentRepo;

    @Autowired
    private IEquipmentRepository equipmentRepo;

    @Autowired
    private IIssueRepository issueRepo;

    @Override
    public Issue saveIssueFromDto(Issue issue, IssueDto dto) {
        Issue savedIssue = convertToIssue(issue,dto); // Chuyển đổi từ DTO sang Issue
        return issueRepo.save(savedIssue); // Lưu đối tượng Issue vào cơ sở dữ liệu
    }

    private Issue convertToIssue(Issue issue,IssueDto dto) {
        issue.setDepartment(departmentRepo.findById(dto.getDepartmentId()).orElse(null));
        issue.setDepartment(departmentRepo.findById(dto.getDepartmentId()).orElse(null));
        issue.setEquipment(equipmentRepo.findById(dto.getEquipmentId()).orElse(null));
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
        issue.setChangedParts(dto.getChangedParts());
        return issue;
    }

}
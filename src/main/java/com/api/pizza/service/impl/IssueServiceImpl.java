package com.api.pizza.service.impl;

import java.util.Date;

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
    public Issue saveIssueFromDto(IssueDto dto) {
        Issue issue = convertToIssue(dto); // Chuyển đổi từ DTO sang Issue
        return issueRepo.save(issue); // Lưu đối tượng Issue vào cơ sở dữ liệu
    }

    private Issue convertToIssue(IssueDto dto) {
        Issue issue = new Issue();
        issue.setDepartment(departmentRepo.findById(dto.getDepartmentId()).orElse(null));
        issue.setEquipment(equipmentRepo.findById(dto.getEquipmentId()).orElse(null));
        issue.setError(dto.getError());
        issue.setDescription(dto.getDescription());
        issue.setBigIssue(dto.getBigIssue());
        issue.setYcsc(dto.getYcsc());
        issue.setNotes(dto.getNotes());
        issue.setIssueDate(dto.getIssueDate()); // Chuyển đổi chuỗi ngày sang Date
        issue.setStart(dto.getStart()); // Chuyển đổi chuỗi thời gian sang Date
        issue.setEnd(dto.getEnd()); // Chuyển đổi chuỗi thời gian sang Date
        issue.setDowntime(dto.getDowntime());
        issue.setStatus(dto.getStatus());
        issue.setCreateBy(dto.getCreateBy());
        issue.setUpdateBy(dto.getUpdateBy());
        issue.setAction(dto.getAction());
        issue.setChangedParts(dto.getChangedParts());
        issue.setCreateDate(new Date());
        issue.setUpdatedDate(new Date());
        return issue;
    }
}
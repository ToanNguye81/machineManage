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
    IDepartmentRepository departmentRepo;

    @Autowired
    IIssueRepository issueRepo;

    @Autowired
    IEquipmentRepository equipmentRepo;

    // đổi từ IssueDto sang đối tượng Issue để add vào db
    public Issue convertFromIssueDto(IssueDto dto) {
        Issue Issue = new Issue();
        Issue.setDepartment(departmentRepo.findById(dto.getDepartmentId()).get());
        Issue.setEquipment(equipmentRepo.findById(dto.getEquipmentId()).get());
        Issue.setError(dto.getError());
        Issue.setDescription(dto.getDescription());
        Issue.setBigIssue(dto.getBigIssue());
        Issue.setYcsc(dto.getYcsc());
        Issue.setNotes(dto.getNotes());
        Issue.setIssueDate(dto.getIssueDate());
        Issue.setStart(dto.getStart());
        Issue.setEnd(dto.getEnd());
        Issue.setDowntime(dto.getDowntime());
        Issue.setStatus(dto.getStatus());
        Issue.setCreateBy(dto.getCreateBy());
        Issue.setUpdateBy(dto.getUpdateBy());
        Issue.setAction(dto.getAction());
        Issue.setUpdatedDate(dto.getUpdatedDate());
        Issue.setCreateDate(dto.getCreateDate());
        Issue.setChangedParts(dto.getChangedParts());
        return Issue;
    }

}

package com.api.pizza.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.api.pizza.entity.Issue;
import com.api.pizza.entity.ChangedPart;
import com.api.pizza.repository.IDepartmentRepository;
import com.api.pizza.repository.IEquipmentRepository;
import com.api.pizza.repository.IIssueRepository;
import com.api.pizza.service.IssueService;
import com.api.pizza.service.dto.IssueDto;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class IssueServiceImpl implements IssueService {

    @Autowired
    private IDepartmentRepository departmentRepo;

    @Autowired
    private IEquipmentRepository equipmentRepo;

    @Autowired
    private IIssueRepository issueRepo;

    private SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss yyyy-MM-dd");

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
        issue.setIssueDate(parseDate(dto.getIssueDate())); // Chuyển đổi chuỗi ngày sang Date
        issue.setStart(parseTime(dto.getStart())); // Chuyển đổi chuỗi thời gian sang Date
        issue.setEnd(parseTime(dto.getEnd())); // Chuyển đổi chuỗi thời gian sang Date
        issue.setDowntime(dto.getDowntime());
        issue.setStatus(dto.getStatus());
        issue.setCreateBy(dto.getCreateBy());
        issue.setUpdateBy(dto.getUpdateBy());
        issue.setAction(dto.getAction());
        issue.setChangedParts(dto.getChangedParts());
        
        return issue;
    }

    private Date parseDate(String dateStr) {
        try {
            return dateFormat.parse(dateStr);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    private Date parseTime(String timeStr) {
        try {
            return dateFormat.parse("1970-01-01 " + timeStr);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    // private List<ChangedPart> convertChangedParts(List<ChangedPart> changedPartDtos) {
    //     List<ChangedPart> changedParts = new ArrayList<>();
    //     for (ChangedPart changedPartDto : changedPartDtos) {
    //         // Không cần chuyển đổi ChangedPart từ DTO nữa, vì đối tượng ChangedPart đã được sử dụng trong IssueDto
    //         changedParts.add(changedPartDto);
    //     }
    //     return changedParts;
    // }
}

package com.api.pizza.service;

import java.util.List;

import org.springframework.data.jpa.domain.Specification;

import com.api.pizza.entity.Issue;
import com.api.pizza.service.dto.IssueDto;

public interface IssueService {
    Issue saveIssueFromDto(Issue issue, IssueDto dto);

    List<Issue> getFilteredIssues(Specification<Issue> specification);
}

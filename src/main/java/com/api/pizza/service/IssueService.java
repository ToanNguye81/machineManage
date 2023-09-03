package com.api.pizza.service;

import com.api.pizza.entity.Issue;
import com.api.pizza.service.dto.IssueDto;

public interface IssueService {
    Issue saveIssueFromDto(Issue issue,IssueDto dto);
}

package com.api.pizza.specification;

import com.api.pizza.entity.Issue;
import org.springframework.data.jpa.domain.Specification;
import javax.persistence.criteria.Predicate;
import java.util.Date;
import java.util.Objects;

public class IssueSpecification {

    public static Specification<Issue> filterByParameters(
            String departmentId, String equipmentId, String error, Boolean bigIssue,
            String ycsc, Date issueDateStart, Date issueDateEnd,
            Date createDateStart, Date createDateEnd, String status) {
        return (root, query, criteriaBuilder) -> {
            Predicate predicate = criteriaBuilder.conjunction();

            if (!Objects.equals(departmentId, "")) {
                predicate = criteriaBuilder.and(predicate,
                        criteriaBuilder.equal(root.get("department").get("id"), departmentId));
            }

            if (!Objects.equals(equipmentId, "")) {
                predicate = criteriaBuilder.and(predicate,
                        criteriaBuilder.equal(root.get("equipment").get("id"), equipmentId));
            }

            if (!Objects.equals(error, "")) {
                predicate = criteriaBuilder.and(predicate,
                        criteriaBuilder.equal(root.get("error"), error));
            }

            if (bigIssue != null) {
                predicate = criteriaBuilder.and(predicate,
                        criteriaBuilder.equal(root.get("bigIssue"), bigIssue));
            }

            if (!Objects.equals(ycsc, "")) {
                predicate = criteriaBuilder.and(predicate,
                        criteriaBuilder.equal(root.get("ycsc"), ycsc));
            }

            if (issueDateStart != null && issueDateEnd != null) {
                predicate = criteriaBuilder.and(predicate,
                        criteriaBuilder.between(root.get("issueDate"), issueDateStart, issueDateEnd));
            }

            if (createDateStart != null && createDateEnd != null) {
                predicate = criteriaBuilder.and(predicate,
                        criteriaBuilder.between(root.get("createDate"), createDateStart, createDateEnd));
            }

            if (!Objects.equals(status, "")) {
                predicate = criteriaBuilder.and(predicate,
                        criteriaBuilder.equal(root.get("status"), status));
            }

            return predicate;
        };
    }
}
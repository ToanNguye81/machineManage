package com.api.pizza.entity;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Getter
@Setter
/*
 * MappedSuperclass
 * Annotation này cho biết rằng BaseEntity là một superclass (lớp cha) và sẽ
 * không có một bảng cơ sở dữ liệu riêng cho nó. Thay vào đó, các entity class
 * khác có thể kế thừa các thuộc tính từ lớp này và sử dụng chung các thuộc tính
 * đánh dấu bởi @CreatedDate, @LastModifiedDate, @CreatedBy, và @LastModifiedBy.
 */
@MappedSuperclass
/*
 * EntityListeners(AuditingEntityListener.class)
 * Annotation này liên kết lớp với một AuditingEntityListener, một thành phần
 * của Spring Data JPA, để tự động cập nhật các trường được đánh dấu
 * bởi @CreatedDate, @LastModifiedDate, @CreatedBy, và @LastModifiedBy khi các
 * thay đổi diễn ra.
 */
@EntityListeners(AuditingEntityListener.class)
public abstract class BaseEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(columnDefinition = "boolean default false")
	private boolean deleted = false;

	@CreatedDate
	private Date createdAt = new Date();

	@LastModifiedDate
	private Date updatedAt = new Date();

	@CreatedBy
	private Long createdBy;

	@LastModifiedBy
	private Long updatedBy;
	
    // Các getter và setter cho createdByUsername và updatedByUsername

	/**
	 * @return the id
	 */
	public Long getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(Long id) {
		this.id = id;
	}

	/**
	 * @return the deleted
	 */
	public boolean isDeleted() {
		return deleted;
	}

	/**
	 * @param deleted the deleted to set
	 */
	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}

	/**
	 * @return the createdAt
	 */
	public Date getCreatedAt() {
		return createdAt;
	}

	/**
	 * @param createdAt the createdAt to set
	 */
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	/**
	 * @return the updatedAt
	 */
	public Date getUpdatedAt() {
		return updatedAt;
	}

	/**
	 * @param updatedAt the updatedAt to set
	 */
	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
	
}

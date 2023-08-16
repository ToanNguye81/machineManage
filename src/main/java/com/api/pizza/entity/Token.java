package com.api.pizza.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.Date;

@Entity
<<<<<<< HEAD
@Table(name = "token")
=======
@Table(name = "t_token")
>>>>>>> 4bae4ffc16fb9c5849f13c41e8b82191c15ab5c4
@Getter
@Setter
public class Token extends BaseEntity {

	@Column(length = 1000)
	private String token;

	private Date tokenExpDate;

	/**
	 * @return the token
	 */
	public String getToken() {
		return token;
	}

	/**
	 * @param token the token to set
	 */
	public void setToken(String token) {
		this.token = token;
	}

	/**
	 * @return the tokenExpDate
	 */
	public Date getTokenExpDate() {
		return tokenExpDate;
	}

	/**
	 * @param tokenExpDate the tokenExpDate to set
	 */
	public void setTokenExpDate(Date tokenExpDate) {
		this.tokenExpDate = tokenExpDate;
	}

}

package com.api.pizza.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
<<<<<<< HEAD

import com.fasterxml.jackson.annotation.JsonIgnore;

=======
>>>>>>> 4bae4ffc16fb9c5849f13c41e8b82191c15ab5c4
import java.util.HashSet;
import java.util.Set;

@Entity
<<<<<<< HEAD
@Table(name = "role")
=======
@Table(name = "t_role")
>>>>>>> 4bae4ffc16fb9c5849f13c41e8b82191c15ab5c4
@Getter
@Setter
public class Role extends BaseEntity {

	private String roleName;

	private String roleKey;

<<<<<<< HEAD
	@JsonIgnore
	@ManyToMany(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER)
	@JoinTable(name = "role_permission", joinColumns = { @JoinColumn(name = "role_id") }, inverseJoinColumns = {
=======
	@ManyToMany(cascade = CascadeType.REFRESH, fetch = FetchType.EAGER)
	@JoinTable(name = "t_role_permission", joinColumns = { @JoinColumn(name = "role_id") }, inverseJoinColumns = {
>>>>>>> 4bae4ffc16fb9c5849f13c41e8b82191c15ab5c4
			@JoinColumn(name = "permission_id") })
	private Set<Permission> permissions = new HashSet<>();

	/**
	 * @return the roleName
	 */
	public String getRoleName() {
		return roleName;
	}

	/**
	 * @param roleName the roleName to set
	 */
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	/**
	 * @return the roleKey
	 */
	public String getRoleKey() {
		return roleKey;
	}

	/**
	 * @param roleKey the roleKey to set
	 */
	public void setRoleKey(String roleKey) {
		this.roleKey = roleKey;
	}

	/**
	 * @return the permissions
	 */
	public Set<Permission> getPermissions() {
		return permissions;
	}

	/**
	 * @param permissions the permissions to set
	 */
	public void setPermissions(Set<Permission> permissions) {
		this.permissions = permissions;
	}
}

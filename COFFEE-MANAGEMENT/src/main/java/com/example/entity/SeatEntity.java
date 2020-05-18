package com.example.entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.*;

@Entity
@Table(name = "seat")
public class SeatEntity extends BaseEntity {
	
	@Column(name = "name")
	private String name;

	@Column(name = "code")
	private String code;

	@Column(name = "status")
	private String status;
	
	@OneToMany(mappedBy = "seat")
    private List<BillEntity> bills = new ArrayList<>();

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public List<BillEntity> getBills() {
		return bills;
	}

	public void setBills(List<BillEntity> bills) {
		this.bills = bills;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}

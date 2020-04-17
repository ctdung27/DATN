package com.example.entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "material")
public class MaterialEntity extends BaseEntity {
	
	@Column(name = "name")
	private String name;

	@Column(name = "code")
	private String code;
	
	@Column(name = "price")
	private Integer price;
	
	@OneToMany(mappedBy = "material")
    private List<MaterialDetailEntity> materialDetails = new ArrayList<>();

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

	public Integer getPrice() {
		return price;
	}

	public void setPrice(Integer price) {
		this.price = price;
	}

	public List<MaterialDetailEntity> getMaterialDetails() {
		return materialDetails;
	}

	public void setMaterialDetails(List<MaterialDetailEntity> materialDetails) {
		this.materialDetails = materialDetails;
	}
}

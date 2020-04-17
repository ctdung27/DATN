package com.example.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "materialdetail")
public class MaterialDetailEntity extends BaseEntity {
	
	@Column(name = "input")
	private Integer input;

	@Column(name = "output")
	private Integer output;
	
	@Column(name = "type")
	private String type;
	
	@Column(name = "totalprice")
	private Integer totalPrice;
	
	@ManyToOne
	@JoinColumn(name = "materialid")
	private MaterialEntity material;

	public Integer getInput() {
		return input;
	}

	public void setInput(Integer input) {
		this.input = input;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Integer getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(Integer totalPrice) {
		this.totalPrice = totalPrice;
	}

	public Integer getOutput() {
		return output;
	}

	public void setOutput(Integer output) {
		this.output = output;
	}

	public MaterialEntity getMaterial() {
		return material;
	}

	public void setMaterial(MaterialEntity material) {
		this.material = material;
	}	
}

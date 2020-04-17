package com.example.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "bill")
public class BillEntity extends BaseEntity {
	
	@Column(name = "status")
	private String status;
	
	@Column(name = "quantity")
	private Integer quantity;
	
	@Column(name = "totalprice")
	private Integer totalPrice;
	
	@ManyToOne
	@JoinColumn(name = "seatid")
	private SeatEntity seat;
	
	@ManyToOne
	@JoinColumn(name = "productid")
	private ProductEntity product;

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public Integer getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(Integer totalPrice) {
		this.totalPrice = totalPrice;
	}

	public ProductEntity getProduct() {
		return product;
	}

	public void setProduct(ProductEntity product) {
		this.product = product;
	}

	public SeatEntity getSeat() {
		return seat;
	}

	public void setSeat(SeatEntity seat) {
		this.seat = seat;
	}
}

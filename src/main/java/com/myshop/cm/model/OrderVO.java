package com.myshop.cm.model;

import java.sql.Timestamp;

public class OrderVO {
	private int ord_num;
	private int mem_num;
	private int ord_totalprice;
	private String ord_delnum;
	private String ord_request;
	private String ord_status;
	private Timestamp ord_date;
	
	public int getOrd_num() {
		return ord_num;
	}
	public void setOrd_num(int ord_num) {
		this.ord_num = ord_num;
	}
	public int getOrd_memnum() {
		return mem_num;
	}
	public void setOrd_memnum(int mem_num) {
		this.mem_num = mem_num;
	}
	public String getOrd_request() {
		return ord_request;
	}
	public void setOrd_request(String ord_request) {
		this.ord_request = ord_request;
	}
	public int getOrd_totalprice() {
		return ord_totalprice;
	}
	public void setOrd_totalprice(int ord_totalprice) {
		this.ord_totalprice = ord_totalprice;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public String getOrd_delnum() {
		return ord_delnum;
	}
	public void setOrd_delnum(String ord_delnum) {
		this.ord_delnum = ord_delnum;
	}
	public String getOrd_status() {
		return ord_status;
	}
	public void setOrd_status(String ord_status) {
		this.ord_status = ord_status;
	}
	public Timestamp getOrd_date() {
		return ord_date;
	}
	public void setOrd_date(Timestamp ord_date) {
		this.ord_date = ord_date;
	}

}
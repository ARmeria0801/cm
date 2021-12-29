package com.myshop.cm.model;

import java.sql.Timestamp;

public class OrderListVO {
	
	private int ol_num;
	private int ord_num;
	private int gds_num;
	private int opt_num;
	private int ol_count;
	private String gds_seller;
	
	// order테이블 정보
	private int mem_num;
	private int ord_totalprice;
	private String ord_delnum;
	private String ord_request;
	private String ord_status;
	private Timestamp ord_date;
	
	// 주문정보를 토대로 받아올 추가정보들
    private String gds_thumbnail;
    private String gds_name;
    private int gds_price;
    private String mem_id;
    private String opt_1stname;
    private String opt_1stval; 
    private String opt_2ndname;
    private String opt_2ndval;
    private int deltem_delfee;
	
	public int getOl_num() {
		return ol_num;
	}
	public void setOl_num(int ol_num) {
		this.ol_num = ol_num;
	}
	public int getOrd_num() {
		return ord_num;
	}
	public void setOrd_num(int ord_num) {
		this.ord_num = ord_num;
	}
	public int getGds_num() {
		return gds_num;
	}
	public void setGds_num(int gds_num) {
		this.gds_num = gds_num;
	}
	public int getOpt_num() {
		return opt_num;
	}
	public void setOpt_num(int opt_num) {
		this.opt_num = opt_num;
	}
	public int getOl_count() {
		return ol_count;
	}
	public void setOl_count(int ol_count) {
		this.ol_count = ol_count;
	}
	public String getGds_seller() {
		return gds_seller;
	}
	public void setGds_seller(String gds_seller) {
		this.gds_seller = gds_seller;
	}
	
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public int getOrd_totalprice() {
		return ord_totalprice;
	}
	public void setOrd_totalprice(int ord_totalprice) {
		this.ord_totalprice = ord_totalprice;
	}
	public String getOrd_delnum() {
		return ord_delnum;
	}
	public void setOrd_delnum(String ord_delnum) {
		this.ord_delnum = ord_delnum;
	}
	public String getOrd_request() {
		return ord_request;
	}
	public void setOrd_request(String ord_request) {
		this.ord_request = ord_request;
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
	public String getGds_thumbnail() {
		return gds_thumbnail;
	}
	public void setGds_thumbnail(String gds_thumbnail) {
		this.gds_thumbnail = gds_thumbnail;
	}
	public String getGds_name() {
		return gds_name;
	}
	public void setGds_name(String gds_name) {
		this.gds_name = gds_name;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getOpt_1stname() {
		return opt_1stname;
	}
	public void setOpt_1stname(String opt_1stname) {
		this.opt_1stname = opt_1stname;
	}
	public String getOpt_1stval() {
		return opt_1stval;
	}
	public void setOpt_1stval(String opt_1stval) {
		this.opt_1stval = opt_1stval;
	}
	public String getOpt_2ndname() {
		return opt_2ndname;
	}
	public void setOpt_2ndname(String opt_2ndname) {
		this.opt_2ndname = opt_2ndname;
	}
	public String getOpt_2ndval() {
		return opt_2ndval;
	}
	public void setOpt_2ndval(String opt_2ndval) {
		this.opt_2ndval = opt_2ndval;
	}
	public int getDeltem_delfee() {
		return deltem_delfee;
	}
	public void setDeltem_delfee(int deltem_delfee) {
		this.deltem_delfee = deltem_delfee;
	}
	public int getGds_price() {
		return gds_price;
	}
	public void setGds_price(int gds_price) {
		this.gds_price = gds_price;
	}
}

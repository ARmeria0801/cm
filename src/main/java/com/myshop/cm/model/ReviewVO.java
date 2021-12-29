package com.myshop.cm.model;

import java.sql.Timestamp;

public class ReviewVO {
	
	private int rev_num;			//후기번호
	private int pay_num;			//결제 번호
	private int gds_num;			//상품 번호
	private String gds_name;		//상품 이름
	private int ord_gdsoption;		//상품 옵션
	private int mem_num;			//회원 번호
	private String mem_id;			//후기 작성자
	private String rev_content;		//후기 내용
	private Timestamp rev_date;		//후기 작성날짜
	private String rev_filename;	//후기 사진파일
	private int ol_num;			//주문번호
	
	// 리뷰정보를 토대로 받아올 추가정보들
	private String gds_thumbnail;
    private String opt_1stname;
    private String opt_1stval; 
    private String opt_2ndname;
    private String opt_2ndval;
	
	public int getRev_num() {
		return rev_num;
	}
	public void setRev_num(int rev_num) {
		this.rev_num = rev_num;
	}
	public int getPay_num() {
		return pay_num;
	}
	public void setPay_num(int pay_num) {
		this.pay_num = pay_num;
	}
	public int getGds_num() {
		return gds_num;
	}
	public void setGds_num(int gds_num) {
		this.gds_num = gds_num;
	}
	public String getGds_name() {
		return gds_name;
	}
	public void setGds_name(String gds_name) {
		this.gds_name = gds_name;
	}
	public int getOrd_gdsoption() {
		return ord_gdsoption;
	}
	public void setOrd_gdsoption(int ord_gdsoption) {
		this.ord_gdsoption = ord_gdsoption;
	}
	public int getMem_num() {
		return mem_num;
	}
	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getRev_content() {
		return rev_content;
	}
	public void setRev_content(String rev_content) {
		this.rev_content = rev_content;
	}
	public Timestamp getRev_date() {
		return rev_date;
	}
	public void setRev_date(Timestamp rev_date) {
		this.rev_date = rev_date;
	}
	public String getRev_filename() {
		return rev_filename;
	}
	public void setRev_filename(String rev_filename) {
		this.rev_filename = rev_filename;
	}
	public int getOrd_num() {
		return ol_num;
	}
	public void setOrd_num(int ol_num) {
		this.ol_num = ol_num;
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
	public String getGds_thumbnail() {
		return gds_thumbnail;
	}
	public void setGds_thumbnail(String gds_thumbnail) {
		this.gds_thumbnail = gds_thumbnail;
	}
	
	

}

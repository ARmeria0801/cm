package com.myshop.cm.model;

import java.sql.Timestamp;

public class ReviewVO {
	
	private int rev_num;			//후기번호
	private int pay_num;			//결제 번호
	private int gds_num;			//상품 번호
	private String gds_name;		//상품 이름
	private String ord_gdsoption;	//상품 옵션
	private int mem_num;			//회원 번호
	private String mem_id;			//후기 작성자
	private String rev_content;		//후기 내용
	private Timestamp rev_date;		//후기 작성날짜
	private String rev_filename;	//후기 사진파일
	private int ord_num;			//주문번호
	
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
	public String getOrd_gdsoption() {
		return ord_gdsoption;
	}
	public void setOrd_gdsoption(String ord_gdsoption) {
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
		return ord_num;
	}
	public void setOrd_num(int ord_num) {
		this.ord_num = ord_num;
	}
	
	

}

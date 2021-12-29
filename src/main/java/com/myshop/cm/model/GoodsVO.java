package com.myshop.cm.model;

import java.util.Date;
import java.util.List;

public class GoodsVO {

//	CREATE TABLE `goods` (
//			  `gds_num` 	int(11) 	NOT NULL AUTO_INCREMENT COMMENT '상품번호',
//			  `lcate_code` 	int(11) 	NOT NULL 				COMMENT '상품카테고리 번호',
//			  `mcate_code` 	int(11) 	NOT NULL,
//			  `scate_code` 	int(11) 	DEFAULT NULL,
//			  `gds_seller` 	varchar(20) NOT NULL 				COMMENT '상품판매자',
//			  `gds_name` 	varchar(50) NOT NULL 				COMMENT '상품명',
//			  `gds_price` 	int(11) 	NOT NULL 				COMMENT '상품 가격',
//			  `gds_detail` 	text 								COMMENT '상품 설명',
//			  `gds_thumbnail` varchar(100) DEFAULT NULL 		COMMENT '상품 썸네일 파일명',
//			  `gds_date` 	timestamp 	NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '상품 등록일',
//			  `deltem_num` 	int(11) 	DEFAULT NULL 			COMMENT '배송 템플릿 번호',
//			  `gds_good` 	varchar(1) 	DEFAULT NULL 			COMMENT 'md추천 여부',
//			  `gds_readcount` int(11) 	NOT NULL 				COMMENT '상품 조회수',
//			  `gds_sellcount` int(11) 	NOT NULL 				COMMENT '상품 판매수',
//			  `gds_ears` 	varchar(1000) DEFAULT NULL 			COMMENT '교환,환불 기준',
//			  `gds_viewyn` 	varchar(1) 	NOT NULL 				COMMENT '상품노출Y/N',
//			  PRIMARY KEY (`gds_num`)
//			) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='상품';

	private int gds_num;
	private int lcate_code;
	private int mcate_code;
	private int scate_code;
	private String gds_seller;
	private String gds_name;
	private int gds_price;
	private String gds_detail;
	private String gds_thumbnail;
	private Date gds_date;
	private int deltem_num;
	private String gds_good;
	private int gds_readcount;
	private int gds_sellcount;
	private String gds_ears;
	private String gds_viewyn;
	
	//배송 관련
	private DeliveryTemplateVO deliveryTemplateVO;
	//옵션
	private List<OptionVO> optionVO;
	
	// 옵션을 받기위한 VO
	private List<String> optioncom;
	
	public List<OptionVO> getOptionVO() {
		return optionVO;
	}

	public void setOptionVO(List<OptionVO> optionVO) {
		this.optionVO = optionVO;
	}

	public List<String> getOptioncom() {
		return optioncom;
	}

	public void setOptioncom(List<String> optioncom) {
		this.optioncom = optioncom;
	}

	public int getGds_num() {
		return gds_num;
	}

	public void setGds_num(int gds_num) {
		this.gds_num = gds_num;
	}

	public int getLcate_code() {
		return lcate_code;
	}

	public void setLcate_code(int lcate_code) {
		this.lcate_code = lcate_code;
	}

	public int getMcate_code() {
		return mcate_code;
	}

	public void setMcate_code(int mcate_code) {
		this.mcate_code = mcate_code;
	}

	public int getScate_code() {
		return scate_code;
	}

	public void setScate_code(int scate_code) {
		this.scate_code = scate_code;
	}

	public String getGds_seller() {
		return gds_seller;
	}

	public void setGds_seller(String gds_seller) {
		this.gds_seller = gds_seller;
	}

	public String getGds_name() {
		return gds_name;
	}

	public void setGds_name(String gds_name) {
		this.gds_name = gds_name;
	}

	public int getGds_price() {
		return gds_price;
	}

	public void setGds_price(int gds_price) {
		this.gds_price = gds_price;
	}

	public String getGds_detail() {
		return gds_detail;
	}

	public void setGds_detail(String gds_detail) {
		this.gds_detail = gds_detail;
	}

	public String getGds_thumbnail() {
		return gds_thumbnail;
	}

	public void setGds_thumbnail(String gds_thumbnail) {
		this.gds_thumbnail = gds_thumbnail;
	}

	public Date getGds_date() {
		return gds_date;
	}

	public void setGds_date(Date gds_date) {
		this.gds_date = gds_date;
	}

	public int getDeltem_num() {
		return deltem_num;
	}

	public void setDeltem_num(int deltem_num) {
		this.deltem_num = deltem_num;
	}

	public String getGds_good() {
		return gds_good;
	}

	public void setGds_good(String gds_good) {
		this.gds_good = gds_good;
	}

	public int getGds_readcount() {
		return gds_readcount;
	}

	public void setGds_readcount(int gds_readcount) {
		this.gds_readcount = gds_readcount;
	}

	public int getGds_sellcount() {
		return gds_sellcount;
	}

	public void setGds_sellcount(int gds_sellcount) {
		this.gds_sellcount = gds_sellcount;
	}

	public String getGds_ears() {
		return gds_ears;
	}

	public void setGds_ears(String gds_ears) {
		this.gds_ears = gds_ears;
	}

	public String getGds_viewyn() {
		return gds_viewyn;
	}

	public void setGds_viewyn(String gds_viewyn) {
		this.gds_viewyn = gds_viewyn;
	}

	public DeliveryTemplateVO getDeliveryTemplateVO() {
		return deliveryTemplateVO;
	}

	public void setDeliveryTemplateVO(DeliveryTemplateVO deliveryTemplateVO) {
		this.deliveryTemplateVO = deliveryTemplateVO;
	}
}

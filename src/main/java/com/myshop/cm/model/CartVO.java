package com.myshop.cm.model;

import java.util.Date;

public class CartVO {

//	CREATE TABLE `cart` (
//	  `cart_num` 	int(11) 	NOT NULL AUTO_INCREMENT 	COMMENT '장바구니 번호',
//	  `mem_num` 	int(11) 	NULL 						COMMENT '회원번호',
//	  `gds_num` 	int(11) 	NOT NULL 					COMMENT '상품 번호',
//	  `cart_gdsoption` varchar(50) DEFAULT NULL 			COMMENT '상품 옵션',
//	  `cart_count` 	int(11) 	NOT NULL 					COMMENT '주문 수량',
//	  `cart_date` 	timestamp 	NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '주문 날짜',
//	  PRIMARY KEY (`cart_num`)
//	) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='장바구니';

	private int cart_num; // 카트 번호(PK)
	private int mem_num; // 주문한 유저 번호
	private int opt_num; // 옵션 번호
	private int cart_count; // 주문 수량
	private Date cart_date; // 주문 날짜
	private String cart_viewyn; // 상품노출 Y/N 확인용 컬럼(goods 테이블의 goods_viewyn과 비교하기 위함)

	// 추가
	private int gds_num;
	private GoodsVO goodsVO; //상품
	private OptionVO optionVO; // 상품 옵션

	public OptionVO getOptionVO() {
		return optionVO;
	}

	public void setOptionVO(OptionVO optionVO) {
		this.optionVO = optionVO;
	}

	public int getCart_num() {
		return cart_num;
	}

	public void setCart_num(int cart_num) {
		this.cart_num = cart_num;
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	public int getOpt_num() {
		return opt_num;
	}

	public void setOpt_num(int opt_num) {
		this.opt_num = opt_num;
	}

	public int getCart_count() {
		return cart_count;
	}

	public void setCart_count(int cart_count) {
		this.cart_count = cart_count;
	}

	public Date getCart_date() {
		return cart_date;
	}

	public void setCart_date(Date cart_date) {
		this.cart_date = cart_date;
	}

	public GoodsVO getGoodsVO() {
		return goodsVO;
	}

	public void setGoodsVO(GoodsVO goodsVO) {
		this.goodsVO = goodsVO;
	}

	public int getGds_num() {
		return gds_num;
	}

	public void setGds_num(int gds_num) {
		this.gds_num = gds_num;
	}

	public String getCart_viewyn() {
		return cart_viewyn;
	}

	public void setCart_viewyn(String cart_viewyn) {
		this.cart_viewyn = cart_viewyn;
	}

}

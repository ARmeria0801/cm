package com.myshop.cm.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myshop.cm.model.DeliveryAddressVO;

@Repository
public class DeliveryAddressDAO {
	@Autowired
	private SqlSession sqlSession;

	public DeliveryAddressVO getdeliveryAddress(int mem_num) {
		return (DeliveryAddressVO) sqlSession.selectOne("deliveryAddressMapper.select_deliveryadress",mem_num);
	}
	//배송지 수정하기
	public void updatedeliveryAddress(DeliveryAddressVO deliveryaddress) {
		sqlSession.update("deliveryAddressMapper.update_deliveryadress", deliveryaddress);
		
	}
	

}

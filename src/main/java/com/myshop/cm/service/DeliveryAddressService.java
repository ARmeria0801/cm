package com.myshop.cm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myshop.cm.dao.DeliveryAddressDAO;
import com.myshop.cm.model.DeliveryAddressVO;

@Service
public class DeliveryAddressService {
	@Autowired
	private DeliveryAddressDAO deliveryAddressDAO;

	public DeliveryAddressVO getdeliveryAddress(int mem_num) {
		return deliveryAddressDAO.getdeliveryAddress(mem_num);
	}
	//배송지 수정하기
	public void updatedeliveryAddress(DeliveryAddressVO deliveryaddress) {
		deliveryAddressDAO.updatedeliveryAddress(deliveryaddress);
		
	}

}

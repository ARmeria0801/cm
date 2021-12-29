package com.myshop.cm.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.myshop.cm.dao.OrdersDAO;

@Service
public class OrdersService {

	@Inject
	private OrdersDAO ordersDAO;
}

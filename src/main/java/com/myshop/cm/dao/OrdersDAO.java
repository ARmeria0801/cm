package com.myshop.cm.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class OrdersDAO {

	@Inject
	private SqlSession sqlSession;
	private final static String NAMESPACE = "ordersMapper.";
	
	
}

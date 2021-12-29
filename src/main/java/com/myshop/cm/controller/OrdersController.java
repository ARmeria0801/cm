package com.myshop.cm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/orders/**")
public class OrdersController {

	//주문 목록
	@GetMapping("ordersList")
	public void ordersList(Model model) throws Exception {
		System.out.println("OrdersList 들어왔냐");
		
		
	}
}

package com.myshop.cm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.myshop.cm.model.CartVO;
import com.myshop.cm.model.MemberVO;
import com.myshop.cm.service.CartService;

@Controller
@RequestMapping("/cart/**")
public class CartController {

	@Inject
	private CartService cartService;

	// 카트 리스트
	@GetMapping("cartList")
	public void cartList(CartVO cartVO, Model model, HttpSession session) throws Exception {
		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		System.out.println("CartList 들어왔냐");

//		cartVO.setMem_num(memberVO.getMem_num());
		cartVO.setMem_num(1);
		List<CartVO> list = cartService.cartList(cartVO);
		//System.out.println(list.get(0).getOptionVO().getOpt_1stname());
		//System.out.println(list.get(0).getOptionVO().getOpt_1stval());
		
		model.addAttribute("cartList", list);
	}//cartList end

	// 카트 담기
	@ResponseBody
	@PostMapping("cartInsert")
	public int cartInsert(CartVO cartVO, HttpSession session) throws Exception {
		System.out.println("CartInsert 들어왔냐");

		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		int result = 0;
		String gds_viewyn = null;

		// if(memberVO != null) {
		gds_viewyn = cartService.selectGdsviewyn(cartVO);
		// System.out.println(gds_viewyn);
		cartVO.setMem_num(1);
		cartVO.setCart_viewyn(gds_viewyn);
		result = cartService.cartInsert(cartVO);
		// System.out.println(result);
		// }

		return result;
	}//cartInsert end

	// 동일 상품 존재 여부 조회
	@ResponseBody
	@PostMapping("cartSelect")
	public Map<String, Integer> cartSelect(CartVO cartVO, Model model, HttpSession session) throws Exception {
		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		Map<String, Integer> map = new HashMap<String, Integer>();
		int result = 0;

		// if(memberVO != null) {
		// cartVO.setMem_num(memberVO.getMem_num());

			cartVO.setMem_num(1);
			cartVO = cartService.cartSelect(cartVO);
	
			if (cartVO != null) {
				result = 1; // 동일 상품 존재 O
				map.put("cart_num", cartVO.getCart_num());
				map.put("cart_count", cartVO.getCart_count());
			} else {
				result = 2; // 동일 상품 존재 X
			}
			map.put("result", result);
		// }

		return map;
	}//cartSelect end

	// 카트 수량 수정
	@ResponseBody
	@PostMapping("cartUpdate")
	public int cartUpdate(CartVO cartVO, HttpSession session) throws Exception {
		System.out.println("CartUpdate 들어왔냐");

		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		int result = 0;

		//if (memberVO != null) {
			// cartVO.setMem_num(memberVO.getMem_num());
			cartVO.setMem_num(1);
			result = cartService.cartUpdate(cartVO);
		//}
		return result;
	}//cartUpdate end
	
	//카트 삭제
	@ResponseBody
	@PostMapping("cartDelete")
	public int cartDelete(@RequestParam(value = "list[]") List<String> list, CartVO cartVO, HttpSession session) throws Exception {
		System.out.println("CartDelete 들어왔냐");

		MemberVO memberVO = (MemberVO) session.getAttribute("member");
		int result = 0;
		int cart_num = 0;

		// if (memberVO != null) {
		// cartVO.setMem_num(memberVO.getMem_num());
		cartVO.setMem_num(1);
		
			for(String i : list) {
				cart_num = Integer.parseInt(i);
				System.out.println(cart_num);
				cartVO.setCart_num(cart_num);
				result = cartService.cartDelete(cartVO);
			}
		
		// }
		return result;
	}//cartDelete end
}

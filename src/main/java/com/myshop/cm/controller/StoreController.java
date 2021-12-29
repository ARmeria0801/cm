package com.myshop.cm.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.myshop.cm.model.GoodsVO;
import com.myshop.cm.model.OptionVO;
import com.myshop.cm.service.StoreService;
import com.myshop.cm.util.Pager;

@Controller
@RequestMapping("/store/**")
public class StoreController {

	@Inject
	private StoreService storeService;
	
	//옵션2 찾아오는 거
	@GetMapping("option2Select")
	public ModelAndView option2Select(OptionVO optionVO, String gds_price) throws Exception {
		System.out.println("Option2Select 들어왔냐");
		
		ModelAndView mv = new ModelAndView();
		
		List<OptionVO> list = storeService.option2Select(optionVO);
		System.out.println(list.get(0).getGds_num());
		System.out.println(list.get(0).getOpt_1stname());
		System.out.println(list.get(0).getOpt_2ndval());
		
		mv.addObject("list", list);
		mv.addObject("gds_price", gds_price);
		
		mv.setViewName("common/option2Select");
		
		return mv;
	}
	
	//상품 상세
	@GetMapping("storeSelect")
	public void storeSelect(GoodsVO goodsVO, Model model, Pager pager) throws Exception {
		System.out.println("StoreSelect 들어왔냐");
		
		goodsVO = storeService.storeSelect(goodsVO);
		
		//String gds_detail = goodsVO.getGds_detail().replace("/resources", "${pageContext.request.contextPath}/resources");
		//goodsVO.setGds_detail(gds_detail);
		
		model.addAttribute("select", goodsVO);
		model.addAttribute("curPage", pager.getCurPage());
	}
	
	//상품 목록
	@GetMapping("storeList")
	public void storeList(Pager pager, HttpSession session, Model model) throws Exception {
		System.out.println("StoreList 들어왔냐");
		//System.out.println(pager.getCate_kind());
		
		List<GoodsVO> list = storeService.storeList(pager);
		
		model.addAttribute("lists", list);
		model.addAttribute("pager", pager);
		
	}
	
}

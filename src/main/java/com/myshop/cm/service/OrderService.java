package com.myshop.cm.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myshop.cm.dao.OrderDAO;
import com.myshop.cm.dao.SellerDAO;
import com.myshop.cm.model.MemberVO;
import com.myshop.cm.model.OrderListVO;
import com.myshop.cm.model.OrderVO;
import com.myshop.cm.model.SellerVO;

@Service
public class OrderService {
	
	@Autowired
	private OrderDAO orderDao;
	@Autowired
	private OrderDAO orderDAO;
	@Autowired
	private SellerDAO sellerDAO;

	//리뷰페이지 ord_num값 구하기
	public OrderVO getOrdReview(int ord_num)throws Exception {
		OrderVO orderrev = orderDao.getOrdReview(ord_num);
		return orderrev;
	}

	// 판매자페이지에서 주문 상세내역 불러오기
	public OrderListVO getOrderDetail(int ol_num) throws Exception{
		OrderListVO order = orderDAO.getOrderDetail(ol_num);
		return order;
	}

	public Map<String, Object> getOrderList(HttpServletRequest request, 
			HttpServletResponse response) throws Exception{
		List<OrderVO> orderlist = new ArrayList<OrderVO>();
		
		// 세션에 있는 member정보 받기
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO)session.getAttribute("member");
				
		// 세션의 member.mem_num으로 판매자정보 불러오기
		SellerVO seller = sellerDAO.getSellerInfo(member.getMem_num());

		
		int page = 1;
		int limit = 10;	// 한 화면에 출력할 상품 수
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		int pageIndex = (page-1)*10;
		
		// 주문 리스트를 출력할 parameterType들을 map에 넣는다.
		Map<String, Object> listIndexMap = new HashMap<String,Object>();
		
		listIndexMap.put("pageIndex", pageIndex);
		listIndexMap.put("sel_name", seller.getSel_name());
		
		int listcount = orderDAO.getOrderListCount(seller.getSel_name());
		
		// 페이지 번호(page)를 DAO 클래스에 전달한다.
		orderlist = orderDAO.getOrderList(listIndexMap);	// 리스트를 받아옴
		
		// 총 페이지 수
		int maxpage = (int)((double)listcount / limit + 0.95); // 0.95를 더해서 올림처리
		
		// 현재 페이지에 보여줄 시작 페이지 수(1, 11, 21 등...)
		int startpage = (((int) ((double) page / 10 + 0.9)) - 1) * 10 + 1;
		// 현재 페이지에 보여줄 마지막 페이지 수.(10, 20, 30 등...)
		int endpage = maxpage;

		if (endpage > startpage + 10 - 1)
			endpage = startpage + 10 - 1;
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("page", page);
		resultMap.put("startpage", startpage);
		resultMap.put("endpage", endpage);
		resultMap.put("maxpage", maxpage);
		resultMap.put("listcount", listcount);
		resultMap.put("orderlist", orderlist);

		return resultMap;
	}
	//리뷰페이지 목록 
	public Map<String, Object> getHistoryList(HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception{
		List<OrderVO> historylist = new ArrayList<OrderVO>();
		
		int page = 1;
		int limit = 10;	// 한 화면에 출력할 상품 수
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		int pageIndex = (page-1)*10;
		
		// 페이지 번호(page)를 DAO 클래스에 전달한다.
		historylist = orderDao.getHistoryList(pageIndex);	// 리스트를 받아옴
		// 총 리스트 수를 받아옴
		int listcount = orderDAO.getHistoryListCount();
		
		// 페이지 번호(page)를 DAO 클래스에 전달한다.
		
		// 총 페이지 수
		int maxpage = (int)((double)listcount / limit + 0.95); // 0.95를 더해서 올림처리
		
		// 현재 페이지에 보여줄 시작 페이지 수(1, 11, 21 등...)
		int startpage = (((int) ((double) page / 10 + 0.9)) - 1) * 10 + 1;
		// 현재 페이지에 보여줄 마지막 페이지 수.(10, 20, 30 등...)
		int endpage = maxpage;

		if (endpage > startpage + 10 - 1)
			endpage = startpage + 10 - 1;
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("page", page);
		resultMap.put("startpage", startpage);
		resultMap.put("endpage", endpage);
		resultMap.put("maxpage", maxpage);
		resultMap.put("listcount", listcount);
		resultMap.put("historylist", historylist);

		return resultMap;
	}

	// 세션으로 가져온 판매자 정보로 최근 5개 판매상품 불러오기
	public List<OrderListVO> getMainOrderList(String sel_name) {
		return orderDAO.getMainOrderList(sel_name);
	}
	
	
}

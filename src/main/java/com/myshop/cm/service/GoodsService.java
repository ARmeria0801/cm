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

import com.myshop.cm.dao.GoodsDAO;
import com.myshop.cm.dao.SellerDAO;
import com.myshop.cm.model.GoodsVO;
import com.myshop.cm.model.MemberVO;
import com.myshop.cm.model.SellerVO;

@Service
public class GoodsService {
	
	@Autowired
	private GoodsDAO goodsDao;
	@Autowired
	private SellerDAO sellerDAO;
	
	//리뷰에 gds_num가져가기
	public GoodsVO getGdsReview(int gds_num) {
		GoodsVO gdsrev = goodsDao.getGdsReview(gds_num);
		return gdsrev;
	}
	
	// 상품 등록
	public void insert(GoodsVO goods) throws Exception{
		
		sellerDAO.insertGoods(goods);
	}

	// 판매자별 상품목록
	public Map<String, Object> sellergoodslist(HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<GoodsVO> sellergoodslist = new ArrayList<GoodsVO>();
		
		// 세션에 있는 member정보 받기
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO)session.getAttribute("member");
		
		// 세션의 member.mem_num으로 판매자정보 불러오기
		SellerVO seller = sellerDAO.getSellerInfo(member.getMem_num());
				
		
		int page = 1;	// 페이지 기본값 
		int limit = 10;	// 한 화면에 출력할 상품 수
		
		// 만약 페이지 요청값이 없다면 페이지기본값(1페이지)가 출력되게
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		
		// mySQL의 limit에 넣어줄 값
		int pageIndex = (page-1)*10;
		
		// 총 개수를 받아옴
		int listcount = sellerDAO.getListCount(seller.getSel_name());
		
		// 상품 리스트를 출력할 parameterType들을 map에 넣는다.
		Map<String, Object> listIndexMap = new HashMap<String,Object>();
		
		listIndexMap.put("pageIndex", pageIndex);
		listIndexMap.put("sel_name", seller.getSel_name());
		
		// 페이지 인덱스(pageIndex)를 DAO 클래스에 전달한다.
		sellergoodslist = sellerDAO.getSellerGoodsList(listIndexMap);	// 리스트를 받아옴
		
		// 총 페이지 수
		int maxpage = (int)((double)listcount / limit + 0.95); // 0.95를 더해서 올림처리
		
		// 현재 페이지에 보여줄 시작 페이지 수(1, 11, 21 등...)
		int startpage = (((int) ((double) page / 10 + 0.9)) - 1) * 10 + 1;
		// 현재 페이지에 보여줄 마지막 페이지 수.(10, 20, 30 등...)
		int endpage = maxpage;

		// 만약 endPage가  10 20 30 을 넘어간다면, 고정함
		if (endpage > startpage + 10 - 1)
			endpage = startpage + 10 - 1;
		
		// map객체를 선언하여 위에 새로 선언한 변수들을 담아준다.
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("page", page);
		resultMap.put("startpage", startpage);
		resultMap.put("endpage", endpage);
		resultMap.put("maxpage", maxpage);
		resultMap.put("listcount", listcount);
		resultMap.put("sellergoodslist", sellergoodslist);

		return resultMap;
	}

	// 판매자 상품 구매자페이지로 보기
	public GoodsVO goodsdetail(int gds_num) throws Exception{
		GoodsVO goods = sellerDAO.getGoodsContent(gds_num);
		return goods;
	}

	// 상품 수정
	public void update(GoodsVO goods) throws Exception{
		sellerDAO.updateGoods(goods);
	}

	// 상품 삭제
	public void deletegoods(int gds_num) throws Exception{
		sellerDAO.deleteGoods(gds_num);
	}

	// 상품 정지
	public void goodshide(int gds_num) throws Exception{
		sellerDAO.goodshide(gds_num);
	}

	// 상품 노출
	public void goodsview(int gds_num) throws Exception{
		sellerDAO.goodsview(gds_num);
	}


}

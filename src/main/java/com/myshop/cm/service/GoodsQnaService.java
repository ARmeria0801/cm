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

import com.myshop.cm.dao.GoodsQnaDAO;
import com.myshop.cm.dao.SellerDAO;
import com.myshop.cm.model.GoodsQnaVO;
import com.myshop.cm.model.MemberVO;
import com.myshop.cm.model.SellerVO;

@Service
public class GoodsQnaService {
	@Autowired
	private GoodsQnaDAO goodsQnaDAO;
	@Autowired
	private SellerDAO sellerDAO;

	public Map<String, Object> getGoodsQnaList(HttpServletRequest request, HttpServletResponse response) {
		List<GoodsQnaVO> sellergoodsQnaList = new ArrayList<GoodsQnaVO>();
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
		System.out.println(seller.getSel_name());
		int listcount = goodsQnaDAO.getGoodsQnaListCount(seller.getSel_name());
		
		// 상품 리스트를 출력할 parameterType들을 map에 넣는다.
		Map<String, Object> listIndexMap = new HashMap<String,Object>();
		
		listIndexMap.put("pageIndex", pageIndex);
		listIndexMap.put("sel_name", seller.getSel_name());
		
		// 페이지 인덱스(pageIndex)를 DAO 클래스에 전달한다.
		sellergoodsQnaList = goodsQnaDAO.getGoodsQnaList(listIndexMap);	// 리스트를 받아옴
		
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
		resultMap.put("sellergoodsQnaList", sellergoodsQnaList);

		return resultMap;
	}
	
	// 답변이 달렸는지 확인하기
	public int getGoodsQnaAnswer(int gdsqna_num) throws Exception{
		return goodsQnaDAO.getGoodsQnaAnswer(gdsqna_num);
	}

	// 문의 디테일 가져오기
	public GoodsQnaVO getGoodsQuestionDetail(int gdsqna_num) {
		return goodsQnaDAO.getGoodsQuestionDetail(gdsqna_num);
	}

	// 문의 답변 가져오기 ( gdsqna_ref)
	public GoodsQnaVO getGoodsAnswerDetail(int gdsqna_num) {
		return goodsQnaDAO.getGoodsAnswerDetail(gdsqna_num);
	}

	// 문의 확인 업데이트
	public void updateCheckQna(int gdsqna_num) {
		goodsQnaDAO.updateCheckQna(gdsqna_num);
	}

	// 문의 답변 달기
	public void insertGoodsQna(GoodsQnaVO goodsquestion) {
		goodsQnaDAO.insertGoodsQna(goodsquestion);
	}

	// 문의 답변글 가져오기(gdsqna_num)
	public GoodsQnaVO getGoodsAnswer(int gdsqna_num) {
		return goodsQnaDAO.getGoodsAnswer(gdsqna_num);
	}

	public void updateAnswer(GoodsQnaVO goodsqna) {
		goodsQnaDAO.updateAnswer(goodsqna);
	}

	public void deleteAnswer(int gdsqna_num) {
		goodsQnaDAO.deleteAnswer(gdsqna_num);
	}

	public List<GoodsQnaVO> getMainGoodsQnaList(String sel_name) {
		return goodsQnaDAO.getMainGoodsQnaList(sel_name);
	}

}

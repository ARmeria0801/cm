package com.myshop.cm.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.myshop.cm.dao.StoreDAO;
import com.myshop.cm.model.GoodsVO;
import com.myshop.cm.model.OptionVO;
import com.myshop.cm.util.Pager;

@Service
public class StoreService {

	@Inject
	private StoreDAO storeDAO;
	
	// 상품 리스트
	public List<GoodsVO> storeList(Pager pager) throws Exception {
		//시작 rownum 생성
		pager.makeRow();
		//페이저 생성
		pager.makePage(storeDAO.storeCount(pager));
		
		return storeDAO.storeList(pager);
	}
	
	//상품 상세
	public GoodsVO storeSelect(GoodsVO goodsVO) throws Exception {
		
		return storeDAO.storeSelect(goodsVO);
	}
	
	//옵션2 가져오는 거
	public List<OptionVO> option2Select(OptionVO optionVO) throws Exception {
		return storeDAO.option2Select(optionVO);
	}
}

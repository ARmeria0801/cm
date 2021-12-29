package com.myshop.cm.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.myshop.cm.model.GoodsQnaVO;

@Repository
public class GoodsQnaDAO {
	@Autowired
	private SqlSession sqlSession;

	public int getGoodsQnaListCount(String sel_name) {
		return sqlSession.selectOne("goodsQnaMapper.select_goodsqna_list_count", sel_name);
	}

	public List<GoodsQnaVO> getGoodsQnaList(Map<String, Object> listIndexMap) {
		return sqlSession.selectList("goodsQnaMapper.select_goodsqna_list", listIndexMap);
	}

	// 답변이 달렸는지 확인하기
	public int getGoodsQnaAnswer(int gdsqna_num) {
		return sqlSession.selectOne("goodsQnaMapper.select_goodsqna_check", gdsqna_num);
	}

	// 문의글 가져오기
	public GoodsQnaVO getGoodsQuestionDetail(int gdsqna_num) {
		return sqlSession.selectOne("goodsQnaMapper.select_goodsqna_question", gdsqna_num);
	}

	// 답변글 가져오기
	public GoodsQnaVO getGoodsAnswerDetail(int gdsqna_num) {
		return sqlSession.selectOne("goodsQnaMapper.select_goodsqna_answer", gdsqna_num);
	}

	// 문의 확인 업데이트
	public void updateCheckQna(int gdsqna_num) {
		sqlSession.update("goodsQnaMapper.update_goodsqna_check",gdsqna_num);
		
	}

	// 문의 답변 달기
	public void insertGoodsQna(GoodsQnaVO goodsquestion) {
		// 문의글 답변완료상태로 변경
		sqlSession.update("goodsQnaMapper.update_goodsqna_question_answer_1", goodsquestion);
		// 답변글 insert하기
		sqlSession.insert("goodsQnaMapper.insert_goodsqna_answer", goodsquestion);
		
	}

	// 답변글 가져오기(num)
	public GoodsQnaVO getGoodsAnswer(int gdsqna_num) {
		return sqlSession.selectOne("goodsQnaMapper.select_goodsqna_answer_num",gdsqna_num);
	}

	// 답변글 수정하기
	public void updateAnswer(GoodsQnaVO goodsqna) {
		sqlSession.update("goodsQnaMapper.update_goodsqna_answer",goodsqna);
	}

	// 답변글 삭제하기
	public void deleteAnswer(int gdsqna_num) {
		// 답변글의 ref값 가져오기
		int gdsqna_ref = sqlSession.selectOne("goodsQnaMapper.select_goodsqna_answer_ref",gdsqna_num);
		
		// 문의글 답변 안됨 상태로 수정
		sqlSession.update("goodsQnaMapper.update_goodsqna_question_answer_0", gdsqna_ref);
		
		// 답변글 delyn 0으로 수정
		sqlSession.update("goodsQnaMapper.update_goodsqna_answer_delyn0", gdsqna_num);
	}

	public List<GoodsQnaVO> getMainGoodsQnaList(String sel_name) {
		return sqlSession.selectList("goodsQnaMapper.select_main_goodsqna_list", sel_name);
	}
}

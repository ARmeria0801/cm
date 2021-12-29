package com.myshop.cm.dao;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.myshop.cm.model.DeliveryAddressVO;
import com.myshop.cm.model.MemberVO;

@Repository
public class MemberDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	//id 유효성검사
	/*
	 * @Transactional public int memberIdCheck(String mem_id) throws Exception {
	 * 
	 * int result =-1; //사용 가능 id MemberVO mv = (MemberVO)
	 * sqlSession.selectOne("memberns.login_check", mem_id); if(mv != null) result =
	 * 1; //중복 id return result; }
	 */
	@Transactional
	public int memberIdCheck(String mem_id) {
		System.out.println("id유효성 dao");
		int result = sqlSession.selectOne("memberns.idCheck", mem_id);
		System.out.println(result);
		return result;
	}
	//회원가입 저장
	@Transactional
	public void insertMember(MemberVO member) throws Exception {
		sqlSession.insert("memberns.joinm", member);
	}
	//회원가입 주소지
	public void insertAddress(DeliveryAddressVO deliveryaddress) {
		sqlSession.insert("memberns.join", deliveryaddress);
	}
	//id값 불러서 mem_num구하기
	public int selectMemNum(MemberVO member) {
		return sqlSession.selectOne("memberns.selectNum", member);
	}
	//로그인 인증
	@Transactional
	public MemberVO loginCheck(String mem_id) throws Exception {
		return (MemberVO) sqlSession.selectOne("login_check", mem_id);
	}
	//아이디 찾기
	public MemberVO idFind(String mem_name) {
		return (MemberVO) sqlSession.selectOne("memberns.findId", mem_name);
	}
	//비밀번호 찾기
	public MemberVO passFind(MemberVO member)throws Exception {
		System.out.println("비밀번호 찾기 dao");
		return (MemberVO) sqlSession.selectOne("findPass", member);
	}
	//비밀번호 재확인
	public MemberVO passRe(MemberVO prmv)throws Exception {
		System.out.println("영차영차 재확인");
		return (MemberVO) sqlSession.selectOne("memberns.pass_recheck", prmv);
	}
	public void passUpdate(MemberVO member)throws Exception {
		sqlSession.update("memberns.pass_update", member);
	}
	//회원정보 수정
	public void memberUpdate(MemberVO member) {
		sqlSession.update("memberns.update",member);
		System.out.println("수정확인 dao");
	}
	//회원 탈퇴
	public void deleteMember(MemberVO delmv) throws Exception{
		sqlSession.update("memberns.delete", delmv);
		System.out.println("탈퇴 dao");
	}
	//회원 1명의 정보
	public MemberVO getMemberInfo(String mem_id) {
		MemberVO member = sqlSession.selectOne("memberns.select_memeber_info", mem_id);
		return member;
	}

	public Object getmemberInfo(int mem_num) {
		return sqlSession.selectOne("memberns.select_member",mem_num);
	}
}

package com.myshop.cm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myshop.cm.dao.MemberDAO;
import com.myshop.cm.model.DeliveryAddressVO;
import com.myshop.cm.model.MemberVO;

@Service
public class MemberService {
	
	@Autowired
	private MemberDAO memberDao;
	
	//ID유효성 검사
	/*
	 * public int memberIdCheck(String mem_id) throws Exception { return
	 * memberDao.memberIdCheck(mem_id); }
	 */
	public int memberIdCheck(String mem_id) {
		System.out.println("id유효성 서비스");
		return memberDao.memberIdCheck(mem_id);
	}
	//회원가입 member저장
	public void insertMember(MemberVO member) throws Exception {
		 memberDao.insertMember(member);
	}
	//로그인 저장 인증
	public MemberVO loginCheck(String mem_id) throws Exception {
		return memberDao.loginCheck(mem_id);
	}
	//회원가입 deliveryaddress저장
	public void insertDelivery(DeliveryAddressVO deliveryaddress) {
		memberDao.insertAddress(deliveryaddress);
	}
	//id값 불러서 mem_num구하기
	public int selectMemNum(MemberVO member) {
		int mem = memberDao.selectMemNum(member);
		return mem;
	}
	//아이디 찾기 
	public MemberVO idFind(String mem_name) throws Exception{
		return memberDao.idFind(mem_name);
	}
	//비밀번호 찾기
	public MemberVO passFind(MemberVO member) throws Exception {
		System.out.println("비밀번호 찾기서비스");
		return memberDao.passFind(member);
	}
	//비밀번호 재확인
	public MemberVO passRe(MemberVO prmv)throws Exception {
		System.out.println("가냐");
		return memberDao.passRe(prmv);
	}
	//비밀번호 수정
		public void passUpdate(MemberVO member)throws Exception {
			System.out.println("비밀번호 변경 괜찮으시겠어요?");
			memberDao.passUpdate(member);
		}
	//회원 수정
	public void memberUpdate(MemberVO member)throws Exception {
		memberDao.memberUpdate(member);
		System.out.println("수정폼 서비스");
	}
	//회원 삭제
	public void deleteMember(MemberVO delmv) throws Exception{
		memberDao.deleteMember(delmv);
		System.out.println("탈퇴 서비스");
	}
	//회원 1명의 정보
	public MemberVO getMemberInfo(String mem_id) throws Exception{
		MemberVO member = memberDao.getMemberInfo(mem_id);
		return member;
	}
	//
	public MemberVO getmemberinfo(int mem_num) {
		return (MemberVO)memberDao.getmemberInfo(mem_num);
	}
}

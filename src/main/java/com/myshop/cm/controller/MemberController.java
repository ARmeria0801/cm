package com.myshop.cm.controller;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myshop.cm.model.DeliveryAddressVO;
import com.myshop.cm.model.MemberVO;
import com.myshop.cm.model.SellerVO;
import com.myshop.cm.service.DeliveryAddressService;
import com.myshop.cm.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	
	//id유효성 검사 ajax부분 
	@RequestMapping(value="/idCheck", method= RequestMethod.POST)
	// @ResponseBody
	public String idCheck(@RequestParam("mem_id") String mem_id, Model model) {
		System.out.println("id유효성 컨트롤러");
		int result = memberService.memberIdCheck(mem_id);
		model.addAttribute("result", result);
		 
		return "member/idCheckResult";
	}
	
	//회원가입 폼
	@RequestMapping(value = "/member_join")
	public String member_join() {
	return "member/member_join";
		//member폴더  member_join.jsp 실행
	}

	//회원가입 저장
	 @RequestMapping(value= "/join_ok", method =RequestMethod.POST) 
	 public String join_ok(MemberVO member, DeliveryAddressVO deliveryaddress,SellerVO seller,
			 				 Model model)throws Exception {
		 
		 memberService.insertMember(member);
		
		 // id값으로 mem_num구하기
		 int mem =  memberService.selectMemNum(member);
		 deliveryaddress.setMem_num(mem);
		 memberService.insertDelivery(deliveryaddress);
		 
	  return "redirect:member_login";
			  
	  }
	
	//로그인 폼
	@RequestMapping(value = "/member_login")
	public String member_login() {
		return "member/member_login";
		//member폴더  member_login.jsp 실행
	}
	
	//로그인 저장
	@RequestMapping(value = "/login_ok", method = RequestMethod.POST)
	public String login_ok(@RequestParam("mem_id") String mem_id,
						   @RequestParam("mem_pass")String mem_pass,
						   HttpSession session,	//세션객체 생성
						   Model model) throws Exception {
		int result = 0;
		MemberVO mv = memberService.loginCheck(mem_id);
		
		if(mv == null) {	//등록되지 않은 회원일때

			result = 1;
			model.addAttribute("result", result);
			System.out.println("등록되지 않은 회원입니다.");
			
			return "member/loginOk";
			
		}else {			//등록된 회원일때
			if(mv.getMem_pass().equals(mem_pass)) {	//비밀번호가 같을 떄
				session.setAttribute("mem_id", mem_id);	//세션으로 공유설정
				MemberVO member = memberService.getMemberInfo(mem_id);
				session.setAttribute("member", member);	//세션으로 공유설정
				System.out.println("등록된 ID입니다.");
				
				return "home";
				
			}else {		//비번이 다를때
				result = 2;
				model.addAttribute("result", result);
				
				System.out.println("비밀번호가 틀렸습니다.");
				return "member/loginOk";
			}
		}
	}
	
	//아이디 찾기 폼
	@RequestMapping(value="member_idFind")
	public String member_idFind() {
		return "member/member_idFind";
	}
	
	//아이디 찾기
	@RequestMapping(value="/id_find", method=RequestMethod.POST)
	public String id_find(@RequestParam("mem_name") String mem_name,
						  @RequestParam("mem_phone") String mem_phone,
						  @ModelAttribute MemberVO member,HttpSession session, Model model)throws Exception{
		int result =0;
		MemberVO vo = memberService.idFind(mem_name);
		
		if(vo == null) {	//등록되지 않은 이름일때
			
			result = 2;
			model.addAttribute("result", result);
			System.out.println("등록된 이름이 없습니다.");
			
			return "member/findIdCheck";
			
		}else {		//등록된 이름일 경우
			if(vo.getMem_phone().equals(mem_phone)) {	//핸드폰번호가 일치할때
				session.setAttribute("mem_id", vo.getMem_id());
				System.out.println("id찾기 성공");
				
				System.out.println(vo.getMem_id());
				
				return "member/findIdResult";	//찾은 아이디 출력 페이지 만들기
				
			}else {	//핸드폰번호가 불일치할때
				result = 3;
				model.addAttribute("result", result);
				System.out.println("등록된 핸드폰번호가 없습니다.");
				return "member/findIdCheck";
			}
		}
	}
	//비밀번호 찾기 폼
	@RequestMapping(value="member_passFind")
	public String member_passFind() {
		return "member/member_passFind";
	}
	//비밀번호 찾기 완료
	@RequestMapping(value="pass_find", method=RequestMethod.POST)
	public String pass_find(@ModelAttribute MemberVO member,
							HttpServletResponse response, Model model)throws Exception{
		response.setContentType("text.html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		MemberVO vo = memberService.passFind(member);
		System.out.println("비밀번호 찾기 컨트롤러");
		if(vo == null) {	//값이 없을 경우
			
			return "member/findPassCheck";
		}else {

			// Mail Server 설정
			String charSet = "utf-8";
			String hostSMTP = "smtp.naver.com";
			String hostSMTPid = "choongang_mart@naver.com";
			String hostSMTPpwd = "choongang1969!"; // 비밀번호 입력해야함

			// 보내는 사람 EMail, 제목, 내용
			String fromEmail = "choongang_mart@naver.com";
			String fromName = "Cmarket";
			String subject = "[Cmarket] " + vo.getMem_id()+"님 비밀번호 찾기 메일입니다.";

			// 받는 사람 E-Mail 주소
			String mail = vo.getMem_email();

			try {
				HtmlEmail email = new HtmlEmail();
				email.setDebug(true);
				email.setCharset(charSet);
				email.setSSL(true);
				email.setHostName(hostSMTP);
				email.setSmtpPort(587);

				email.setAuthentication(hostSMTPid, hostSMTPpwd);
				email.setTLS(true);
				email.addTo(mail, charSet);
				email.setFrom(fromEmail, fromName, charSet);
				email.setSubject(subject);
				email.setHtmlMsg("<p align = 'center'><h2>안녕하세요 "+vo.getMem_id() +"님</h2></p><br>"+
						"<div><h4>회원님의 현재 비밀번호는  '"+ vo.getMem_pass() + "' 이며,<br>"+"비밀번호 변경을 원할 시 마이페이지를 통해 변경해주세요.</h4></div>");
				email.send();
			} catch (Exception e) {
				System.out.println(e);
			}

			model.addAttribute("pwdok", "등록된 Email을 통해 비밀번호를 확인해 주세요.");
			return "member/findPassResult";
		}
	}
	//로그아웃
	@RequestMapping(value="/member_logout")
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "member/member_logout";
	}
	//비밀번호 재확인 폼
	@RequestMapping(value="/passReCheck")
	public String passReCheck(MemberVO member,HttpSession session,Model model)throws Exception{
		
		//세션 객체 안에 있는id정보 저장
		String mem_id =(String)session.getAttribute("mem_id");
		//서비스안의 메서드 호출
		MemberVO prmv = this.memberService.loginCheck(mem_id);
		model.addAttribute("prmv",prmv);
		return "member/passReCheck";		
	}
	//비밀번호 재확인 저장
	@RequestMapping(value="/recheck_ok", method=RequestMethod.POST)
	public String recheck_ok(@RequestParam("mem_pass") String mem_pass,
							@ModelAttribute MemberVO member, HttpSession session, 
							Model model)throws Exception {

		String mem_id =(String)session.getAttribute("mem_id");
		MemberVO prmv = this.memberService.loginCheck(mem_id);
		
		if(!prmv.getMem_pass().equals(mem_pass)) {
			
			return "member/deleteResult";
		}else {
			
			MemberVO ppmv = new MemberVO();
			ppmv.setMem_id(mem_id);
		
			memberService.passRe(ppmv);
		System.out.println("재확인좀");	
		
		return "redirect:member_update";
		}
	}
	//비밀번호 수정 폼
	@RequestMapping(value="/pass_update")
	public String pass_update(HttpSession session, Model model)throws Exception{
		//세션 객체 안에 있는 ID정보 저장
				String mem_id = (String) session.getAttribute("mem_id");
				System.out.println(mem_id);
				//서비스안의 메서드 호출
				MemberVO pmv = memberService.loginCheck(mem_id);
		return "member/pass_update";
	}
	
	//비밀번호 수정 저장
	@RequestMapping(value="pass_update_ok", method=RequestMethod.POST)
	public String pass_update_ok(HttpSession session,MemberVO member, Model model)throws Exception{

		//세션 객체 안에 있는id정보 저장
		String mem_id = (String) session.getAttribute("mem_id");
		//서비스안의 메서드 호출
		MemberVO pmv = this.memberService.loginCheck(mem_id);
		
		memberService.passUpdate(member);
		
		return "home";
	}
	
	//회원정보 수정 폼
		@RequestMapping(value="/member_update")
		public String member_update(HttpSession session, Model model) throws Exception {
			
			//세션 객체 안에 있는 ID정보 저장
			String mem_id = (String) session.getAttribute("mem_id");
			//서비스안의 메서드 호출
			MemberVO upmv = memberService.loginCheck(mem_id);
			System.out.println("수정폼 컨트롤");
			//정보 저장 후 페이지 이동
			model.addAttribute("upmv", upmv);

			return "member/member_update";
		}
		//회원정보 수정 저장
		@RequestMapping(value="/update_ok", method=RequestMethod.POST)
		public String update_ok(MemberVO member, HttpSession session, Model model) throws Exception {
			
			//세션 객체 안에 있는id정보 저장
			String mem_id = (String) session.getAttribute("mem_id");
			//서비스안의 메서드 호출
			MemberVO upmv = this.memberService.loginCheck(mem_id);
			member.setMem_id(mem_id);
			
			memberService.memberUpdate(member);
			
			System.out.println("수정확인 컨트롤");
	
			//경로는 어디로 할지 정하면 다시 지정하기
			return "home";
			
			
			
	}
	//회원탈퇴 폼
	@RequestMapping(value="member_delete")
	public String member_delete(HttpSession session, Model model) throws Exception {
		//세션 객체 안에 있는 id정보 저장
		String mem_id = (String)session.getAttribute("mem_id");
		//서비스안의 메서드 호출
		MemberVO dmv = memberService.loginCheck(mem_id);
		model.addAttribute("dmv", dmv);
		
		System.out.println("탈퇴폼 컨트롤");
		
		return "member/member_delete";
	}

	//회원탈퇴 저장
	@RequestMapping(value = "/delete_ok", method = RequestMethod.POST)
	public String delete_ok(@RequestParam("mem_pass") String mem_pass,
							HttpSession session) throws Exception {
		
		String mem_id =(String)session.getAttribute("mem_id");
		MemberVO dmv = this.memberService.loginCheck(mem_id);
		
		if(!dmv.getMem_pass().equals(mem_pass)) {
			
			return "member/deleteResult";
		}else {	//비번이 같은 경우
			
			MemberVO delmv = new MemberVO();
			delmv.setMem_id(mem_id);
			
			memberService.deleteMember(delmv);	//수정 메서드 호출
			
			session.invalidate();		//세션만료 
			System.out.println("탈퇴 컨트롤러");
			
			return "redirect:member_login";
			
		}
		
	}
	
}

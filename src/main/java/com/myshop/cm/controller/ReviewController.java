package com.myshop.cm.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.filefilter.FalseFileFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.myshop.cm.model.GoodsVO;
import com.myshop.cm.model.MemberVO;
import com.myshop.cm.model.OrderVO;
import com.myshop.cm.model.PayDetailVO;
import com.myshop.cm.model.ReviewVO;
import com.myshop.cm.service.GoodsService;
import com.myshop.cm.service.OrderService;
import com.myshop.cm.service.PayDetailService;
import com.myshop.cm.service.ReviewService;

@Controller
public class ReviewController {

	@Autowired
	private ReviewService reviewService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private PayDetailService paydetailService;
	
	//후기 폼
	@RequestMapping(value="review_write")
	public String review_write(HttpServletRequest request, HttpServletResponse response, Model model) {
		int ord_gdsnum = Integer.parseInt(request.getParameter("ord_gdsnum"));
		int ord_num = Integer.parseInt(request.getParameter("ord_num"));
		model.addAttribute("ord_gdsnum", ord_gdsnum);
		model.addAttribute("ord_num", ord_num);
		
		return "review/review_write";
	}
		//후기 저장
	@RequestMapping(value="review_ok", method=RequestMethod.POST)
	public String review_ok(@RequestParam(value = "rev_filename1") MultipartFile mf,HttpServletRequest request, HttpServletResponse response, 
							HttpSession session, MemberVO member, Model model, 
							ReviewVO review) throws Exception {
		
			if (mf != null) {
		         //첨부파일 저장
		         UUID uuid = UUID.randomUUID();
		         String filename = uuid + mf.getOriginalFilename();
		         int size = (int) mf.getSize();
		         String path = request.getRealPath("resources/images/reviewimage");
		         int result = 0;
		         String file[] = new String[2];

	         // 첨부파일 저장 체크
//		         if (filename != "") {
//		            StringTokenizer st = new StringTokenizer(filename, ".");
//		            file[0] = st.nextToken();
//		            file[1] = st.nextToken(); // 확장자
//	
//		            // 사이즈가 10mb 이상인경우
//		            if (size > 10000000) {
//		               result = 1;
//		               model.addAttribute("result", result);
//	
//		               return "";
//	
//		            //  
//		            } else if (!file[1].equals("jpg") && !file[1].equals("gif") && !file[1].equals("png") && !file[1].equals("pdf")) {
//	
//		               result = 2;
//		               model.addAttribute("result", result);
//	
//		               return "";
//		            }
//		         }

		         // 첨부파일이 전송된 경우
		         if (size > 0) {
		            mf.transferTo(new File(path + "/" + filename));
		         }

		         review.setRev_filename(filename);
		         System.out.println(path);
		      }
		//현재 세션에 있는 member mem_num값 가져오기
		// 현제 세션에 있는(로그인 한 member의 정보) mem_num값 가져오기
//			MemberVO revmember = (MemberVO)session.getAttribute("member");
//			int mem_num = revmember.getMem_num();
//			review.setMem_num(mem_num);
		
		//ord_num,gds_num가져오기
//			ReviewVO rev = new ReviewVO();
//			rev.setOrd_num("ord_num");
//			rev.setGds_num(gds_num);
//			
//			reviewService.getReview(rev);
//			
//			//rev_num으로 ord_num불러오기
//			OrderVO orderrev = orderService.getOrdReview(review.getOrd_num());
//			
//			//상품번호 가져오기
//			GoodsVO goodsrev = goodsService.getGdsReview(review.getGds_num());

		// 주문번호, 상품번호 받아오기
		int ord_gdsnum = Integer.parseInt(request.getParameter("ord_gdsnum"));
		int ord_num = Integer.parseInt(request.getParameter("ord_num"));
		
		// 현제 세션에 있는(로그인 한 member의 정보) mem_num값 가져오기
		MemberVO reviewmember = (MemberVO)session.getAttribute("member");
		int mem_num = reviewmember.getMem_num();
		String mem_id =	reviewmember.getMem_id();
		
		review.setMem_num(mem_num);
		review.setMem_id(mem_id);
		review.setOrd_num(ord_num);
		review.setGds_num(ord_gdsnum);
		
		// 주문번호로 주문정보 불러오기
		OrderVO order = orderService.getOrdReview(ord_num);
		// 주문정보의 상품옵션 리뷰객체에 담기
//		 review.setOrd_gdsoption(order.getOrd_gdsoption());
		// 주문정보의 상품번호로 상품 정보 불러오기
		GoodsVO gds = goodsService.getGdsReview(ord_gdsnum);
		// 상품이름을 리뷰객체에 담기
		System.out.println(gds.getGds_name());
		review.setGds_name(gds.getGds_name());
		
		reviewService.insertReview(review);	//저장 메서드 호출
		System.out.println("리뷰쓰기 컨트롤러");
		//mem_num불러오기
//			MemberVO mv = reviewService.getMember(member);
//			session.setAttribute("member", mv);
		return "redirect:/review_list";
		}
	
		//리뷰목록
		@RequestMapping(value="review_list")
		public String review_list(HttpServletRequest request, Model model, HttpSession session) throws Exception{
		
			List<ReviewVO> myreviewlist = new ArrayList<ReviewVO>();
			
			int page=1;
			int limit=5;	//한 화면에 출력할 레코드 수
			
			if(request.getParameter("page") != null) {
				page = Integer.parseInt(request.getParameter("page"));
			}
			
			Map<String, Object> indexMap = new HashMap<String, Object>();
			
			MemberVO member = (MemberVO)session.getAttribute("member");
			
			int mem_num = member.getMem_num();
			
			int pageIndex = (page-1)*5;
			
			indexMap.put("mem_num", mem_num);
			indexMap.put("pageIndex", pageIndex);
			
			
			//총 리스트 수를 받아옴
			int listcount = reviewService.getListCount(mem_num);
			
			//페이지 번호(page)를 service클래스에게 전달한다.
			myreviewlist =reviewService.getReviewList(indexMap);	//리스트를 받아옴
			
			//총페이지 수
			int maxpage =(int) ((double) listcount /limit + 0.95);	//0.95를 더해서 올림처리
			
			//현재 페이지에 보여줄 시작 페이지 수(1,6,11...)
			int startpage = (((int) ((double) page / 5 + 0.9)) -1)* 5 + 1;
			//현재 페이지에 보여줄 마지막 페이지 수(5,10,15...)
			int endpage = maxpage;
			
			if(endpage > startpage + 5 -1)
				endpage = startpage + 5 -1;
			
			model.addAttribute("page", page);
			model.addAttribute("startpage", startpage);
			model.addAttribute("endpage", endpage);
			model.addAttribute("maxpage", maxpage);
			model.addAttribute("listcount", listcount);
			model.addAttribute("myreviewlist", myreviewlist);
			
			return"review/review_list";
		}
		//리뷰 보기
		@RequestMapping(value="review_cont")
		public ModelAndView review_cont(@RequestParam("rev_num") int rev_num,
										@RequestParam("page") String page,
										Model model) throws Exception{
			
			ReviewVO review = reviewService.getReviewCont(rev_num);
			
			OrderVO orderrev = orderService.getOrdReview(review.getOrd_num());
			
			PayDetailVO pay = paydetailService.getPayReview(review.getPay_num());
			
			GoodsVO gds = goodsService.getGdsReview(review.getGds_num());
			
			ModelAndView reviewM= new ModelAndView("review/review_cont");
			
			reviewM.addObject("review", review);
			reviewM.addObject("orderrev", orderrev);
			reviewM.addObject("pay", pay);
			reviewM.addObject("gds", gds);
			reviewM.addObject("page", page);
			
			return reviewM;
			
//			if(state.equals("cont")) {	//내용보기 일때
//				
//				//글내용중 엔터키 친 부분을 웹상에 보이게 할때 다음줄로 개행
//				String rev_content = review.getRev_content().replace("\n","<br>");
//				model.addAttribute("rev_content", rev_content);	//리뷰내용출력
//				return "review/review_cont";	//내용보기 페이지 설정
//			}else if(state.equals("update")) {	//수정폼
//				return "review/review_update";
//			}else if(state.equals("delete")) {	//삭제폼
//				return "review/review_delete";
//			}
//			return null;
		}
		//리뷰 수정폼
		@RequestMapping(value="/review_update")
		public String review_update(@RequestParam("rev_num") int rev_num,
									@RequestParam("page") String page,
									Model model)throws Exception {
			
			ReviewVO review = reviewService.getReviewCont(rev_num);
			model.addAttribute("page", page);
			model.addAttribute("review", review);
			
			return "review/review_update";
		}
		//리뷰수정
		@RequestMapping(value="/review_update_ok", method=RequestMethod.POST)
		public String review_update_ok(@RequestParam(value = "rev_filename1") MultipartFile mf,
									@ModelAttribute ReviewVO review,
									@RequestParam("page") String page,
									HttpSession session,HttpServletRequest request,
									Model model)throws Exception {
			if (mf != null) {
		         //첨부파일 저장
		         UUID uuid = UUID.randomUUID();
		         String filename = uuid + mf.getOriginalFilename();
		         int size = (int) mf.getSize();
		         String path = request.getRealPath("resources/images/reviewimage");
		         int result = 0;
		         String file[] = new String[2];

	         // 첨부파일 저장 체크
//		         if (filename != "") {
//		            StringTokenizer st = new StringTokenizer(filename, ".");
//		            file[0] = st.nextToken();
//		            file[1] = st.nextToken(); // 확장자
//	
//		            // 사이즈가 10mb 이상인경우
//		            if (size > 10000000) {
//		               result = 1;
//		               model.addAttribute("result", result);
//	
//		               return "";
//	
//		            //  
//		            } else if (!file[1].equals("jpg") && !file[1].equals("gif") && !file[1].equals("png") && !file[1].equals("pdf")) {
//	
//		               result = 2;
//		               model.addAttribute("result", result);
//	
//		               return "";
//		            }
//		         }

		         // 첨부파일이 전송된 경우
		         if (size > 0) {
		            mf.transferTo(new File(path + "/" + filename));
		         }

		         review.setRev_filename(filename);
		         System.out.println(path);
		      }
			
			//수정 메서드 호출
			reviewService.reviewUpdate(review);
			System.out.println("컨트롤러거기 계세요?");
			
			return "redirect:/review_list?rev_num=" + review.getRev_num() 
							+"&page=" + page;
		}
		//리뷰 삭제폼
//		@RequestMapping(value="/review_delete")
//		public String review_delete() throws Exception{
//			return "review/review_delete";
//		}
	//리뷰 삭제
		@RequestMapping(value="/review_delete")
		public String delete_ok(@RequestParam("rev_num") int rev_num,
								@RequestParam("page") String page,
							HttpSession session,MemberVO member, Model model)throws Exception {
			MemberVO reviewmember = (MemberVO)session.getAttribute("member");
			int mem_num = reviewmember.getMem_num();
			String mem_id =	reviewmember.getMem_id();
			
			//리뷰정보 불러오기
			ReviewVO review = reviewService.getReviewCont(rev_num);
			
			System.out.println("리뷰삭제 컨트롤러 계세요?");
			
			int result =0;
			
			if(!review.getMem_id().equals(mem_id)) {	//아이디 불일치
				result = 1;
				model.addAttribute("result", result);
				
				return "review/deleteResult";
			}else {
				reviewService.reviewDelete(rev_num);
			}
			return "redirect:/review_list?page=" + page;
		}
		
//		// 후기 상세페이지 불러오기
//		  @RequestMapping(value = "/showreviewdetail")
//		  public String reviewdetail(@RequestParam("rev_num") int rev_num, Model model) throws Exception {
//		      
//		     // 받은 후기번호로 상세정보 구해오기
//		     ReviewVO review = reviewService.getReviewCont(rev_num);
//		      
//		     model.addAttribute("review", review);
//		      
//		     return "review/ajaxMyReviewCont";
//		   }
//		
}

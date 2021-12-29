package com.myshop.cm.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.myshop.cm.model.CalculateVO;
import com.myshop.cm.model.DeliveryAddressVO;
import com.myshop.cm.model.DeliveryTemplateVO;
import com.myshop.cm.model.GoodsQnaVO;
import com.myshop.cm.model.GoodsVO;
import com.myshop.cm.model.LCateVO;
import com.myshop.cm.model.MCateVO;
import com.myshop.cm.model.MemberVO;
import com.myshop.cm.model.OptionVO;
import com.myshop.cm.model.OrderListVO;
import com.myshop.cm.model.ReviewVO;
import com.myshop.cm.model.SCateVO;
import com.myshop.cm.model.SellerVO;
import com.myshop.cm.service.CalculateService;
import com.myshop.cm.service.CategoryService;
import com.myshop.cm.service.DeliveryAddressService;
import com.myshop.cm.service.DeliveryCategoryService;
import com.myshop.cm.service.DeliveryTemplateService;
import com.myshop.cm.service.GoodsQnaService;
import com.myshop.cm.service.GoodsService;
import com.myshop.cm.service.MemberService;
import com.myshop.cm.service.OptionService;
import com.myshop.cm.service.OrderService;
import com.myshop.cm.service.ReviewService;
import com.myshop.cm.service.SellerService;

@Controller
public class SellerController {

	@Autowired
	private SellerService sellerService;
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private DeliveryTemplateService deliveryTemplateService;
	@Autowired
	private DeliveryCategoryService deliveryCategoryService;
	@Autowired
	private CalculateService calculateService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private OptionService optionService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private DeliveryAddressService deliveryAddressService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private ReviewService reviewService;
	@Autowired
	private GoodsQnaService goodsQnaService;
	
	
	//판매자 전환 신청 폼
	@RequestMapping(value="sellerChange")
	public String sellerChange(HttpServletRequest request) {
		// 세션에 있는 member정보 받기
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO)session.getAttribute("member");
		
		if(sellerService.getSellerInfo(member.getMem_num()) == null) { // 판매자 신청 안한 일반회원
			return "seller/sellerChange";
		}else if(sellerService.getSellerInfo(member.getMem_num()) != null) { 
			if(member.getMem_grade() != 50) {		// 신청했지만 아직 전환 안된 회원
				return "seller/sellerChange_end";
			}else {									// 판매자전환 완료된 회원
				return "seller/sellerChange_com";
			}
		}
		return null;
	}
	
	//판매자 전환 신청 저장
	@RequestMapping(value="/sellerchange_ok", method=RequestMethod.POST)
	public String sellerchange_ok(@RequestParam(value = "seling_filename1") MultipartFile mf, 
			HttpServletRequest request,HttpSession session, SellerVO seller,MemberVO member, Model model) throws Exception{
		

		if (mf != null) {
	         //첨부파일 저장
	         UUID uuid = UUID.randomUUID();
	         String filename = uuid + mf.getOriginalFilename();
	         int size = (int) mf.getSize();
	         String path = request.getRealPath("resources/images/sellerimage");
	         int result = 0;
	         String file[] = new String[2];

//	         // 첨부파일 저장 체크
//	         if (filename != "") {
//	            StringTokenizer st = new StringTokenizer(filename, ".");
//	            file[0] = st.nextToken();
//	            file[1] = st.nextToken(); // 확장자
//
//	            // 사이즈가 10mb 이상인경우
//	            if (size > 10000000) {
//	               result = 1;
//	               model.addAttribute("result", result);
//
//	               return "";
//
//	            //  
//	            } else if (!file[1].equals("jpg") && !file[1].equals("gif") && !file[1].equals("png") && !file[1].equals("pdf")) {
//
//	               result = 2;
//	               model.addAttribute("result", result);
//
//	               return "";
//	            }
//	         }
//
	         // 첨부파일이 전송된 경우
	         if (size > 0) {
	            mf.transferTo(new File(path + "/" + filename));
	         }

	         seller.setSeling_filename(filename);
	         System.out.println(path);
	      }
		
		// 현제 세션에 있는(로그인 한 member의 정보) mem_num값 가져오기
		MemberVO loginmember = (MemberVO)session.getAttribute("member");
		int mem_num = loginmember.getMem_num();
		seller.setMem_num(mem_num);
		
		sellerService.registerSeller(seller);
		
		System.out.println("컨트롤러");
		
		//mem_num불러오기
		MemberVO vo = sellerService.getMember(member);
		session.setAttribute("vo", vo);
		return "redirect:sellerChange_end"; 
	}
	
	//판매자 전환 신청 완료 폼
	@RequestMapping(value="sellerChange_end")
	public String sellerChange_end() {
		return "seller/sellerChange_end";
	}

	

	// 상품 등록 폼으로 이동
	@RequestMapping(value = "/goodsuploadform")
	public ModelAndView goodsuploadform(HttpServletRequest request, HttpServletResponse response) 
			throws Exception{
		System.out.println("goodsuploadform");
		// 세션에 있는 member정보 받기
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO)session.getAttribute("member");
		
		// 세션의 member.mem_num으로 판매자정보 불러오기
		SellerVO seller = sellerService.getSellerInfo(member.getMem_num());
		
		// 배송 카테고리 목록 불러오기
		Map<String, Object> getdeliverycatelist = deliveryCategoryService.getDeliveryCateList(request, response);
		
		// 배송 템플릿 목록 구해오기
		List<DeliveryTemplateVO> deltemlist = deliveryTemplateService.getTemplateList(seller.getSel_num());
		
		// 카테고리 대분류 불러오기
		List<LCateVO> lcatelist = categoryService.getLCateList();
		
		// 경로 설정
		ModelAndView goodsuploadformM = new ModelAndView("seller/goodsuploadform");
		goodsuploadformM.addAllObjects(getdeliverycatelist);
		goodsuploadformM.addObject("deltemlist", deltemlist);
		goodsuploadformM.addObject("lcatelist", lcatelist);
		goodsuploadformM.addObject("seller", seller);
		
		return goodsuploadformM;
	}

	// 상품 등록
	@RequestMapping(value = "/goodsupload", method = RequestMethod.POST)
	public String goodsupload(
			@RequestParam(value = "gds_thumbnail1", required = false) MultipartFile mf,
			@RequestParam(value = "optioncom", required = false) String optioncom,
			@RequestParam(value = "optioncount", required = false) String optioncount,
			@RequestParam(value = "del_info", required = false) String del_info,
			DeliveryTemplateVO deliverytemplate, GoodsVO goods,
			HttpServletRequest request, Model model) throws Exception {
		// 세션에 있는 member정보 받기
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO)session.getAttribute("member");
		
		// 세션의 member.mem_num으로 판매자정보 불러오기
		SellerVO seller = sellerService.getSellerInfo(member.getMem_num());
		

		// 썸네일 저장
		if (mf != null) {
			UUID uuid = UUID.randomUUID();
			String filename = uuid + mf.getOriginalFilename();
			int size = (int) mf.getSize();
			String path = request.getRealPath("resources/images/thumbnailimage");
			System.out.println(path);
			int result = 0;
			String file[] = new String[2];

			// 썸네일 유효성 체크
			if (filename != "") {
				StringTokenizer st = new StringTokenizer(filename, ".");
				file[0] = st.nextToken();
				file[1] = st.nextToken(); // 확장자

				// 사이즈가 1mb 이상인경우
				if (size > 5000000) {
					result = 1;
					model.addAttribute("result", result);

					return "seller/goodsuploadresult";

				// 그림파일이 아닌경우
				} else if (!file[1].equals("jpg") && !file[1].equals("gif") && !file[1].equals("png")) {
					result = 2;
					model.addAttribute("result", result);

					return "seller/goodsuploadresult";
				}
			}
			// 첨부파일이 전송된 경우
			if (size > 0) {
				mf.transferTo(new File(path + "/" + filename));
			}
			goods.setGds_thumbnail(filename);
		}
		// 배송템플릿을 작성한 경우
		if(del_info != null) {
			// 세션에 있는 member정보 받기
			String[] delinfoarr = del_info.split(",");
			for(int i=0; i<2; i++) {
				System.out.println(i+","+delinfoarr[i]);
			}
			deliverytemplate.setDel_code(Integer.parseInt(delinfoarr[0]));
			deliverytemplate.setDel_name(delinfoarr[1]);
			deliverytemplate.setSel_num(seller.getSel_num());
			deliveryTemplateService.insert(deliverytemplate);  // 저장메소드 호출
		}
		goods.setDeltem_num(deliverytemplate.getDeltem_num());
		goods.setGds_seller(seller.getSel_name());
		goodsService.insert(goods);// 저장 메소드 호출
		int gds_num = goods.getGds_num();
		System.out.println(gds_num);
		
		// 옵션을 작성한 경우
		if (optioncom != null) {
			String option1name = request.getParameter("option1name");
			String option1val = request.getParameter("option1val");
			String option2name = request.getParameter("option2name");
			String option2val = request.getParameter("option2val");
			System.out.println("option2name"+option2name);
			System.out.println("option2val"+option2val);
			
			// 옵션을 2개 작성한 경우
			 if(!option2name.isEmpty() || !option2val.isEmpty()) {											
				// 받아온 옵션값 쪼개기
				String[] optioncomarr = optioncom.split(",");
				// 쪼갠 옵션을 받을 배열
				String[] opcom = new String[2];
				// 옵션별 수량 받아오기
				String[] optioncountarr = optioncount.split(",");
				
				//list에 값 담아서 service로 넘기기
				List<OptionVO> list = new ArrayList<OptionVO>();
				
				// 각 배열에 값 분배하기
				for(int i=0; i<optioncomarr.length; i++) {
					opcom = optioncomarr[i].split(" - ");
					OptionVO optionvo = new OptionVO();
					optionvo.setGds_num(gds_num);
					optionvo.setOpt_1stname(option1name);
					optionvo.setOpt_1stval(opcom[0]);
					optionvo.setOpt_2ndname(option2name);
					optionvo.setOpt_2ndval(opcom[1]);
					optionvo.setOpt_count(Integer.parseInt(optioncountarr[i]));
					
					list.add(optionvo);
				}
			    Map<String, Object> map = new HashMap<String, Object>();	
			    map.put("list", list); //map에 list담기
			    optionService.insertOptions(map);
			    
			 //옵션을 1개 작성한 경우
			}else{  
				// 받아온 옵션값 쪼개기
				String[] optioncomarr = optioncom.split(",");
				// 옵션별 수량 받아오기
				String[] optioncountarr = optioncount.split(",");
				
				//list에 값 담아서 service로 넘기기
				List<OptionVO> list = new ArrayList<OptionVO>();
				
				// 각 배열에 값 분배하기
				for(int i=0; i<optioncomarr.length; i++) {
					OptionVO optionvo = new OptionVO();
					optionvo.setGds_num(gds_num);
					optionvo.setOpt_1stname(option1name);
					optionvo.setOpt_1stval(optioncomarr[i]);
					optionvo.setOpt_count(Integer.parseInt(optioncountarr[i]));
					
					list.add(optionvo);
				}
			    Map<String, Object> map = new HashMap<String, Object>();	
			    map.put("list", list); //map에 list담기
			    optionService.insertOptions(map);
			}
		// 옵션을 작성하지 않은경우
		}else {
			System.out.println("옵션을 작성하지 않음");
			String opt_count = request.getParameter("opt_count");
			OptionVO optionvo = new OptionVO();
			optionvo.setGds_num(gds_num);
			optionvo.setOpt_count(Integer.parseInt(opt_count));
			optionService.insertOption(optionvo);
		}
				
		return "redirect:/sellergoodslist";
	}

	// 판매자별 상품목록
	@RequestMapping(value = "/sellergoodslist")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// select로 검색한 결과를 받아올 map객체 선언
		// request, response를 인자값으로 받는 이유는 service단에서 getParameter로 값을 받기 위함이다.
		Map<String, Object> sellergoodslist = goodsService.sellergoodslist(request, response);

		// ModelAndView 객체를 생성과 동시에 경로를 설정함
		ModelAndView sellergoodslistM = new ModelAndView("seller/sellergoodslist");
		
		// ModelAndView 객체에 요청받아온 값을 담아준다.
		sellergoodslistM.addAllObjects(sellergoodslist);

		// ModelAndView을 리턴해준다.
		return sellergoodslistM;
	}

	// 판매자 상품 페이지로 보기
	@RequestMapping(value = "/goodsdetail")
	public ModelAndView goodsdetail(@RequestParam("gds_num") int gds_num, @RequestParam("page") String page,
			HttpServletResponse response) throws Exception {
		GoodsVO goods = goodsService.goodsdetail(gds_num);

		String gds_detail = goods.getGds_detail().replace("/resources", "${pageContext.request.contextPath}/resources");

		ModelAndView goodsdetailM = new ModelAndView();
		goodsdetailM.addObject("goods", goods);
		goodsdetailM.addObject("gds_goods", gds_detail);
		goodsdetailM.addObject("page", page);
		goodsdetailM.setViewName("seller/goodsdetail");

		return goodsdetailM;
	}

	// 옵션 조합하기
	@RequestMapping(value = "/optioncom")
	public String optioncom(HttpServletRequest request, Model model) throws Exception {
		System.out.println("optioncom");
		String option1name = request.getParameter("option1name");
		String option1val = request.getParameter("option1val");
		String option2name = request.getParameter("option2name");
		String option2val = request.getParameter("option2val");
		// 옵션을 1개만 입력한 경우
		if (option2name == "" || option2val == "") {
			String[] optioncom = option1val.split(",");
			model.addAttribute("option1name", option1name);
			model.addAttribute("optioncom", optioncom);
		// 옵션을 2개 입력한 경우
		} else { 
			String[] option1valarr = option1val.split(",");
			String[] option2valarr = option2val.split(",");
			String[] optioncom = new String[option1valarr.length * option2valarr.length];
			int k = 0;
			// 옵션섞기
			for (int i = 0; i < option1valarr.length; i++) {
				for (int j = 0; j < option2valarr.length; j++) {
					optioncom[k] = option1valarr[i] + " - " + option2valarr[j];
					k++;
				}
			}
			model.addAttribute("option1name", option1name);
			model.addAttribute("option2name", option2name);
			model.addAttribute("optioncom", optioncom);
		}
		return "seller/optioncom";
	}
	
	
	// 상품 수정폼으로 이동
	@RequestMapping(value = "/goodsupdate")
	public ModelAndView goodsupdate(@RequestParam("gds_num") int gds_num,
									@RequestParam(value = "page", required = false) String page,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView goodsupdateM = new ModelAndView();
		GoodsVO goods = goodsService.goodsdetail(gds_num);
		
		// 세션에 있는 member정보 받기
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO)session.getAttribute("member");
		
		// 세션의 member.mem_num으로 판매자정보 불러오기
		SellerVO seller = sellerService.getSellerInfo(member.getMem_num());
		
		// 옵션정보 불러오기
		List<OptionVO> optionlist = optionService.optionlist(gds_num);
		
		// 배송 카테고리 목록 불러오기
		Map<String, Object> getdeliverycatelist = deliveryCategoryService.getDeliveryCateList(request, response);
		
		// 배송 템플릿 목록 구해오기
		List<DeliveryTemplateVO> deltemlist = deliveryTemplateService.getTemplateList(seller.getSel_num());
		
		// 베송 템플릿 불러오기
		DeliveryTemplateVO gettemplate = deliveryTemplateService.getTemplate(goods.getDeltem_num());
		
		// 카테고리 대분류 불러오기
		List<LCateVO> lcatelist = categoryService.getLCateList();
		
		// 대분류코드로 중분류 카테고리 리스트 불러오기
		List<MCateVO> mcatelist = categoryService.getMCateList(goods.getLcate_code());
		
		// 중분류 코드로 소분류코드 불러오기
		List<SCateVO> scatelist = categoryService.getSCateList(goods.getMcate_code());
		
		goodsupdateM.addAllObjects(getdeliverycatelist);
		goodsupdateM.addObject("gettemplate", gettemplate);
		goodsupdateM.addObject("optionlist", optionlist);
		goodsupdateM.addObject("deltemlist", deltemlist);
		goodsupdateM.addObject("lcatelist", lcatelist);
		goodsupdateM.addObject("mcatelist", mcatelist);
		goodsupdateM.addObject("scatelist", scatelist);
		goodsupdateM.addObject("goods", goods);
		goodsupdateM.addObject("page", page);
		goodsupdateM.setViewName("seller/goodsupdateform");

		return goodsupdateM;
	}
	
	// 상품 수정
	@RequestMapping(value = "/goodsupdate", method = RequestMethod.POST)
	public String goodsupdate(@RequestParam(value = "gds_thumbnail1", required = false) MultipartFile mf,
							  @RequestParam(value = "optioncom", required = false) String optioncom,
							  @RequestParam(value = "optioncount", required = false) String optioncount,
							  @RequestParam(value = "del_info", required = false) String del_info,
							  @RequestParam(value = "page", required = false) String page,
							  DeliveryTemplateVO deliverytemplate, GoodsVO goods,
							  HttpServletRequest request, Model model) throws Exception {
		
		// 세션에 있는 member정보 받기
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO)session.getAttribute("member");
		
		// 세션의 member.mem_num으로 판매자정보 불러오기
		SellerVO seller = sellerService.getSellerInfo(member.getMem_num());
		
		// 옵션을 새로 작성한 경우
		if (optioncom != null) {
			// 기존옵션삭제
			optionService.deleteOptions(goods.getGds_num());
			String option1name = request.getParameter("option1name");
			String option1val = request.getParameter("option1val");
			String option2name = request.getParameter("option2name");
			String option2val = request.getParameter("option2val");
			System.out.println("option2name"+option2name);
			System.out.println("option2val"+option2val);
			
			// 옵션을 2개 작성한 경우
			 if(!option2name.isEmpty() && !option2val.isEmpty()) {											
				// 받아온 옵션값 쪼개기
				String[] optioncomarr = optioncom.split(",");
				// 쪼갠 옵션을 받을 배열
				String[] opcom = new String[2];
				// 옵션별 수량 받아오기
				String[] optioncountarr = optioncount.split(",");
				
				//list에 값 담아서 service로 넘기기
				List<OptionVO> list = new ArrayList<OptionVO>();
				
				// 각 배열에 값 분배하기
				for(int i=0; i<optioncomarr.length; i++) {
					opcom = optioncomarr[i].split(" - ");
					OptionVO optionvo = new OptionVO();
					optionvo.setGds_num(goods.getGds_num());
					optionvo.setOpt_1stname(option1name);
					optionvo.setOpt_1stval(opcom[0]);
					optionvo.setOpt_2ndname(option2name);
					optionvo.setOpt_2ndval(opcom[1]);
					optionvo.setOpt_count(Integer.parseInt(optioncountarr[i]));
					
					list.add(optionvo);
				}
			    Map<String, Object> map = new HashMap<String, Object>();	
			    map.put("list", list); //map에 list담기
			    optionService.insertOptions(map);
			    
			 //옵션을 1개 작성한 경우
			}else if(!option1name.isEmpty() && !option1val.isEmpty() && 
					 option2name.isEmpty() && option2val.isEmpty()){ 
				System.out.println("옵션을 1개만 작성한 경우");
				// 받아온 옵션값 쪼개기
				String[] optioncomarr = optioncom.split(",");
				// 옵션별 수량 받아오기
				String[] optioncountarr = optioncount.split(",");
				
				//list에 값 담아서 service로 넘기기
				List<OptionVO> list = new ArrayList<OptionVO>();
				
				// 각 배열에 값 분배하기
				for(int i=0; i<optioncomarr.length; i++) {
					OptionVO optionvo = new OptionVO();
					optionvo.setGds_num(goods.getGds_num());
					optionvo.setOpt_1stname(option1name);
					optionvo.setOpt_1stval(optioncomarr[i]);
					optionvo.setOpt_count(Integer.parseInt(optioncountarr[i]));
					
					list.add(optionvo);
				} // for end
			    Map<String, Object> map = new HashMap<String, Object>();	
			    map.put("list", list); //map에 list담기
			    optionService.insertOptions(map);
			}else {
				OptionVO optionvo = new OptionVO();
				optionvo.setGds_num(goods.getGds_num());
				optionvo.setOpt_count(Integer.parseInt(request.getParameter("opt_count")));
				optionService.insertOption(optionvo);
			} // if ~ else if ~ else end
		// 옵션을 새로 작성하지 않은경우
		}else {
			// 기존 작성한 옵션이 있는경우
			if(request.getParameter("edit_opt_1stval") != null ) {
				System.out.println("기존 작성한 옵션이 있는 경우 - 기존에 2개 또는 1개옵션으로 작성");
				String[] edit_opt_numarr = request.getParameterValues("edit_opt_num");
				String[] edit_opt_countarr = request.getParameterValues("edit_opt_count");
				for(int i=0; i<edit_opt_numarr.length; i++) {
					System.out.println(edit_opt_numarr[i] +" + "+ edit_opt_countarr[i]);
				} // for end
				
				List<OptionVO> list = new ArrayList<OptionVO>();
				
				for(int i=0; i<edit_opt_numarr.length; i++) {
					OptionVO optionvo = new OptionVO();
					optionvo.setOpt_num(Integer.parseInt(edit_opt_numarr[i]));
					optionvo.setOpt_count(Integer.parseInt(edit_opt_countarr[i]));
					
					list.add(optionvo);
				} // for end
				Map<String, Object> map = new HashMap<String, Object>();	
				map.put("list", list); //map에 list담기
				optionService.updateOptions(map);
			// 옵션없이 작성한 경우(단일옵션)
			}else {
				System.out.println("기존 작성한 옵션이 있는 경우 - 기존에 옵션없이 작성");
				OptionVO optionvo = new OptionVO();
				optionvo.setOpt_num(Integer.parseInt(request.getParameter("edit_opt_num")));
				optionvo.setOpt_count(Integer.parseInt(request.getParameter("edit_opt_count")));
				
				optionService.updateOption(optionvo);
			} // else end
		} // if ~ else end

		// 썸네일 을 수정한경우
		if (!mf.isEmpty()) {
			System.out.println("썸네일 수정");
			System.out.println("mf.isEmpty() : "+mf.isEmpty());
			System.out.println(mf.getOriginalFilename());
			// 기존 파일 삭제
			GoodsVO oldgoods = goodsService.goodsdetail(goods.getGds_num());
			
			String oldfilepath = request.getRealPath("resources/images/thumbnailimage/");
			String oldfilename = oldgoods.getGds_thumbnail();
    		File oldfile = new File(oldfilepath+oldfilename);
    		System.out.println(oldfile.exists());
			if(oldfile.exists() == true){
			oldfile.delete();
	        } // if end
			
			// 새로운 파일 저장
			UUID uuid = UUID.randomUUID();
			String filename = uuid + mf.getOriginalFilename();
			String path = request.getRealPath("resources/images/thumbnailimage/");

//			// 썸네일 유효성 체크
//			if (filename != "") {
//				StringTokenizer st = new StringTokenizer(filename, ".");
//				file[0] = st.nextToken();
//				file[1] = st.nextToken(); // 확장자
//
//				// 사이즈가 1mb 이상인경우
//				if (size > 1000000) {
//					result = 1;
//					model.addAttribute("result", result);
//	
//					return "seller/goodsuploadresult";
//	
//				// 그림파일이 아닌경우
//				} else if (!file[1].equals("jpg") && !file[1].equals("gif") && !file[1].equals("png")) {
//					result = 2;
//					model.addAttribute("result", result);
//	
//					return "seller/goodsuploadresult";
//				}
//			}
			mf.transferTo(new File(path + "/" + filename));
			goods.setGds_thumbnail(filename);			

			
		} else { // 첨부파일이 수정되지 않으면 기존 파일명 사용
			System.out.println("썸네일 수정 안함");
			System.out.println("mf.isEmpty() : "+mf.isEmpty());
			GoodsVO oldgoods = goodsService.goodsdetail(goods.getGds_num());
			System.out.println(oldgoods.getGds_thumbnail());
			goods.setGds_thumbnail(oldgoods.getGds_thumbnail());
		} // else end
		
		goodsService.update(goods);// 저장 메소드 호출
		
		// 배송템플릿을 새로 작성한 경우
		if(del_info != null) {
			String[] delinfoarr = del_info.split(",");
			deliverytemplate.setSel_num(seller.getSel_num());
			deliverytemplate.setDel_code(Integer.parseInt(delinfoarr[0]));
			deliverytemplate.setDel_name(delinfoarr[1]);
			deliveryTemplateService.insert(deliverytemplate);  // 저장메소드 호출
		} // if end
		return "redirect:/sellergoodslist";
	}  //goodsupdate end
	
	// 상품 삭제하기
	@RequestMapping(value = "/goodsdelete")
	public String goodsdelete(@RequestParam(value = "gds_num") int gds_num,
							  @RequestParam(value = "page") String page,
							  HttpServletRequest request) throws Exception{
		// 삭제버튼을 누른 상품 정보 불러오기
		GoodsVO goods = goodsService.goodsdetail(gds_num);
		
		// 본문 이미지 경로, 이름 불러오기
		String gds_detail = goods.getGds_detail();
		
		// 이미지 경로,이름을 받을 배열 추가
		String[] gds_detailarr = new String[10];
		int[] gds_detailIndex = new int[10];
		
		// 배열에 본문이미지 경로이름 넣고 삭제하기
		for(int i=0; i<10; i++) {
			int index = 0;
			 if(i == 0){
				 index = gds_detail.indexOf("resource");
			 }else {
				 index = gds_detail.indexOf("resource", gds_detailIndex[i-1]+81);
				 // 이미지가 더이상없으면 for문 나가기(index에 -1이 들어가게되면 오류발생)
				 if(index < 0) {
					 break;
				 } // if end
			 } // else end
			 gds_detailIndex[i] = index;
			 String gds_detailfile = gds_detail.substring(gds_detailIndex[i], gds_detailIndex[i]+81);
			 gds_detailarr[i] = request.getRealPath(gds_detailfile);
			 System.out.println(gds_detailIndex[i]);
			 System.out.println(gds_detailarr[i]);
			 
			 // 본문 이미지파일 삭제
	    	 File detailfile = new File(gds_detailarr[i]);
	    	 System.out.println(detailfile.exists());
			 if(detailfile.exists() == true){
				 detailfile.delete();
		     }// if end
		} // for end
		
		// 썸네일 이미지 삭제
		String thumbnailfilepath = request.getRealPath("resources/images/thumbnailimage/");
		String thumbnailfilename = goods.getGds_thumbnail();
		File thumbnailfile = new File(thumbnailfilepath+thumbnailfilename);
		System.out.println(thumbnailfile.exists());
		if(thumbnailfile.exists() == true){
			thumbnailfile.delete();
        }
		
		// 옵션삭제
		optionService.deleteOptions(gds_num);
		
		// DB 에서 goods데이터 삭제
		goodsService.deletegoods(gds_num);
		
		return "redirect:/sellergoodslist?page="+page;
	}
	
	// 상품 비공개 전환
	@RequestMapping(value = "/goodshide")
	public String goodshide(@RequestParam(value = "page") String page,
							@RequestParam(value = "gds_num") int gds_num) throws Exception{
		
		goodsService.goodshide(gds_num);
		
		return "redirect:/sellergoodslist?page="+page;
	}
	
	// 상품 공개 전환
	@RequestMapping(value = "/goodsview")
	public String goodsview(@RequestParam(value = "page") String page,
							@RequestParam(value = "gds_num") int gds_num) throws Exception{
		
		goodsService.goodsview(gds_num);
		
		return "redirect:/sellergoodslist?page="+page;
	}
	
	// 판매자 정산내역 리스트
	@RequestMapping(value = "/sellercalculatelist")
	public ModelAndView sellercalculatelist(HttpServletRequest request, HttpServletResponse response) throws Exception {

		Map<String, Object> calculatelist = calculateService.calculatelist(request, response);
		
		ModelAndView calculatelistM = new ModelAndView("seller/sellercalculatelist");
		
		calculatelistM.addAllObjects(calculatelist);

		return calculatelistM;
	}
	
	// 판매자 정산내역 상세페이지
	@RequestMapping(value = "/showcalculdetail")
	public ModelAndView showcalculdetail(@RequestParam("clcln_num") int clcln_num, Model model) throws Exception {
		
		// calcul_num으로 정산정보 불러오기
		CalculateVO calculate = calculateService.getCalculDetail(clcln_num);
		
		// 정산정보의 getOrd_num 값으로 주문정보 불러오기
		OrderListVO order = orderService.getOrderDetail(calculate.getOrd_num());
		
		// 정산정보의 gds_num으로 상품정보 불러오기
		GoodsVO goods = goodsService.goodsdetail(calculate.getGds_num());
		
		// 주문정보의 opt_num으로 옵션정보 불러오기
		OptionVO option = optionService.getoption(order.getOpt_num());
		
		// 상품 상세정보의 deltem_num 으로 배송탬플릿 정보 불러오기
		// DeliveryTemplateVO deliverytemplate = deliveryTemplateService.getTemplate(goods.getDeltem_num());
		
		// modelAndView 객체 생성과 동시에 패스설정
		ModelAndView showcalculdetailM = new ModelAndView("seller/calculdetail");
		
		showcalculdetailM.addObject("calculate", calculate);
		showcalculdetailM.addObject("order", order);
		showcalculdetailM.addObject("goods", goods);
		showcalculdetailM.addObject("option", option);
		// showcalculdetailM.addObject("deliverytemplate", deliverytemplate);
		
		return showcalculdetailM;
	}
	
	// 판매자 문의내역 목록으로 이동
	@RequestMapping(value = "/sellergoodsqnalist")
	public ModelAndView sellergoodsqnalist(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView sellergoodsqnalistM = new ModelAndView("seller/sellergoodsqnalist");
		
		// 문의 리스트 받아오기
		Map<String, Object> goodsqnalist = goodsQnaService.getGoodsQnaList(request, response);

		sellergoodsqnalistM.addAllObjects(goodsqnalist);
		
		return sellergoodsqnalistM;
	}
	
	// 판매자 문의 상세목록으로 이동
	@RequestMapping(value = "/showgoodsQnadetail")
	public String showgoodsQnadetail(@RequestParam("gdsqna_num") int gdsqna_num, Model model) throws Exception{
		
		// 답변이 달렸는지 확인하기
		int answer = goodsQnaService.getGoodsQnaAnswer(gdsqna_num);
		model.addAttribute("answer", answer);
		
		// 문의확인 업데이트
		goodsQnaService.updateCheckQna(gdsqna_num);
		
		// 문의 확인하기
		GoodsQnaVO goodsquestion = goodsQnaService.getGoodsQuestionDetail(gdsqna_num);
		model.addAttribute("goodsquestion", goodsquestion);
		
		// 답변이 있다면 답변 확인하기
		if(answer == 1) {
			GoodsQnaVO goodsanswer = goodsQnaService.getGoodsAnswerDetail(gdsqna_num);
			model.addAttribute("goodsanswer", goodsanswer);
		}
		
		return "seller/ajaxgoodsqnadetail";
	}
	
	// 판매자 문의 답변 등록페이지로
	@RequestMapping(value = "/goodsqnaanswer")
	public String goodsqnaanswer(HttpServletRequest request, GoodsQnaVO goodsqna) {
		// 세션에 있는 member정보 받기
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO)session.getAttribute("member");
		
		// 세션의 member.mem_num으로 판매자정보 불러오기
		SellerVO seller = sellerService.getSellerInfo(member.getMem_num());
		
		// 폼테그에서 받아온 gdsqna_num값으로 원문 정보 가져오기
		GoodsQnaVO goodsquestion = goodsQnaService.getGoodsQuestionDetail(goodsqna.getGdsqna_num());
		
		// 판매자가 작성한 정보 덮어씌우기
		goodsquestion.setMem_id(seller.getSel_name());
		goodsquestion.setGdsqna_title(goodsqna.getGdsqna_title());
		goodsquestion.setGdsqna_content(goodsqna.getGdsqna_content());
		
		// 답변글 
		goodsQnaService.insertGoodsQna(goodsquestion);
		
		return "redirect:/sellergoodsqnalist";
	}
	
	// 상품 문의 답변 수정 폼으로 이동
	@RequestMapping(value = "/updategoodsqnaanswerform")
	public String updategoodsqnaanswerform(@RequestParam(value = "gdsqna_num") int gdsqna_num,
										Model model) {	
		// 받아온 gdsqna_num으로 답변 정보 불러오기
		GoodsQnaVO answer =  goodsQnaService.getGoodsAnswer(gdsqna_num);
		
		model.addAttribute("answer", answer);
		
		return "seller/ajaxgoodsqnaanswerupdate";
	}
	
	// 상품 문의 답변 수정 
	@RequestMapping(value = "/updategoodsqnaanswer")
	public String updategoodsqnaanswer(GoodsQnaVO goodsqna) {
		
		// 받아온 gdsqna_num으로 답변 정보 불러오기
		goodsQnaService.updateAnswer(goodsqna);
		
		return "redirect:/sellergoodsqnalist";
	}
	
	// 상품 문의 답변 삭제
	@RequestMapping(value = "/deletegoodsqnaanswer")
	public String deletegoodsqnaanswer(@RequestParam(value = "gdsqna_num") int gdsqna_num) {
		
		goodsQnaService.deleteAnswer(gdsqna_num);
		
		return "redirect:/sellergoodsqnalist";
	}
	
	//판매자 주문내역 목록으로 이동
	@RequestMapping(value = "/sellerorderlist")
	public ModelAndView sellerorderlist(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		// 주문리스트 받아오기
		Map<String, Object> orderlist = orderService.getOrderList(request, response);
		
		ModelAndView sellerorderlistM = new ModelAndView("seller/sellerorderlist");
		sellerorderlistM.addAllObjects(orderlist);
		
		return sellerorderlistM;
	}
	
	// 판매자 주문 상세목록으로 이동
	@RequestMapping(value = "/sellerorderdetail")
	public ModelAndView sellerorderdetail(HttpServletRequest request, HttpServletResponse response) throws Exception{
		int ol_num = Integer.parseInt(request.getParameter("ol_num"));		
		String page = request.getParameter("page");
		
		// 주문 상세정보 구해오기
		OrderListVO order = orderService.getOrderDetail(ol_num);
		
		// 주문 상세정보의 gds_num으로 상품정보 불러오기
		GoodsVO goods = goodsService.goodsdetail(order.getGds_num());
		
		// 주문 상세정보의 ord_gdsoption 으로 옵션정보 불러오기
		OptionVO option = optionService.getoption(order.getOpt_num());
		
		// 상품 상세정보의 deltem_num 으로 배송탬플릿 정보 불러오기
		DeliveryTemplateVO deliverytemplate = deliveryTemplateService.getTemplate(goods.getDeltem_num());
		
		// 주문 상세정보의 mem_num으로 구매자 상세정보 불러오기
		MemberVO member = memberService.getmemberinfo(order.getMem_num());
		
		// 주문 상세정보의 mem_num으로 배송지 상세정보구하기
		DeliveryAddressVO deliveryAddress = deliveryAddressService.getdeliveryAddress(order.getMem_num());
		
		
		ModelAndView sellerorderdetailM = new ModelAndView("seller/sellerorderdetail");
		sellerorderdetailM.addObject("page", page);
		sellerorderdetailM.addObject("order", order);
		sellerorderdetailM.addObject("goods", goods);
		sellerorderdetailM.addObject("option", option);
		sellerorderdetailM.addObject("deliverytemplate", deliverytemplate);
		sellerorderdetailM.addObject("member", member);
		sellerorderdetailM.addObject("deliveryAddress", deliveryAddress);
		
		return sellerorderdetailM;
	}
	
	// 판매자 메인페이지로 이동
	@RequestMapping(value = "seller_Mainpage")
	public String sellerMainpage(HttpServletRequest request, HttpServletResponse response, Model model) {
		// 세션에 있는 member정보 받기
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO)session.getAttribute("member");
		
		// 세션의 member.mem_num으로 판매자정보 불러오기
		SellerVO seller = sellerService.getSellerInfo(member.getMem_num());
		
		// 세션으로 가져온 판매자 정보로 최근 5개 판매상품 불러오기
		List<OrderListVO> mainOrderList = orderService.getMainOrderList(seller.getSel_name());
		
		// 세션으로 가져온 판매자 정보로  최근 5개 공지 가져오기
		
		// 세션으로 가져온 판매자 정보로 최근 5개 문의 가져오기
		List<GoodsQnaVO> mainGoodsQnaList = goodsQnaService.getMainGoodsQnaList(seller.getSel_name());
		
		// 세션으로 가져온 판매자 정보로  최근 5개 후기 가져오기
		List<ReviewVO> mainReviewList = reviewService.getMainReviewList(seller.getSel_name());
		
		model.addAttribute("mainOrderList", mainOrderList);
		model.addAttribute("mainGoodsQnaList", mainGoodsQnaList);
		model.addAttribute("mainReviewList", mainReviewList);
		
		return "seller/sellerMainpage";
	}
	
	// 판매자 후기 목록으로 이동
	@RequestMapping(value = "sellerreviewlist")
	public ModelAndView sellerreviewlist(HttpServletRequest request, HttpServletResponse response) throws Exception{
		ModelAndView sellerreviewlistM = new ModelAndView("seller/sellerreviewlist");
		
		// 후기 리스트 받아오기
		Map<String, Object> sellerreviewlist = reviewService.getSellerReviewList(request, response);
		
		sellerreviewlistM.addAllObjects(sellerreviewlist);
		
		return sellerreviewlistM;
	}
	
	// 후기 상세페이지 불러오기
	@RequestMapping(value = "/showsellerreviewdetail")
	public String reviewdetail(@RequestParam("rev_num") int rev_num, Model model) throws Exception {
		
		// 받은 후기번호로 상세정보 구해오기
		ReviewVO review = reviewService.getReviewCont(rev_num);
		
		model.addAttribute("review", review);
		
		return "seller/ajaxsellerreviewdetail";
	}
}

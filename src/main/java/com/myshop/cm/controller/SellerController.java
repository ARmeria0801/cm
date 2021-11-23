package com.myshop.cm.controller;

import java.io.File;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.myshop.cm.model.DeliveryTemplateVO;
import com.myshop.cm.model.GoodsVO;
import com.myshop.cm.service.DeliveryCategoryService;
import com.myshop.cm.service.DeliveryTemplateService;
import com.myshop.cm.service.GoodsService;

@Controller
public class SellerController {

	@Autowired
	private GoodsService goodsService;
	@Autowired
	private DeliveryTemplateService deliveryTemplateService;
	@Autowired
	private DeliveryCategoryService deliveryCategoryService;

	// 상품 등록 폼으로 이동
	@RequestMapping(value = "/goodsuploadform")
	public ModelAndView goodsuploadform(HttpServletRequest request, HttpServletResponse response) 
			throws Exception{
		System.out.println("goodsuploadform");
		
		// 배송 카테고리 목록 불러오기
		Map<String, Object> getdeliverycatelist = deliveryCategoryService.getDeliveryCateList(request, response);
		
		// 배송 템플릿 목록 구해오기
		List<DeliveryTemplateVO> deltemlist = deliveryTemplateService.getTemplateList();
		
		// 경로 설정
		ModelAndView goodsuploadformM = new ModelAndView("seller/goodsuploadform");
		goodsuploadformM.addAllObjects(getdeliverycatelist);
		goodsuploadformM.addObject("deltemlist", deltemlist);
		
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
		System.out.println("goodsupload");
		System.out.println(optioncount);
		System.out.println(optioncom);
		
		// 옵션을 작성한 경우
		if (optioncom != null) {
			String[] optioncomarr = optioncom.split(",");
			String[] optioncountarr = optioncount.split(",");
			String[] option = new String[optioncomarr.length];
			for (int i = 0; i < option.length; i++) {
				option[i] = optioncomarr[i] + "-" + optioncountarr[i];
			}

			for (String s : option) {
				System.out.println(s);
			}
			String gds_option = Arrays.toString(option);

			goods.setGds_option(gds_option);
		}

		// 썸네일 저장
		if (mf != null) {
			UUID uuid = UUID.randomUUID();
			String filename = uuid + mf.getOriginalFilename();
			int size = (int) mf.getSize();
			String path = request.getRealPath("resources/image/thumbnailimage");
			int result = 0;
			String file[] = new String[2];

			// 썸네일 유효성 체크
			if (filename != "") {
				StringTokenizer st = new StringTokenizer(filename, ".");
				file[0] = st.nextToken();
				file[1] = st.nextToken(); // 확장자

				// 사이즈가 1mb 이상인경우
				if (size > 1000000) {
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
		goodsService.insert(goods);// 저장 메소드 호출
		
		// 배송템플릿을 작성한 경우
		if(del_info != null) {
			
			String[] delinfoarr = del_info.split(",");
			for(int i=0; i<2; i++) {
				System.out.println(i+","+delinfoarr[i]);
			}
			deliverytemplate.setDel_code(Integer.parseInt(delinfoarr[0]));
			deliverytemplate.setDel_name(delinfoarr[1]);
			deliveryTemplateService.insert(deliverytemplate);  // 저장메소드 호출
		}
		return "redirect:/sellergoodslist";
	}

	// 판매자별 상품목록
	@RequestMapping(value = "/sellergoodslist")
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws Exception {

		Map<String, Object> sellergoodslist = goodsService.sellergoodslist(request, response);

		ModelAndView sellergoodslistM = new ModelAndView("seller/sellergoodslist");
		
		sellergoodslistM.addAllObjects(sellergoodslist);

		return sellergoodslistM;
	}

	// 판매자 상품 구매자페이지로 보기
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
		String option1 = request.getParameter("option1");
		String option2 = request.getParameter("option2");
		// 옵션을 1개만 입력한 경우
		if (option2 == "") {
			String[] optioncom = option1.split(",");
			model.addAttribute("optioncom", optioncom);
		// 옵션을 2개 입력한 경우
		} else { 
			String[] op1arr = option1.split(",");
			String[] op2arr = option2.split(",");
			String[] optioncom = new String[op1arr.length * op2arr.length];
			int k = 0;
			// 옵션섞기
			for (int i = 0; i < op1arr.length; i++) {
				for (int j = 0; j < op2arr.length; j++) {
					optioncom[k] = op1arr[i] + "-" + op2arr[j];
					k++;
				}
			}
			model.addAttribute("optioncom", optioncom);
		}
		return "seller/optioncom";
	}
	
	
	// 상품 수정폼으로 이동
	@RequestMapping(value = "/goodsupdate")
	public ModelAndView goodsupdate(@RequestParam("gds_num") int gds_num, @RequestParam("page") String page,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView goodsupdateM = new ModelAndView();
		GoodsVO goods = goodsService.goodsdetail(gds_num);
		
		if(goods.getGds_option() != null) {
			String getOption = goods.getGds_option().replaceAll("\\[", "").replaceAll("\\]","");
			
			String[] optionarr = getOption.split(", ");
			String[] optioncom = new String[optionarr.length];
			String[] optioncount = new String[optionarr.length];
			
			// 옵션을 1개만 입력했을 때
			if(optionarr[0].split("-").length == 2) {
				for(int i=0; i<optionarr.length; i++) {
					String[] op = optionarr[i].split("-");
					optioncom[i] = op[0];
					optioncount[i] = op[1];
				}
			}
			// 옵션을 2개를 입력했을 때
			if(optionarr[0].split("-").length == 3) {
				for(int i=0; i<optionarr.length; i++) {
					String[] op = optionarr[i].split("-");
					optioncom[i] = op[0]+"-"+op[1];
					optioncount[i] = op[2];
				}
			}
			goodsupdateM.addObject("optioncom", optioncom);
			goodsupdateM.addObject("optioncount", optioncount);
		}
		
		// 배송 카테고리 목록 불러오기
		Map<String, Object> getdeliverycatelist = deliveryCategoryService.getDeliveryCateList(request, response);
		
		// 배송 템플릿 목록 구해오기
		List<DeliveryTemplateVO> deltemlist = deliveryTemplateService.getTemplateList();
		
		// 베송 템플릿 불러오기
		DeliveryTemplateVO gettemplate = deliveryTemplateService.getTemplate(goods.getDeltem_num());
		
		
		goodsupdateM.addObject("gettemplate", gettemplate);
		
		// 경로 설정
		goodsupdateM.addAllObjects(getdeliverycatelist);
		goodsupdateM.addObject("deltemlist", deltemlist);
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
		
		// 옵션을 작성 및 수정한 경우
		if (optioncom != null) {
			String[] optioncomarr = optioncom.split(",");
			String[] optioncountarr = optioncount.split(",");
			String[] option = new String[optioncomarr.length];
			for (int i = 0; i < option.length; i++) {
				option[i] = optioncomarr[i] + "-" + optioncountarr[i];
			}

			for (String s : option) {
				System.out.println(s);
			}
			String gds_option = Arrays.toString(option);

			goods.setGds_option(gds_option);
		}

		// 썸네일 을 수정한경우
		if (mf != null) {
			
			// 기존 파일 삭제
			GoodsVO oldgoods = goodsService.goodsdetail(goods.getGds_num());
			
			String oldfilepath = request.getRealPath("resources/image/thumbnailimage/");
			String oldfilename = oldgoods.getGds_thumbnail();
    		File oldfile = new File(oldfilepath+oldfilename);
    		System.out.println(oldfile.exists());
			if(oldfile.exists() == true){
			oldfile.delete();
	        }
			
			// 새로운 파일 저장
			UUID uuid = UUID.randomUUID();
			String filename = uuid + mf.getOriginalFilename();
			int size = (int) mf.getSize();
			String path = request.getRealPath("resources/image/thumbnailimage");
			int result = 0;
			String file[] = new String[2];

			// 썸네일 유효성 체크
			if (filename != "") {
				StringTokenizer st = new StringTokenizer(filename, ".");
				file[0] = st.nextToken();
				file[1] = st.nextToken(); // 확장자

				// 사이즈가 1mb 이상인경우
				if (size > 1000000) {
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
			
			if (size > 0) { // 첨부 파일이 수정되면
				mf.transferTo(new File(path + "/" + filename));
				goods.setGds_thumbnail(filename);			
			} else { // 첨부파일이 수정되지 않으면
				goods.setGds_thumbnail(oldgoods.getGds_thumbnail());
			}
			
		}
		
		goodsService.update(goods);// 저장 메소드 호출
		
		// 배송템플릿을 새로 작성한 경우
		if(del_info != null) {
			
			String[] delinfoarr = del_info.split(",");
			for(int i=0; i<2; i++) {
				System.out.println(i+","+delinfoarr[i]);
			}
			deliverytemplate.setDel_code(Integer.parseInt(delinfoarr[0]));
			deliverytemplate.setDel_name(delinfoarr[1]);
			deliveryTemplateService.insert(deliverytemplate);  // 저장메소드 호출
		}
		return "redirect:/sellergoodslist?page="+page;
	} 
	
	// 상품 삭제하기
	@RequestMapping(value = "goodsdelete")
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
				 }
			 }
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
		     }
		}
		
		// 썸네일 이미지 삭제
		String thumbnailfilepath = request.getRealPath("resources/image/thumbnailimage/");
		String thumbnailfilename = goods.getGds_thumbnail();
		File thumbnailfile = new File(thumbnailfilepath+thumbnailfilename);
		System.out.println(thumbnailfile.exists());
		if(thumbnailfile.exists() == true){
			thumbnailfile.delete();
        }
		
		// DB 에서 goods데이터 삭제
		goodsService.deletegoods(gds_num);
		
		return "redirect:/sellergoodslist?page="+page;
	}

}

package com.myshop.cm.util;

public class Pager {

	private Integer curPage; // 현재 페이지 번호
	private Integer perPage; // 불러올 페이지 당 글 개수
	private Integer totalPage;

	// DB
	private Integer startRow; // 시작 rownum
	private Integer lastRow; // 마지막 rownum

	// View
	private Integer startNum; // 시작 페이지 번호
	private Integer lastNum; // 마지막 페이지 번호
	private Integer curBlock; // 현재 블럭 번호
	private Integer totalBlock; // 전체 블럭 개수

	// 분류가 대,중,소 중 어떤 것인지
	private String cate_kind;
	private int cate_code;

	public Integer getCurPage() {
		if (curPage == null || curPage == 0) {
			curPage = 1;
		}

		return curPage;
	}

	public void setCurPage(Integer curPage) {
		this.curPage = curPage;
	}

	public Integer getPerPage() {
		if (perPage == null || perPage == 0) {
			perPage = 3;
		}

		return perPage;
	}

	public void setPerPage(Integer perPage) {
		this.perPage = perPage;
	}

	public Integer getStartRow() {
		return startRow;
	}

	public void setStartRow(Integer startRow) {
		this.startRow = startRow;
	}

	public Integer getLastRow() {
		return lastRow;
	}

	public void setLastRow(Integer lastRow) {
		this.lastRow = lastRow;
	}

	public Integer getStartNum() {
		return startNum;
	}

	public void setStartNum(Integer startNum) {
		this.startNum = startNum;
	}

	public Integer getLastNum() {
		return lastNum;
	}

	public void setLastNum(Integer lastNum) {
		this.lastNum = lastNum;
	}

	public Integer getCurBlock() {
		return curBlock;
	}

	public void setCurBlock(Integer curBlock) {
		this.curBlock = curBlock;
	}

	public Integer getTotalBlock() {
		return totalBlock;
	}

	public void setTotalBlock(Integer totalBlock) {
		this.totalBlock = totalBlock;
	}

	public String getCate_kind() {
		return cate_kind;
	}

	public void setCate_kind(String cate_kind) {
		this.cate_kind = cate_kind;
	}

	public int getCate_code() {
		return cate_code;
	}

	public void setCate_code(int cate_code) {
		this.cate_code = cate_code;
	}

	// makeRow : rownum 시작 번호, 끝 번호 만들기
	public void makeRow() {
		// 시작 rownum = (현재 페이번호 -1)*불러올 페이지 개수 +1 (oracle)
		//this.startRow = (this.getCurPage() - 1) * this.getPerPage() + 1;
		// 단, mysql에서는 0번부터 시작하므로 +1 없어도 됨
		this.startRow = (this.getCurPage() - 1) * this.getPerPage();
		// 끝 rownum = 현재 페이지번호 * 불러올 페이지 개수 (oracle)
		// 단, mysql에서는 LIMIT()함수를 쓰므로 필요없음
		//this.lastRow = this.getCurPage() * this.getPerPage();
	}

	// makePage : 페이지 처리
	public void makePage(int totalCount) {
		// 1. 전체 글의 개수를 DB에서 매개변수로 받아옴 : totalCount

		// 2. 전체 페이지 개수 = 전체 글 개수 / 불러올 페이지 당 글 개수(3)
		totalPage = totalCount / this.getPerPage();
		// 전체글개수가 perPage보다 작으면(나머지가 0이 아닐 때)
		if (totalCount % this.getPerPage() != 0) {
			// 전체 페이지 개수 +1
			totalPage++;
		}

		// 3. totalBlock(전체 블록 개수)
		int perBlock = 5; //블록당 불러올 개수
		// 전체 페이지 개수 / 블록당 불러올 개수
		totalBlock = totalPage / perBlock;
		// 전체 페이지 개수가 perBlock보다 작으면(나머지가 0이 아닐 때)
		if (totalPage % perBlock != 0) {
			//전체 블록 개수 +1
			totalBlock++;
		}

		// 4. curPage로 curBlock 구하기
		// 현재 블록 = 현재 페이지 번호/ 블록당 개수(5)
		curBlock = this.getCurPage() / perBlock;
		// 현재 페이지 번호가 perBlock(5)보다 작으면(나머지가 0이 아닐 때)
		if (this.getCurPage() % perBlock != 0) {
			// 현재 블록 번호 +1
			curBlock++;
		}

		// 5. curBlock으로 startNum, lastNum 구하기
		// 시작 페이지 번호 = (현재 블록 번호 -1) * 블록당 불러올 개수(5) +1
		startNum = (curBlock - 1) * perBlock + 1;
		// 마지막 페이지 번호 = 현재 블록 번호 * 블럭당 불러올 개수(5)
		lastNum = curBlock * perBlock;
		
		// 현재 블록 번호 = 전체 블록 개수
		if (curBlock == totalBlock) {
			//마지막 페이지 번호 = 전체 페이지 개수
			lastNum = totalPage;
		}
	}

	public Integer getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}

}
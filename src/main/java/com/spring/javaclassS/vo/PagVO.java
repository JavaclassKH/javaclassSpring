package com.spring.javaclassS.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PagVO {

		private int pag;
		private int pageSize;
		private int totRecCnt;
		private int totPage;
		private int startIndexNo;
		private int curScrStartNo;
		private int blockSize;
		private int curBlock;
		private int lastBlock;
		
		private String search;
		private String searchString;
		private String part;
	
}

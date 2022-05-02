package com.tx.admin.homepage.authority.dto;

import org.apache.commons.lang3.StringUtils;

public class SecuredResource {

		private String 	USR_KEYNO
						, USR_PATTERN
						, USR_UIR_KEYNO
						, USR_MN_KEYNO
						, UIA_KEYNO;
		
		private Integer USR_ORDER= null;
		
		public SecuredResource(String _USR_KEYNO,String _UIA_KEYNO) {
			this.USR_KEYNO = _USR_KEYNO;
			this.UIA_KEYNO = _UIA_KEYNO;
		}
		
		public SecuredResource(String _USR_KEYNO, String _USR_PATTERN, int _USR_ORDER, String _USR_UIR_KEYNO,String _USR_MN_KEYNO) {
			// TODO Auto-generated constructor stub
			this.USR_KEYNO = _USR_KEYNO;
			this.USR_PATTERN = _USR_PATTERN;
			this.USR_ORDER = _USR_ORDER;
			this.USR_UIR_KEYNO = _USR_UIR_KEYNO;
			this.USR_MN_KEYNO = _USR_MN_KEYNO;
		}

		public String getUSR_KEYNO() {
			return USR_KEYNO;
		}

		public void setUSR_KEYNO(String uSR_KEYNO) {
			USR_KEYNO = uSR_KEYNO;
		}

		public String getUSR_PATTERN() {
			return USR_PATTERN;
		}

		public void setUSR_PATTERN(String uSR_PATTERN) {
			USR_PATTERN = uSR_PATTERN;
		}

		public Integer getUSR_ORDER() {
			return USR_ORDER;
		}

		public void setUSR_ORDER(Integer uSR_ORDER) {
			USR_ORDER = uSR_ORDER;
		}

		public String getUSR_UIR_KEYNO() {
			return USR_UIR_KEYNO;
		}

		public void setUSR_UIR_KEYNO(String uSR_UIR_KEYNO) {
			USR_UIR_KEYNO = uSR_UIR_KEYNO;
		}

		public String getUSR_MN_KEYNO() {
			return USR_MN_KEYNO;
		}

		public void setUSR_MN_KEYNO(String uSR_MN_KEYNO) {
			USR_MN_KEYNO = uSR_MN_KEYNO;
		}
		
		public String getUIA_KEYNO() {
			return UIA_KEYNO;
		}

		public void setUIA_KEYNO(String uIA_KEYNO) {
			UIA_KEYNO = uIA_KEYNO;
		}
}

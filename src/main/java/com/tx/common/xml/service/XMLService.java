package com.tx.common.xml.service;

import com.tx.common.file.dto.FileSub;

public interface XMLService {

	public void getXmlData(FileSub FileSub, String tableNM, String tagNM, int cnt) throws Exception;
}

package com.tx.admin.operation.qrcode.service;

import com.tx.admin.operation.qrcode.dto.QrCode;
import com.tx.common.file.dto.FileSub;

public interface QrCodeService{
	
	
	public  QrCode getQrCode(String url, int width, int height, String file_name);
	
	public FileSub getMenuQrCode(String url, int width, int height, String file_name);
}

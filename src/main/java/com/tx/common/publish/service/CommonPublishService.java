package com.tx.common.publish.service;

import com.tx.admin.board.dto.BoardMainMini;
import com.tx.admin.operation.popupzone.dto.PopupZoneCategoryDTO;

public interface CommonPublishService {
public boolean resource(String tiles, String homeDiv , String key) throws Exception;
	
	public boolean resource(String tiles, String homeDiv , String key, String resourceType) throws Exception;
	
	public boolean layout(String tiles, String homeDiv , String scope, boolean distributeType) throws Exception;
	
	public boolean page(String tiles, String homeDiv , String key) throws Exception;
	
	public boolean pagePreview(String tiles, String contents) throws Exception;
	
	public boolean boardMini(BoardMainMini BoardMainMini) throws Exception;
	
	public boolean popupZone(PopupZoneCategoryDTO CategoryDTO) throws Exception;
	
	public String getFileName(String type , String key, boolean isAddExt);
}

package com.tx.excel;

import java.io.IOException;
import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

public interface ExcelService {

	public ArrayList<ArrayList<String>> readFilter_And_Insert(MultipartFile file) throws IOException ;	
}

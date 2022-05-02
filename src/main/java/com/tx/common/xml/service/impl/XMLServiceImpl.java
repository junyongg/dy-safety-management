package com.tx.common.xml.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.tx.common.component.ComponentService;
import com.tx.common.file.dto.FileSub;
import com.tx.common.xml.service.XMLService;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.property.EgovPropertyService;

@Service("XMLService")
public class XMLServiceImpl extends EgovAbstractServiceImpl implements XMLService{
	
	/** 공통 컴포넌트 */
	@Autowired ComponentService Component;
	/** 프로퍼티 정보 */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
	public void getXmlData(FileSub FileSub, String tableNM, String tagNM, int cnt) throws Exception {
	    
		String filePath = propertiesService.getString("FilePath") + FileSub.getFS_FOLDER();
		String fileName = FileSub.getFS_CHANGENM() + "." + FileSub.getFS_EXT();
		//1.문서를 읽기위한 공장을 만들어야 한다.
        DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        //2.빌더 생성
        DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
        //3.생성된 빌더를 통해서 xml문서를 Document객체로 파싱해서 가져온다
	    Document doc = dBuilder.parse(filePath+fileName);
	    doc.getDocumentElement().normalize();//문서 구조 안정화
	     
	    Element root = doc.getDocumentElement();
	    
	    NodeList n_list = root.getElementsByTagName(tagNM);
	    Element el = null;
	    NodeList sub_n_list = null; 	//sub_n_list
	        Element sub_el = null; 		//sub_el
	        Node v_txt = null;
	        String value="";
	        Date date = new Date();
	        HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("table", tableNM);
			List<HashMap<String, Object>> Column = Component.getList("Menu.XML_getMenuColumn", map);
			
	      
	    if(n_list != null && n_list.getLength() > 0){
	    	for(int i=cnt; i<n_list.getLength(); i++) {
	    		el = (Element) n_list.item(i);
	    		if(Column != null && Column.size() > 0){
	    			HashMap<String, Object> wrapMap = new HashMap<String, Object>();
	    			List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
	    			
	    			for(HashMap<String,Object> column : Column){
	    				HashMap<String, Object> data = new HashMap<>();
	    				
	    				String tagName = column.get("Field").toString();
	    				sub_n_list = el.getElementsByTagName(tagName);
	    				
    					sub_el = (Element) sub_n_list.item(0);
						v_txt = sub_el.getFirstChild();
						boolean dayCk = false;
						
						if(v_txt != null && !v_txt.equals("")){
    						value = v_txt.getNodeValue();
    						if(tagName.equals("MN_REGDT") || tagName.equals("MN_MODDT") || tagName.equals("MN_DELDT")){
    							String  now  = v_txt.getNodeValue().toString(); 
    							date = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(now);
    							dayCk = true;
    						}
    					}else{
    						value = null;
    					}

						if(dayCk){
							data.put("value", date);
						}else{
							data.put("value", value);
						}
						
						data.put("column", tagName);
						list.add(data);
	    			}
	    			wrapMap.put("list", list);
	    			wrapMap.put("table", tableNM);
	    			Component.createData("Menu.XML_MenuRestore", wrapMap);
	    		}
	    		
	    	}
	    	
	    }
	    
	  }
}

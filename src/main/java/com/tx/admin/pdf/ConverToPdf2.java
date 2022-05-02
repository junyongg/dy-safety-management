package com.tx.admin.pdf;


import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.StringReader;
import java.net.URLEncoder;
import java.nio.charset.Charset;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.XMLWorker;
import com.itextpdf.tool.xml.XMLWorkerFontProvider;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import com.itextpdf.tool.xml.css.CssFile;
import com.itextpdf.tool.xml.css.StyleAttrCSSResolver;
import com.itextpdf.tool.xml.html.CssAppliers;
import com.itextpdf.tool.xml.html.CssAppliersImpl;
import com.itextpdf.tool.xml.html.Tags;
import com.itextpdf.tool.xml.parser.XMLParser;
import com.itextpdf.tool.xml.pipeline.css.CSSResolver;
import com.itextpdf.tool.xml.pipeline.css.CssResolverPipeline;
import com.itextpdf.tool.xml.pipeline.end.PdfWriterPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipelineContext;

import egovframework.rte.fdl.property.EgovPropertyService;
public class ConverToPdf2 {
	public void createPdf(String filename, String htmlStr, HttpServletRequest request,EgovPropertyService propertiesService ,HttpServletResponse response)
            throws DocumentException, IOException {
        
		String resourcePath = propertiesService.getString("resourcePath");
		
        //서버 내 파일 주소
        String path = propertiesService.getString("FilePath") + "pdf/";
        
        File saveFolder = new File(path);
        
        //경로가 없으면 생성한다.
        if (!saveFolder.exists() || saveFolder.isFile()) {
            saveFolder.mkdirs();
        }
        
        
		Document document = new Document(PageSize.A4, 50, 50, 50, 50); // 용지 및 여백 설정
		
		PdfWriter writer = PdfWriter.getInstance(document, response.getOutputStream());
		writer.setInitialLeading(12.5f);
		
		
		// 파일 다운로드 설정
		response.setContentType("application/pdf");
		filename = URLEncoder.encode(filename, "UTF-8"); // 파일명이 한글일 땐 인코딩 필요
		response.setHeader("Content-Transper-Encoding", "binary");
		response.setHeader("Content-Disposition", "inline; filename=" + filename + ".pdf");
        
        
		// Document 오픈
		document.open();
		XMLWorkerHelper helper = XMLWorkerHelper.getInstance();
        
		
		
        String realName = filename + ".pdf";
        File pdfFile = new File(realName);

        //파일이 있으면 삭제(같은 이름으로 만들 때마다 새로 쓰기 위해서)
            if (pdfFile.isFile()) {
                pdfFile.delete();
            }
        
            //css파일
            CSSResolver cssResolver = new StyleAttrCSSResolver();
            CssFile cssFile = XMLWorkerHelper.getCSS(new FileInputStream(resourcePath + "publish/jact/css/sub2.css"));
            CssFile cssFile2 = XMLWorkerHelper.getCSS(new FileInputStream(resourcePath + "publish/jact/css/common.css"));
            cssResolver.addCss(cssFile);
            cssResolver.addCss(cssFile2);
            
         // HTML, 폰트 설정
         XMLWorkerFontProvider fontProvider = new XMLWorkerFontProvider(XMLWorkerFontProvider.DONTLOOKFORFONTS);
         fontProvider.register(resourcePath +"smartadmin/js/plugin/datatables/malgun.ttf"); //MalgunGothic은 font-family용 alias
//         fontProvider.register(resourcePath +"smartadmin/js/plugin/datatables/ARIALUNI.TTF"); //MalgunGothic은 font-family용 alias
         // fontProvider.addFontSubstitute(resourcePath +"smartadmin/js/plugin/datatables/ARIALUNI.TTF", "A");

         CssAppliers cssAppliers = new CssAppliersImpl(fontProvider);
        
         HtmlPipelineContext htmlContext = new HtmlPipelineContext(cssAppliers);
         htmlContext.setTagFactory(Tags.getHtmlTagProcessorFactory());

        //이미지 태그 절대경로 사용해야 한다.(반드시)        
//        htmlStr = htmlStr.replaceAll("src=\"/", "src=\"http://127.0.0.1:8080/");
        //폰트를 설정한다. 폰트 설정 누락시 한글이 안보이는 경우 발생
//        htmlStr = "<html><body style='font-family: MalgunGothic;'>"+ htmlStr +"</body></html>";
        
     // Pipelines
        PdfWriterPipeline pdf = new PdfWriterPipeline(document, writer);
        HtmlPipeline html = new HtmlPipeline(htmlContext, pdf);
        CssResolverPipeline css = new CssResolverPipeline(cssResolver, html);
            
        XMLWorker worker = new XMLWorker(css, true);
        XMLParser xmlParser = new XMLParser(worker, Charset.forName("UTF-8"));
//        XMLParser xmlParser = new XMLParser(worker, Charset.forName("EUC-KR"));
        
     // 폰트 설정에서 별칭으로 줬던 "MalgunGothic"을 html 안에 폰트로 지정한다.
        htmlStr = "<html><head></head><body>"
                    + "<table><tr><td style='border: solid 1px black;'>PDF 안에 들어갈 내용입니다.</td></tr></table>"
                    + "<td style='border: solid 1px black;'>PDF 안에 들어갈 내용입니다.12</td>"
                    + "<a style='border: solid 1px black;'>PDF 안에 들어갈 내용입니다.12</a>"
                    + "<form><div style='border: solid 1px black;'>PDF 안에 들어갈 내용입니다.12</div></form>"
                    + "<span style='border: solid 1px black;'>PDF 안에 들어갈 내용입니다.12</span>"
                    + "<h3>한글, English, &#21495; ,漢字.</h3>"
                + "</body></html>";
         
        xmlParser.parse(new StringReader(htmlStr));
       
        
//        BaseFont SongTi = BaseFont.createFont(resourcePath +"smartadmin/js/plugin/datatables/ARIALUNI.TTF", BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
//        document.add(new Paragraph(htmlStr, new Font(SongTi)));
        
        document.close();
        writer.close();
        
       /* FileItem fileItem = new DiskFileItem("mainFile", Files.probeContentType(pdfFile.toPath()), false, pdfFile.getName(), (int) pdfFile.length(), pdfFile.getParentFile());

        try {
            InputStream input = new FileInputStream(pdfFile);
            OutputStream os = fileItem.getOutputStream();
            IOUtils.copy(input, os);
        } catch (IOException ex) {
            // do something.
        }

        MultipartFile multipartFile = new CommonsMultipartFile(fileItem);
        
        return multipartFile; */       
    }
}

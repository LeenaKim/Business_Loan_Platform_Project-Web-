package beone.doc.controller;

import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;

import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import beone.doc.service.DocService;
import beone.doc.vo.DocVO;

@Controller
public class DocController {

	@Autowired
	private DocService docService;
	
	@Autowired
	ServletContext servletContext;
	
	/**
	 * 서류보관함 뷰 띄우기 
	 * @return
	 */
	@RequestMapping("/corp/docUpload")
	public String viewDocUpload() {
		return "corp/doc/docUpload2";
	}
	
	/**
	 * 서류 클릭시 다운로드 
	 * @param docNo
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/corp/doc/{docNo}")
	public void downloadDoc(@PathVariable("docNo") int docNo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("downloadDoc 호출...");
		
		// 다운하려는 파일 정보 가져오기 
		DocVO doc = docService.selectOneDoc(docNo);
		System.out.println(doc);
		//===전달 받은 정보를 가지고 파일객체 생성(S)===//
        
        String f = doc.getDocSaveName(); //저장된 파일이름
        String of = doc.getDocOriName(); //원래 파일이름
        System.out.println("oriName1 : " + of);
//        of = new String(of.getBytes("ISO8859_1"), "UTF-8"); 
//        System.out.println("oriName2 : " + of);
        //서버설정(server.xml)에 따로 인코딩을 지정하지 않았기 때문에 get방식으로 받은 값에 대해 인코딩 변환
        
        
        StringBuffer sb = new StringBuffer();

        for (int i = 0; i < of.length(); i++) {
               char c = of.charAt(i);
               if (c > '~') {
                     sb.append(URLEncoder.encode("" + c, "UTF-8"));
               } else {
                     sb.append(c);
               }
        }

        String encodedFilename = sb.toString();


        //웹사이트 루트디렉토리의 실제 디스크상의 경로 알아내기.
        String path = servletContext.getRealPath("/docs") + "/" + doc.getDocType() + "/" + doc.getDocSaveName();
        //String path = request.getSession().getServletContext().getRealPath("upload");
        //String path = WebUtils.getRealPath(request.getServletContext(), "upload");        
        //String path = "D:\\upload\\";        
        System.out.println("path : " + path);
        
        File downloadFile = new File(path);
        System.out.println("file : " + downloadFile);
        //===전달 받은 정보를 가지고 파일객체 생성(E)===//
        
        
        //파일 다운로드를 위해 컨테츠 타입을 application/download 설정
        response.setContentType("application/download; charset=utf-8");
                
        //파일 사이즈 지정
        response.setContentLength((int)downloadFile.length());
        
        //다운로드 창을 띄우기 위한 헤더 조작
        response.setContentType("application/octet-stream; charset=utf-8");
        response.setHeader("Content-Disposition", "attachment;filename="
                                        + new String(encodedFilename.getBytes(), "ISO8859_1"));
        
        response.setHeader("Content-Transfer-Encoding","binary");
        /*
         * Content-disposition 속성
         * 1) "Content-disposition: attachment" 브라우저 인식 파일확장자를 포함하여 모든 확장자의 파일들에 대해
         *                          , 다운로드시 무조건 "파일 다운로드" 대화상자가 뜨도록 하는 헤더속성이다
         * 2) "Content-disposition: inline" 브라우저 인식 파일확장자를 가진 파일들에 대해서는 
         *                                  웹브라우저 상에서 바로 파일을 열고, 그외의 파일들에 대해서는 
         *                                  "파일 다운로드" 대화상자가 뜨도록 하는 헤더속성이다.
         */
        
        FileInputStream fin = new FileInputStream(downloadFile);
        ServletOutputStream sout = response.getOutputStream();

        byte[] buf = new byte[1024];
        int size = -1;

        while ((size = fin.read(buf, 0, buf.length)) != -1) {
            sout.write(buf, 0, size);
        }
        fin.close();
        sout.close();
	}
	
	/**
	 * 재무제표 양식 다운로드 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/corp/doc/finDownload")
	public void downloadFin(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
        String of = "표준재무상태표_양식.xlsx"; //원래 파일이름
        
        StringBuffer sb = new StringBuffer();

        for (int i = 0; i < of.length(); i++) {
               char c = of.charAt(i);
               if (c > '~') {
                     sb.append(URLEncoder.encode("" + c, "UTF-8"));
               } else {
                     sb.append(c);
               }
        }

        String encodedFilename = sb.toString();


        //웹사이트 루트디렉토리의 실제 디스크상의 경로 알아내기.
        String path = servletContext.getRealPath("/docs") + "/" + of;
        //String path = request.getSession().getServletContext().getRealPath("upload");
        //String path = WebUtils.getRealPath(request.getServletContext(), "upload");        
        //String path = "D:\\upload\\";        
        System.out.println("path : " + path);
        
        File downloadFile = new File(path);
        System.out.println("file : " + downloadFile);
        //===전달 받은 정보를 가지고 파일객체 생성(E)===//
        
        
        //파일 다운로드를 위해 컨테츠 타입을 application/download 설정
        response.setContentType("application/download; charset=utf-8");
                
        //파일 사이즈 지정
        response.setContentLength((int)downloadFile.length());
        
        //다운로드 창을 띄우기 위한 헤더 조작
        response.setContentType("application/octet-stream; charset=utf-8");
        response.setHeader("Content-Disposition", "attachment;filename="
                                        + new String(encodedFilename.getBytes(), "ISO8859_1"));
        
        response.setHeader("Content-Transfer-Encoding","binary");
        /*
         * Content-disposition 속성
         * 1) "Content-disposition: attachment" 브라우저 인식 파일확장자를 포함하여 모든 확장자의 파일들에 대해
         *                          , 다운로드시 무조건 "파일 다운로드" 대화상자가 뜨도록 하는 헤더속성이다
         * 2) "Content-disposition: inline" 브라우저 인식 파일확장자를 가진 파일들에 대해서는 
         *                                  웹브라우저 상에서 바로 파일을 열고, 그외의 파일들에 대해서는 
         *                                  "파일 다운로드" 대화상자가 뜨도록 하는 헤더속성이다.
         */
        
        FileInputStream fin = new FileInputStream(downloadFile);
        ServletOutputStream sout = response.getOutputStream();

        byte[] buf = new byte[1024];
        int size = -1;

        while ((size = fin.read(buf, 0, buf.length)) != -1) {
            sout.write(buf, 0, size);
        }
        fin.close();
        sout.close();
	}
}

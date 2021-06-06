import java.util.List;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import beone.corp.vo.CorpVO;
import beone.doc.dao.DocDAO;
import beone.doc.vo.DocVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:config/spring/spring-mvc.xml"})
public class docTest {
	
	@Autowired
	private DocDAO docDAO;

	
	@Ignore
	@Test
	public void 서류조회테스트() {
		CorpVO corp = new CorpVO();
		corp.setBizrNo("1111");
		List<DocVO> list = docDAO.selectAll(corp);
		for(DocVO doc : list) {
			System.out.println(doc);
		}
	}
	
	@Test
	public void 신청서류조회테스트() {
		int[] docNo = {18, 19};
		List<DocVO> docList = docDAO.selectByDocNoArr(docNo);
		for(DocVO doc : docList) {
			System.out.println(doc);
		}
	}
}

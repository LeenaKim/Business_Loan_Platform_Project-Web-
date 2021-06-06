import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import beone.corp.dao.CorpDAO;
import beone.corp.vo.CorpVO;
import beone.rep.dao.RepDAO;
import beone.rep.vo.RepVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:config/spring/spring-mvc.xml"})
public class corpTest {

	@Autowired
	private CorpDAO corpDAO;
	
	@Autowired
	private RepDAO repDAO;
	
	@Ignore
	@Test
	public void 로그인테스트() {
		CorpVO corp = new CorpVO();
		corp.setBizrNo("1111");
		corp.setPw("1111");
		
		CorpVO userVO = corpDAO.login(corp);
		
		assertNotNull(userVO);
	}
	
	@Test
	public void 대표테스트() throws Exception {
		CorpVO corp = new CorpVO();
		corp.setBizrNo("1111");
		List<RepVO> list = repDAO.selectAll(corp);
		
		for(RepVO rep : list) {
			System.out.println(rep);
		}
	}
}

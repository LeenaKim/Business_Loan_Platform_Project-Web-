import static org.junit.Assert.assertNotNull;

import java.util.List;

import javax.sql.DataSource;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import beone.loanProd.vo.LoanProdVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:config/spring/spring-mvc.xml"})
public class loanProdTest {

	@Autowired
	private DataSource ds;
	
	@Autowired
	private SqlSessionTemplate session;
	
	@Ignore
	@Test
	public void ds테스트() throws Exception {
		// ds가 널이 아니면 성공 
		assertNotNull(ds);
		// ds가 널이면 성공
//		assertNull(ds);
	}
	
	@Ignore
	@Test
	public void sqlSession테스트() throws Exception {
		assertNotNull(session);
	}
	
	@Test
	public void 전체대출상품조회테스트() throws Exception {
		List<LoanProdVO> list = session.selectList("loanProd.dao.loanProdDAO.selectAll");
		System.out.println(list);
		for(LoanProdVO prod : list) {
			System.out.println(prod);
		}
	}
}

import java.util.List;

import javax.sql.DataSource;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import beone.loanApp.dao.LoanAppDAO;
import beone.loanApp.vo.LoanAppVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:config/spring/spring-mvc.xml"})
public class loanAppTest {

	@Autowired
	private DataSource ds;
	
	@Autowired
	private SqlSessionTemplate session;
	
	@Autowired
	private LoanAppDAO loanAppDAO;
	
	@Ignore
	@Test
	public void 대출신청테스트() {
	
		LoanAppVO loanApp = new LoanAppVO();
		loanApp.setLoanType("W");
		loanApp.setBranchNm("서울");
		loanApp.setAppAmount(10000);
		loanApp.setAppYear(1);
		loanApp.setProdNo("1");
		loanApp.setBizrNo("1111");
		
		loanAppDAO.insertLoanApp(loanApp);
	}
	
	@Test
	public void 대출신청조회테스트() {
		List<LoanAppVO> list = loanAppDAO.selectAllLoanApp("1111");
		for(LoanAppVO la : list) {
			System.out.println(la);
		}
	}
}

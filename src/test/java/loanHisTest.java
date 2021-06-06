import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import beone.loanHistory.dao.LoanHistoryDAO;
import beone.loanHistory.vo.LoanHistoryVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:config/spring/spring-mvc.xml"})
public class loanHisTest {

	@Autowired
	private LoanHistoryDAO loanHistoryDAO;
	
	@Test
	public void 대출내역조회테스트() {
		List<LoanHistoryVO> list = loanHistoryDAO.selectAllLoanHistory("1111");
		for(LoanHistoryVO lh : list) {
			System.out.println(lh);
		}
	}
}

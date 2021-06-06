package beone.emp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import beone.emp.dao.EmpDAO;
import beone.emp.vo.EmpVO;

@Service
public class EmpServiceImpl implements EmpService {

	@Autowired
	private EmpDAO empDAO;
	
	@Override
	public EmpVO login(EmpVO emp) {
		EmpVO empVO = empDAO.login(emp);
		return empVO;
	}

	@Override
	public List<EmpVO> loanAppCntByEmp(EmpVO emp) {
		List<EmpVO> empList = empDAO.loanAppCntByEmp(emp);
		return empList;
	}

	
}

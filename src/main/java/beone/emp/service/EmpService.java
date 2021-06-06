package beone.emp.service;

import java.util.List;

import beone.emp.vo.EmpVO;

public interface EmpService {

	EmpVO login(EmpVO emp);
	
	List<EmpVO> loanAppCntByEmp(EmpVO emp);
}

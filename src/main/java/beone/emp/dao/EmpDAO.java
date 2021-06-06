package beone.emp.dao;

import java.util.List;

import beone.emp.vo.EmpVO;

public interface EmpDAO {

	EmpVO login(EmpVO emp);
	
	List<EmpVO> loanAppCntByEmp(EmpVO emp);
	
}

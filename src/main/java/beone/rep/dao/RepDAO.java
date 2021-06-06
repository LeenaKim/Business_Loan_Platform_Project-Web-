package beone.rep.dao;

import java.util.List;

import beone.corp.vo.CorpVO;
import beone.rep.vo.RepVO;

public interface RepDAO {

	List<RepVO> selectAll(CorpVO corp);
}

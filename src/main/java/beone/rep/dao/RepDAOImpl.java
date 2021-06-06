package beone.rep.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import beone.corp.vo.CorpVO;
import beone.rep.vo.RepVO;

@Repository
public class RepDAOImpl implements RepDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<RepVO> selectAll(CorpVO corp) {
		List<RepVO> list = sqlSession.selectList("rep.dao.RepDAO.selectAll", corp);
		return list;
	}

}

package com.roadscanner.user.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.roadscanner.domain.MemberVO;



@Repository("userDao")
public class UserDaoImpl implements UserDao {
	final String NAMESPACE = "mapper.Member";
	final String DOT = ".";

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	private final static Logger LOG = LogManager.getLogger(UserDaoImpl.class);

	// default 생성
	public UserDaoImpl() {
	}

	@Override
	public MemberVO selectOne(MemberVO inVO) throws SQLException {
		String statement = this.NAMESPACE + ".selectOne";
		LOG.debug("┌────────────────────────────────────────────────────────┐");
		LOG.debug("│ statement " + statement);
		LOG.debug("└────────────────────────────────────────────────────────┘");
		MemberVO outVO = this.sqlSessionTemplate.selectOne(statement, inVO);

		if (outVO != null) {
			System.out.println(outVO.toString());
		} else {
			System.out.println("쿼리 결과가 없습니다.");
		}
		return outVO;
	}

	@Override
	public int idCheck(MemberVO user) throws SQLException {
		int flag = 0;
		String statement = this.NAMESPACE + DOT + "idCheck";
		LOG.debug("┌────────────────────────────────────────────────────────┐");
		LOG.debug("│ 1. statement " + statement);
		LOG.debug("│ 2. param=\n" + user.toString());
		LOG.debug("└────────────────────────────────────────────────────────┘");
		flag = this.sqlSessionTemplate.selectOne(statement, user);

		return flag;
	}
	
	@Override
	public int emailCheck(MemberVO user) throws SQLException {
		int flag = 0;
		String statement = this.NAMESPACE + DOT + "emailCheck";
		LOG.debug("┌────────────────────────────────────────────────────────┐");
		LOG.debug("│ 1. statement " + statement);
		LOG.debug("│ 2. param=\n" + user.toString());
		LOG.debug("└────────────────────────────────────────────────────────┘");
		flag = this.sqlSessionTemplate.selectOne(statement, user);

		return flag;
	}
	
	@Override
	public int passCheck(MemberVO user) throws SQLException {
		int flag = 0;
		String statement = this.NAMESPACE + DOT + "passCheck";
		LOG.debug("┌────────────────────────────────────────────────────────┐");
		LOG.debug("│ 1. statement " + statement);
		LOG.debug("│ 2. param=\n" + user.toString());
		LOG.debug("└────────────────────────────────────────────────────────┘");
		flag = this.sqlSessionTemplate.selectOne(statement, user);

		return flag;
	}

	@Override
	public int addUser(MemberVO user) throws SQLException {
		System.out.println("============================================");
		System.out.println("MembershipDaoImpl addUser()");
		System.out.println("============================================");
		
		int flag = 0;
		String statement = this.NAMESPACE + DOT + "insertOne";
		LOG.debug("┌────────────────────────────────────────────────────────┐");
		LOG.debug("│ 1. statement " + statement);
		LOG.debug("│ 2. param=\n" + user.toString());
		LOG.debug("└────────────────────────────────────────────────────────┘");
		flag = this.sqlSessionTemplate.insert(statement, user);

		return flag;
	}

	@Override
	public int deleteOne(MemberVO user) throws SQLException {
		int flag = 0;
		String statement = this.NAMESPACE + DOT + "deleteOne";
		LOG.debug("┌────────────────────────────────────────────────────────┐");
		LOG.debug("│ statement " + statement);
		LOG.debug("└────────────────────────────────────────────────────────┘");
		flag = this.sqlSessionTemplate.delete(statement, user);

		return flag;
	}

	@Override
	public MemberVO searchId(MemberVO user) throws SQLException {
		String statement = this.NAMESPACE + DOT + "searchId";
		LOG.debug("┌────────────────────────────────────────────────────────┐");
		LOG.debug("│ statement " + statement);
		LOG.debug("└────────────────────────────────────────────────────────┘");
		MemberVO outVO = this.sqlSessionTemplate.selectOne(statement, user);

		return outVO;
	}

	@Override
	public int searchIdCheck(MemberVO user) throws SQLException {
		int flag = 0;
		String statement = this.NAMESPACE + DOT + "searchIdCheck";
		LOG.debug("┌────────────────────────────────────────────────────────┐");
		LOG.debug("│ statement " + statement);
		LOG.debug("└────────────────────────────────────────────────────────┘");
		flag = this.sqlSessionTemplate.selectOne(statement, user);

		return flag;
	}

	@Override
	public int searchPwCheck(MemberVO user) throws SQLException {
		int flag = 0;
		String statement = this.NAMESPACE + DOT + "searchPwCheck";
		LOG.debug("┌────────────────────────────────────────────────────────┐");
		LOG.debug("│ statement " + statement);
		LOG.debug("└────────────────────────────────────────────────────────┘");
		flag = this.sqlSessionTemplate.selectOne(statement, user);

		return flag;
	}
	
	@Override
	public MemberVO searchPw(MemberVO user) throws SQLException {
		String statement = this.NAMESPACE + DOT + "searchPw";
		LOG.debug("┌────────────────────────────────────────────────────────┐");
		LOG.debug("│ statement " + statement);
		LOG.debug("└────────────────────────────────────────────────────────┘");
		MemberVO outVO = this.sqlSessionTemplate.selectOne(statement, user);

		return outVO;
	}

	@Override
	public int updatePw(MemberVO user) throws SQLException {
		int flag = 0;
		String statement = this.NAMESPACE + DOT + "updatePw";
		LOG.debug("┌────────────────────────────────────────────────────────┐");
		LOG.debug("│ statement " + statement);
		LOG.debug("└────────────────────────────────────────────────────────┘");
		flag = this.sqlSessionTemplate.update(statement, user);

		return flag;
	}

	@Override
	public int updateUser(MemberVO user) throws SQLException {
		int flag = 0;
		String statement = this.NAMESPACE + DOT + "updateUser";
		LOG.debug("┌────────────────────────────────────────────────────────┐");
		LOG.debug("│ statement " + statement);
		LOG.debug("└────────────────────────────────────────────────────────┘");
		flag = this.sqlSessionTemplate.update(statement, user);
		LOG.debug("flag: " + flag);

		return flag;
	}

	@Override
	public MemberVO selectOneMypage(MemberVO inVO) throws SQLException {
		String statement = this.NAMESPACE + ".selectOneMypage";
		LOG.debug("┌────────────────────────────────────────────────────────┐");
		LOG.debug("│ statement " + statement);
		LOG.debug("└────────────────────────────────────────────────────────┘");
		MemberVO outVO = this.sqlSessionTemplate.selectOne(statement, inVO);

		if (outVO != null) {
			System.out.println(outVO.toString());
		} else {
			System.out.println("쿼리 결과가 없습니다.");
		}
		return outVO;
	}

	@Override
	public int withdraw(MemberVO user) throws SQLException {
	    int flag = 0;
	    String statement = this.NAMESPACE + DOT + "withdraw";
	    LOG.debug("┌────────────────────────────────────────────────────────┐");
	    LOG.debug("│ statement " + statement);
	    LOG.debug("│ param=\n" + user.toString());
	    LOG.debug("└────────────────────────────────────────────────────────┘");
	    flag = this.sqlSessionTemplate.delete(statement, user);

	    return flag;
	}

	// -------------로그인 관리자페이지------------------------
	@Override
	public List<MemberVO> getAllMembers() {
		return null;
	}
	
}
package com.roadscanner.service.user;

import java.sql.SQLException;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.roadscanner.dao.user.UserDao;
import com.roadscanner.dao.user.UserDaoImpl;
import com.roadscanner.domain.MemberVO;


@Service("userService")
public class UserServiceImpl implements UserService {
	final Logger LOG = LogManager.getLogger(getClass());
	
	@Autowired
	private UserDao userDao;
	

	
	@Override
	public MemberVO selectUser(MemberVO user) throws SQLException {
		LOG.debug("┌────────────────────────────────────────────────────────┐");
		LOG.debug("│ selectUser()                                           │");
		LOG.debug("└────────────────────────────────────────────────────────┘");
		return userDao.selectOne(user);
	}
	
	@Override
	public int register(MemberVO user) throws SQLException {
		System.out.println("============================================");
		System.out.println("MembershipServiceImpl register()");
		System.out.println("============================================");
			
		
		int idCheck = this.userDao.idCheck(user);
		int emailCheck = this.userDao.emailCheck(user);
		int flag = this.userDao.addUser(user);
		
		System.out.println("MembershipServiceImpl idCheck : "+idCheck);
		System.out.println("MembershipServiceImpl emailCheck : "+emailCheck);
		System.out.println("MembershipServiceImpl flag : "+flag);
		
		// 10 : 가입 성공 / 20 : 가입 실패
		if(1 != idCheck) {
			flag = 10;
		} else {
			flag = 20;
		}
		
		return flag;
	}
	
	
	
	@Override
	public int doIdDuplCheck(MemberVO user) throws SQLException {
		System.out.println("┌────────────────────────────────────────────────────────┐");
		System.out.println("│ doIdDuplCheck()                                        │");
		System.out.println("└────────────────────────────────────────────────────────┘");
		
		int result = 0;
		int flag = 0;
		
		flag = this.userDao.idCheck(user);
		
		if(1 == flag) {
			result = 10;
		} else if (0 == flag) {
			result = 20;
		} 
		return result;
	}
	
	@Override
	public int doPwCheck(MemberVO user) throws SQLException {
		System.out.println("┌────────────────────────────────────────────────────────┐");
		System.out.println("│ doPwCheck()                                        │");
		System.out.println("└────────────────────────────────────────────────────────┘");
		
		int result = 0;
		int flag = 0;
		
		flag = this.userDao.searchPwCheck(user);
		
		if(1 == flag) {
			result = 10;
		} else if (0 == flag) {
			result = 20;
		} 
		return result;
	}
	
	@Override
	public int doEmailDuplCheck(MemberVO user) throws SQLException {
		LOG.debug("┌────────────────────────────────────────────────────────┐");
		LOG.debug("│ doEmailDuplCheck()                                     │");
		LOG.debug("└────────────────────────────────────────────────────────┘");
		
		int result = 0;
		int flag = 0;
		
		flag = this.userDao.emailCheck(user);
		
		if(1 == flag) {
			result = 10;
		} else if (0 == flag) {
			result = 20;
		} 
		return result;
	}
	
	@Override
	public int deleteOne(MemberVO user) throws SQLException {
		LOG.debug("┌────────────────────────────────────────────────────────┐");
		LOG.debug("│ deleteOne()                                            │");
		LOG.debug("└────────────────────────────────────────────────────────┘");
		return userDao.deleteOne(user);
	}

	@Override
	public int doLogin(MemberVO user) throws SQLException {
		LOG.debug("┌────────────────────────────────────────────────────────┐");
		LOG.debug("│ doLogin()                                              │");
		LOG.debug("└────────────────────────────────────────────────────────┘");
		int checkStatus = 0; 		// 10(id 없음)/20(비밀번호 오류),30(성공) 
		int status = this.userDao.idCheck(user);
		int grade = this.userDao.gradeCheck(user).getGrade();
		
		if(1==status) {
			if(1 == grade || 2 == grade) {
				status = userDao.passCheck(user);
				if(1==status) {
					checkStatus = 30; 	// 로그인 성공 
				}else {
					checkStatus = 20; 	// 비밀번호 오류
				}				
			} else {
				checkStatus = 40;
			}
			
		} else {
			checkStatus = 10; 		// id없음
		}
		
		LOG.debug("┌────────────────────────────────────────────────────────┐");
		LOG.debug("│ checkStatus : "+ checkStatus);
		LOG.debug("└────────────────────────────────────────────────────────┘");
		
		return checkStatus;
	}

	@Override
	public String doSearchId(MemberVO user) throws SQLException {
		LOG.debug("┌────────────────────────────────────────────────────────┐");
		LOG.debug("│ doSearchId()                                           │");
		LOG.debug("└────────────────────────────────────────────────────────┘");
        String result = "-1";
        
		int flag =0;
		flag = this.userDao.searchIdCheck(user);
		
        if(0==flag) {
            result = "-1";
        }else if(1==flag) {
            result = this.userDao.searchId(user).getId(); 
        } 
        return result;
	}
	
	@Override
    public String doSearchPw(MemberVO user) throws SQLException {//10(id 없음)/20(비밀번호 수정 오류),30(비밀번호 수정 성공) 
		LOG.debug("┌────────────────────────────────────────────────────────┐");
		LOG.debug("│ doSearchPw()                                           │");
		LOG.debug("└────────────────────────────────────────────────────────┘");
		String pwresult = "-1";
		
		int checkStatus = 0;
        checkStatus = this.userDao.searchPwCheck(user);
        
        if(0==checkStatus) {
        	pwresult = "-1";
        } else if(1==checkStatus) {
        	pwresult = this.userDao.searchPw(user).getPassword(); 
        } 
        return pwresult;
    }

	@Override
	public int doChangeInfo(MemberVO user) throws SQLException {
		int checkStatus = -1;
		
        checkStatus = this.userDao.updatePw(user);
        if(0==checkStatus) {
            checkStatus = -1; // 회원정보가 변경되지 않음
        } 
        LOG.debug("checkStatus: " + checkStatus);
        return checkStatus;
	}
	
	@Override
	public MemberVO selectOneMypage(MemberVO user) throws SQLException {
		LOG.debug("┌────────────────────────────────────────────────────────┐");
		LOG.debug("│ selectOneMypage()                                           │");
		LOG.debug("└────────────────────────────────────────────────────────┘");
		return userDao.selectOneMypage(user);
	}

	@Override
	public int doWithdraw(MemberVO user) {
	    int checkStatus = 0;
	    try {
	        checkStatus = this.userDao.withdraw(user);
	    } catch (SQLException e) {
	        LOG.error("Error occurred while withdrawing user: " + e.getMessage());
	    }
	    return checkStatus;
	}

	// -------------로그인 관리자페이지------------------------
	@Override
	public List<MemberVO> getAllMembers() {
		// 데이터베이스에서 모든 회원 목록을 가져오는 로직을 구현
		return userDao.getAllMembers(); // 예시로 userDao.getAllMembers() 메서드를 호출하는 것으로 가정
	}

	@Override
	public int forbiddenGrade(MemberVO user) throws SQLException {
		int checkGrade = -1;
		
        checkGrade = this.userDao.forbiddenGrade(user);
        if(0==checkGrade) {
            checkGrade = -1; // 회원정보가 변경되지 않음
        } 
        LOG.debug("checkGrade: " + checkGrade);
        return checkGrade;
	}

	@Override
	public int clearGrade(MemberVO user) throws SQLException {
		int checkGrade = -1;
		
        checkGrade = this.userDao.clearGrade(user);
        if(0==checkGrade) {
            checkGrade = -1; // 회원정보가 변경되지 않음
        } 
        LOG.debug("checkGrade: " + checkGrade);
        return checkGrade;
	}
	
}

package mainApp.service;

import mainApp.entity.Question;
import mainApp.entity.User;
import mainApp.user.CrmUser;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.List;

public interface UserService extends UserDetailsService {
    User findByUserName(String userName);
    void save(CrmUser crmUser);
    List<Long> findAnsweredQuestionsIds(long userId);
    void addAnsweredQuestion(long userId, long questionId);
}

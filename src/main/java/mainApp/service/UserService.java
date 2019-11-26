package mainApp.service;

import mainApp.entity.User;
import mainApp.user.CrmUser;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.List;

public interface UserService extends UserDetailsService {
    User findByUserName(String userName);
    void save(CrmUser crmUser);

    List<Long> findAnsweredQuestionsIds(Long userId);
    void addAnsweredQuestion(Long userId, Long questionId);

    List<User>getNewUsers();

    void confirmUser(Long id);

    void blockUser(Long id);

    void confirmAll();

    void blockAll();
}

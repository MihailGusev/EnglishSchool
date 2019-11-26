package mainApp.dao;

import mainApp.entity.Question;
import mainApp.entity.User;

import java.util.List;

public interface UserDao {

    User findByUserName(String userName);

    void save(User user);

    List<Long> findAnsweredQuestionsIds(Long userId);

    void addAnsweredQuestion(Long userId, Long questionId);

    List<User> getNewUsers();

    void confirmUser(Long id);

    void blockUser(Long id);

    void confirmAll();

    void blockAll();
}

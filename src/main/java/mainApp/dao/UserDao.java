package mainApp.dao;

import mainApp.entity.Question;
import mainApp.entity.User;

import java.util.List;

public interface UserDao {

    User findByUserName(String userName);

    void save(User user);

    List<Long> findAnsweredQuestionsIds(long userId);

    void addAnsweredQuestion(long userId, long questionId);
}

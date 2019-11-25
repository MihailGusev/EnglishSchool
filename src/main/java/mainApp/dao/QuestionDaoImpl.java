package mainApp.dao;

import mainApp.entity.Question;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class QuestionDaoImpl implements QuestionDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void deleteQuestion(Long id) {
        Session session = sessionFactory.getCurrentSession();
        Question question = session.get(Question.class,id);
        session.delete(question);
    }

    @Override
    public void editQuestion(Long id,String english, String russian) {
        Session session = sessionFactory.getCurrentSession();
        Question question = session.get(Question.class,id);
        question.setEnglish(english);
        question.setRussian(russian);
        session.update(question);
    }

    @Override
    public void addQuestion(Long workshopId, String english, String russian) {
        Session session = sessionFactory.getCurrentSession();
        Question question = new Question(workshopId, english, russian);
        session.saveOrUpdate(question);
    }
}

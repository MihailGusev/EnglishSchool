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
}

package mainApp.dao;

import mainApp.entity.Question;
import mainApp.entity.User;
import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;


@Repository
public class UserDaoImpl implements UserDao {

    //need to inject the session factory
    @Autowired
    private SessionFactory sessionFactory;


    @Override
    public User findByUserName(String theUserName) {
        // get the current hibernate session
        Session currentSession = sessionFactory.getCurrentSession();

        // now retrieve/read from database using username
        Query<User> theQuery = currentSession.createQuery("from User where userName=:uName", User.class);
        theQuery.setParameter("uName", theUserName);
        User theUser = null;
        try {
            theUser = theQuery.getSingleResult();
        } catch (Exception e) {
            theUser = null;
        }

        return theUser;
    }

    @Override
    public void save(User user) {
        //get current hibernate session
        Session session = sessionFactory.getCurrentSession();

        //create the user
        session.saveOrUpdate(user);
    }

    @Override
    public List<Long> findAnsweredQuestionsIds(Long userId) {
        Session session = sessionFactory.getCurrentSession();
        User user = session.get(User.class,userId);
        Hibernate.initialize(user.getQuestions());
        List<Question>questions=user.getQuestions();
        List<Long>ids=new ArrayList<>();
        for (Question q : questions)
            ids.add(q.getId());
        return ids;
    }

    @Override
    public void addAnsweredQuestion(Long userId, Long questionId) {
        Session session = sessionFactory.getCurrentSession();
        User user = session.get(User.class,userId);
        Question question=session.get(Question.class,questionId);
        question.addUser(user);
        session.saveOrUpdate(question);
    }
}

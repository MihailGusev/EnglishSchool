package mainApp.dao;

import mainApp.entity.Question;
import mainApp.entity.Role;
import mainApp.entity.User;
import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.Collection;
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

    @Override
    public List<User> getNewUsers() {
        Session session = sessionFactory.getCurrentSession();
        Query<User>query = session.createQuery("from User");
        List<User> users=query.getResultList();
        List<User> newUsers= new ArrayList<>();
        for (User user:users){
            Collection<Role> roles=user.getRoles();
            for (Role role:roles)
                if(role.getName().equals("ROLE_NEW")){
                    newUsers.add(user);
                    break;
                }
        }
        return newUsers;
    }

    @Override
    public void confirmUser(Long id) {
        Session session = sessionFactory.getCurrentSession();
        User user = session.get(User.class,id);
        Role role = session.get(Role.class, 2L);
        Collection<Role>roles=new ArrayList<>();
        roles.add(role);
        user.setRoles(roles);
        session.save(user);
    }

    @Override
    public void blockUser(Long id) {
        Session session = sessionFactory.getCurrentSession();
        User user = session.get(User.class,id);
        session.delete(user);
    }

    @Override
    public void confirmAll() {
        Session session = sessionFactory.getCurrentSession();
        Role role = session.get(Role.class, 2L);
        Collection<Role>roles=new ArrayList<>();
        roles.add(role);
        Query query=session.createQuery("SELECT u FROM User u JOIN u.roles r WHERE r.id=:idRole");
        query.setParameter("idRole",1l);
        List<User>users=query.getResultList();
        for (User user:users)
            user.setRoles(roles);
    }

    @Override
    public void blockAll() {
        Session session = sessionFactory.getCurrentSession();
        Query query=session.createQuery("SELECT u FROM User u JOIN u.roles r WHERE r.id=:idRole");
        query.setParameter("idRole",1l);
        List<User>users=query.getResultList();
        for (User user:users)
            session.delete(user);
    }
}

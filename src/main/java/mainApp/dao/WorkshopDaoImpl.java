package mainApp.dao;

import mainApp.entity.Question;
import mainApp.entity.Workshop;
import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class WorkshopDaoImpl implements WorkshopDao {

    @Autowired
    SessionFactory sessionFactory;

    @Override
    public Workshop getWorkshop(int id) {
        Session session = sessionFactory.getCurrentSession();
        return session.get(Workshop.class,id);
    }

    @Override
    public List<Workshop> getWorkshops() {
        Session session = sessionFactory.getCurrentSession();
        Query<Workshop> query = session.createQuery("from Workshop",Workshop.class);
        return query.getResultList();
    }

    @Override
    public List<Question> getQuestions(int workshopId) {
        Session session = sessionFactory.getCurrentSession();
        Workshop workshop = session.get(Workshop.class,workshopId);
        Hibernate.initialize(workshop.getQuestions());
        return workshop.getQuestions();
    }

    @Override
    public List<Workshop> deleteWorkshop(int workshopId) {
        Session session = sessionFactory.getCurrentSession();
        Workshop workshop = session.get(Workshop.class,workshopId);
        session.delete(workshop);
        Query<Workshop> query = session.createQuery("from Workshop", Workshop.class);
        return query.getResultList();
    }
}

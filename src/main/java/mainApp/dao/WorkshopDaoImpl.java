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
    public Workshop getWorkshop(Long id) {
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
    public List<Question> getQuestions(Long workshopId) {
        Session session = sessionFactory.getCurrentSession();
        Workshop workshop = session.get(Workshop.class,workshopId);
        Hibernate.initialize(workshop.getQuestions());
        return workshop.getQuestions();
    }

    @Override
    public void deleteWorkshop(Long workshopId) {
        Session session = sessionFactory.getCurrentSession();
        Workshop workshop = session.get(Workshop.class,workshopId);
        session.delete(workshop);
    }

    @Override
    public void editWorkshop(Long workshopId, String explanations) {
        Session session = sessionFactory.getCurrentSession();
        Workshop workshop = session.get(Workshop.class,workshopId);
        workshop.setExplanations(explanations);
        session.update(workshop);
    }

    @Override
    public void addWorkshop(String explanations) {
        Session session = sessionFactory.getCurrentSession();
        session.save(new Workshop(explanations));
    }
}

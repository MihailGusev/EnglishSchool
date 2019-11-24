package mainApp.dao;

import mainApp.entity.Role;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RoleDaoImpl implements RoleDao{

    //need to inject session factory
    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public Role findRoleByName(String roleName) {
        //get current session
        Session session = sessionFactory.getCurrentSession();

        //retrieve from database
        Query<Role> query = session.createQuery("from Role where name=:ourName",Role.class);
        query.setParameter("ourName",roleName);

        Role role=null;
        try{
            role=query.getSingleResult();
        }
        catch (Exception e){
            role=null;
        }
        return role;
    }
}

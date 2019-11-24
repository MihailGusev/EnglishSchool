package mainApp.service;

import mainApp.dao.WorkshopDao;
import mainApp.entity.Question;
import mainApp.entity.Workshop;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class WorkshopServiceImpl implements WorkshopService {

    @Autowired
    WorkshopDao workshopDao;

    @Override
    @Transactional
    public Workshop getWorkshop(int id) {
        return workshopDao.getWorkshop(id);
    }

    @Override
    @Transactional
    public List<Workshop> getWorkshops() {
        return workshopDao.getWorkshops();
    }

    @Override
    @Transactional
    public List<Question> getQuestions(int workshopId) {
        return workshopDao.getQuestions(workshopId);
    }

    @Override
    @Transactional
    public List<Workshop> deleteWorkshop(int workshopId) {
        return workshopDao.deleteWorkshop(workshopId);
    }
}

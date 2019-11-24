package mainApp.dao;

import mainApp.entity.Question;
import mainApp.entity.Workshop;

import java.util.List;

public interface WorkshopDao {
    Workshop getWorkshop(int id);
    List<Workshop> getWorkshops();
    List<Question> getQuestions(int workshopId);
    List<Workshop> deleteWorkshop(int workshopId);
}

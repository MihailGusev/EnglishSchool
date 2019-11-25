package mainApp.dao;

import mainApp.entity.Question;
import mainApp.entity.Workshop;

import java.util.List;

public interface WorkshopDao {
    Workshop getWorkshop(Long id);
    List<Workshop> getWorkshops();
    List<Question> getQuestions(Long workshopId);
    void deleteWorkshop(Long workshopId);

    void editWorkshop(Long workshopId, String explanations);

    void addWorkshop(String explanations);
}

package mainApp.service;

public interface QuestionService {
    void deleteQuestion(Long id);
    void editQuestion(Long id,String english, String russian);
    void addQuestion(Long workshopId, String english, String russian);
}

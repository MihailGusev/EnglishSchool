package mainApp.service;

import mainApp.dao.QuestionDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class QuestionServiceImpl implements QuestionService {

    @Autowired
    private QuestionDao questionDao;

    @Override
    @Transactional
    public void deleteQuestion(Long id) {
        questionDao.deleteQuestion(id);
    }

    @Override
    @Transactional
    public void editQuestion(Long id,String english, String russian) {
        questionDao.editQuestion(id,english,russian);
    }

    @Override
    @Transactional
    public void addQuestion(Long workshopId, String english, String russian) {
        questionDao.addQuestion(workshopId, english,russian);
    }
}

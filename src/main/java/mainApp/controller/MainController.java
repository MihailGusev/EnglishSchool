package mainApp.controller;

import mainApp.entity.Question;
import mainApp.entity.User;
import mainApp.entity.Workshop;
import mainApp.service.QuestionService;
import mainApp.service.UserService;
import mainApp.service.WorkshopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class MainController {

    @Autowired
    private WorkshopService workshopService;
    @Autowired
    private UserService userService;
    @Autowired
    private QuestionService questionService;

    @GetMapping("/")
    public String showWorkshops(Model model) {
        model.addAttribute("workshops", workshopService.getWorkshops());
        return "workshops";
    }

    @GetMapping(value = "/questions", params = "workshopIdGet")
    public String showQuestionsForWorkshop(HttpServletRequest request,
                                           @RequestParam("workshopIdGet") Long workshopId, Model model) {
        model.addAttribute("workshop", workshopService.getWorkshop(workshopId));
        User user = (User) request.getSession().getAttribute("user");
        model.addAttribute("answeredQuestionsIds", userService.findAnsweredQuestionsIds(user.getId()));
        return "questions";
    }

    @PostMapping(value = "/deleteQuestion", params = "questionId")
    public void deleteQuestion(@RequestParam("questionId") long questionId) {
        questionService.deleteQuestion(questionId);
    }

    @PostMapping(value = "/editQuestion", params = {"questionId", "english", "russian"})
    public void editQuestion(@RequestParam("questionId") long questionId,
                             @RequestParam("english") String english, @RequestParam("russian") String russian) {
        questionService.editQuestion(questionId, english, russian);
    }

    @PostMapping(value = "/addQuestion", params = {"workshopId","english", "russian"})
    public void addQuestion(@RequestParam("workshopId")Long workshopId ,@RequestParam("english") String english, @RequestParam("russian") String russian) {
        questionService.addQuestion(workshopId, english, russian);
    }

    @PostMapping(value = "/addAnsweredQuestion")
    public void getSearchResultViaAjax(HttpServletRequest request, @RequestParam("id") Long id) {
        User user = (User) request.getSession().getAttribute("user");
        userService.addAnsweredQuestion(user.getId(), id);
    }

    @PostMapping(value = "/editWorkshop", params = {"workshopId", "explanations"})
    public void editWorkshop(@RequestParam("workshopId") long workshopId,
                             @RequestParam("explanations") String explanations) {
        workshopService.editWorkshop(workshopId,explanations);
    }

    @PostMapping(value = "/deleteWorkshop", params = "workshopId")
    public void deleteWorkshop(@RequestParam("workshopId") long workshopId) {
        workshopService.deleteWorkshop(workshopId);
    }

    @PostMapping(value = "/addWorkshop", params = "explanations")
    public void addWorkshop(@RequestParam("explanations")String explanations) {
        workshopService.addWorkshop(explanations);
    }

    @GetMapping("/moderators")
    public String showLeaders() {
        return "moderators";
    }

    @GetMapping("/admins")
    public String showSystems() {
        return "admins";
    }
}
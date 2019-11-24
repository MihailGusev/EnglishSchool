package mainApp.controller;

import mainApp.entity.Question;
import mainApp.entity.User;
import mainApp.entity.Workshop;
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

    @GetMapping("/")
    public String showWorkshops(Model model) {
        model.addAttribute("workshops",workshopService.getWorkshops());
        return "workshops";
    }

    @GetMapping(value = "/questions",params = "workshopIdGet")
    public String showQuestions(HttpServletRequest request,
            @RequestParam ("workshopIdGet")int workshopId, Model model) {
        model.addAttribute("workshop",workshopService.getWorkshop(workshopId));
        User user = (User) request.getSession().getAttribute("user");
        model.addAttribute("answeredQuestionsIds",userService.findAnsweredQuestionsIds(user.getId()));
        return "questions";
    }

    @PostMapping(value = "/addAnsweredQuestion")
    public void getSearchResultViaAjax(HttpServletRequest request,@RequestParam("id") Long id) {
        User user = (User) request.getSession().getAttribute("user");
        userService.addAnsweredQuestion(user.getId(),id);
    }


//    @GetMapping(value = "/questions",params = "answer")
//    public String showQuestionsAfterAnswer(
//            @RequestParam ("answer")String answer, Model model){
//        return null;
//    }

//    @RequestMapping("/someAddress")
//    public String someAddress(@RequestParam(value = "UR_PARAM_NAME") String param){
//        System.out.println(param);
//        workshopService.getWorkshop(1).addQuestion(new Question("Yo","Йоу"));
//        return null;
//    }
//
//    @RequestMapping(value = "/search/api/getSearchResult")
//    public String getSearchResultViaAjax(@RequestParam("id") Integer id) {
//        System.out.println("come to ajax"+ id);
//        return "hello";
//    }

    @GetMapping("/moderators")
    public String showLeaders() {
        return "moderators";
    }

    @GetMapping("/admins")
    public String showSystems() {
        return "admins";
    }
}
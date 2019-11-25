package mainApp.controller;

import mainApp.entity.User;
import mainApp.service.UserService;
import mainApp.user.CrmUser;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

import java.util.logging.Logger;

@Controller
@RequestMapping("/register")
public class RegistrationController {

    @Autowired
    private UserService userService;

	private Logger logger = Logger.getLogger(getClass().getName());

    @InitBinder
    public void initBinder(WebDataBinder dataBinder){
        StringTrimmerEditor stringTrimmerEditor = new StringTrimmerEditor(true);
        dataBinder.registerCustomEditor(String.class,stringTrimmerEditor);
    }

    @GetMapping("/showRegistrationForm")
    public String showRegistrationPage(Model theModel){
        theModel.addAttribute("crmUser",new CrmUser());
        return "registration-form";
    }

    @PostMapping("/processRegistrationForm")
    public String processRegistrationForm(
            @Valid @ModelAttribute("crmUser") CrmUser theCrmUser,
            BindingResult theBindingResult, Model theModel){

        String userName=theCrmUser.getUserName();
		logger.info("Processing registration form for: " + userName);
		
        if(theBindingResult.hasErrors()){
            return "registration-form";
        }
        User existing = userService.findByUserName(userName);
        if(existing!=null){
            theModel.addAttribute("crmUser",new CrmUser());
            theModel.addAttribute("registrationError","This email already in use");
            return "registration-form";
        }

        userService.save(theCrmUser);
		
		logger.info("Successfully created user: " + userName);
		
        return "registration-confirmation";
    }
}

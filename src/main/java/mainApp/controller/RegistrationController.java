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
		
        if(theBindingResult.hasErrors()){
            return "registration-form";
        }
        User existing = userService.findByUserName(userName);
        if(existing!=null){
            theModel.addAttribute("crmUser",new CrmUser());
            theModel.addAttribute("registrationError","Этот Email уже занят");
            return "registration-form";
        }

        userService.save(theCrmUser);

        return "registration-confirmation";
    }
}

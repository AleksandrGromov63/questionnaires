package ru.ocode.questionnaires.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import ru.ocode.questionnaires.service.QuestionnairesService;
import ru.ocode.questionnaires.service.UserService;

@Controller
public class UserController {

    @Autowired
    private QuestionnairesService questionnairesService;

    @Autowired
    UserService userService;

    @GetMapping("/user/questionnaires")
    public String questionnaire(Model model) {
      //  User user = userService.getById(userId);
        model.addAttribute("allQuestionnaires", questionnairesService.getAllQuestionnaires());
        return "ankets";
    }

    @GetMapping("/user/questionnaires/{id}")
    public String selectQuestionnaire(@PathVariable(name = "id") Long id, Model model) {
        model.addAttribute("questionnaire", questionnairesService.getById(id));
        return "take-the-survey";
    }
}

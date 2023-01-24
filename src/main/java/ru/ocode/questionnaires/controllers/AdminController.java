package ru.ocode.questionnaires.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ru.ocode.questionnaires.model.Questionnaire;
import ru.ocode.questionnaires.service.QuestionnairesService;
import ru.ocode.questionnaires.service.UserService;

@Controller
public class AdminController {

    @Autowired
    private QuestionnairesService questionnairesService;
    @Autowired
    private UserService userService;

    @GetMapping("/admin")
    public String admin(Model model) {
        model.addAttribute("allUsers", userService.getAllUsers());
        model.addAttribute("allQuestionnaires", questionnairesService.getAllQuestionnaires());
        return "adminPage";
    }


    @PostMapping(value = "/admin/constructor", consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.TEXT_HTML_VALUE)
    public String createQuestionnaire(@RequestBody String questionnaire) {
      /*  if (bindingResult.hasErrors()) {
            return "redirect:/admin";
        }*/
        questionnairesService.saveQuestionnaire(questionnaire);

        return "redirect:/admin";
    }


    @GetMapping("/admin/questionnaires")
    public String questionnaires(Model model) {
        model.addAttribute("allQuestionnaires", questionnairesService.getAllQuestionnaires());
        return "ankets";
    }

    @PostMapping("/admin/questionnaires/{id}")
    public String delete(@PathVariable(name = "id") Long id) {
        questionnairesService.deleteQuestionnaire(id);
        return "redirect:/admin";
    }

    @GetMapping(value = "/admin/questionnaires/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody String select(@PathVariable(name = "id") Long id, Model model) {
        String questionnaireAsJson = questionnairesService.getById(id);
        model.addAttribute("questionnaire", questionnaireAsJson);

        return questionnaireAsJson;
    }

    @GetMapping("/admin/constructor")
    public String create(Model model) {
        model.addAttribute("questionnaire", new Questionnaire());
        return "constructor";
    }


   /* @PutMapping("/admin/questionnaires")
    public String createOrEditQuestionnaire(@ModelAttribute("questionnaireForm") @Valid Questionnaire questionnaireForm,
                                            BindingResult bindingResult, Model model) {
        if (bindingResult.hasErrors()) {
            return "redirect:/admin/questionnaires";
        }
        questionnairesService.saveQuestionnaire(questionnaireForm);
        return "redirect:/admin/questionnaires";
    }*/

    @GetMapping("/admin/allusers")
    public String getAllUsers(Model model) {
        model.addAttribute("allUsers", userService.getAllUsers());
        return "users";
    }
}











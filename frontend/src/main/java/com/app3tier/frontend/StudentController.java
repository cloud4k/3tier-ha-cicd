package com.app3tier.frontend;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class StudentController {

    @GetMapping("/")
    public String showForm(Model model) {

        model.addAttribute("studentForm", new StudentForm());

        return "index";
    }

    @PostMapping("/submit")
    public String submitStudent(
            @ModelAttribute StudentForm studentForm,
            Model model) {

        model.addAttribute("student", studentForm);

        return "student-result";
    }
}
package com.app3tier.frontend;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

@Controller
public class StudentController {

    private final RestTemplate restTemplate = new RestTemplate();

    private final String backendApiUrl = "http://localhost:8081/api/students";

    @GetMapping("/")
    public String showForm(Model model) {
        model.addAttribute("studentForm", new StudentForm());
        return "index";
    }

    @PostMapping("/submit")
    public String submitStudent(@ModelAttribute StudentForm studentForm, Model model) {

        StudentForm savedStudent = restTemplate.postForObject(
                backendApiUrl,
                studentForm,
                StudentForm.class
        );

        model.addAttribute("student", savedStudent);

        return "student-result";
    }
}
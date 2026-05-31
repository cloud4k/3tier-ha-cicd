package com.app3tier.frontend;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

@Controller
public class StudentController {

    private final RestTemplate restTemplate = new RestTemplate();
    @Value("${backend.api.url}")
     private String backendApiUrl;

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
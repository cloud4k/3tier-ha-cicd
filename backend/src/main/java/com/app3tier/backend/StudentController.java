package com.app3tier.backend;

import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/students")
public class StudentController {

    private final StudentRepository studentRepository;

    public StudentController(StudentRepository studentRepository) {
        this.studentRepository = studentRepository;
    }

    @GetMapping
    public List<Student> getAllStudents() {
        return studentRepository.findAll();
    }

    @GetMapping("/{studentId}")
    public Student getStudent(@PathVariable String studentId) {
        return studentRepository.findById(studentId).orElse(null);
    }

    @PostMapping
    public Student createStudent(@RequestBody Student student) {
        return studentRepository.save(student);
    }
}
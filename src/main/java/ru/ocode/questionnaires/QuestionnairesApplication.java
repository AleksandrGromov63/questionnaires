package ru.ocode.questionnaires;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.web.servlet.error.ErrorMvcAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
public class QuestionnairesApplication {

    public static void main(String[] args) {
        SpringApplication.run(QuestionnairesApplication.class, args);
    }
}

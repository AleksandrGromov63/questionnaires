package ru.ocode.questionnaires.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.ocode.questionnaires.model.Question;

public interface QuestionRepository extends JpaRepository<Question, Long> {
    Question findByName(String name);
}

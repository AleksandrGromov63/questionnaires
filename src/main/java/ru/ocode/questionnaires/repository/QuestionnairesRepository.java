package ru.ocode.questionnaires.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.ocode.questionnaires.model.Questionnaire;

import java.util.Optional;

public interface QuestionnairesRepository extends JpaRepository<Questionnaire, Long> {
    Optional<Questionnaire> findQuestionnaireByName(String queName);
    Optional<Questionnaire> findById(Long id);
}

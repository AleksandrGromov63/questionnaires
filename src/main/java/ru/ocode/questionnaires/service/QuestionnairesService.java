package ru.ocode.questionnaires.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.ocode.questionnaires.model.Answer;
import ru.ocode.questionnaires.model.Question;
import ru.ocode.questionnaires.model.Questionnaire;
import ru.ocode.questionnaires.repository.AnswerRepository;
import ru.ocode.questionnaires.repository.QuestionRepository;
import ru.ocode.questionnaires.repository.QuestionnairesRepository;

import java.util.*;

@Service
public class QuestionnairesService {

    @Autowired
    QuestionnairesRepository questionnairesRepository;
    @Autowired
    QuestionRepository questionRepository;
    @Autowired
    AnswerRepository answerRepository;

    public String getById(Long id) {
        int a= 0;
        Optional<Questionnaire> questionnaireFromDB = questionnairesRepository.findById(id);

        ObjectMapper mapper = new ObjectMapper();
        String questionnaireAsJson = null;
        try {
            questionnaireAsJson = mapper.writeValueAsString(questionnaireFromDB.orElse(new Questionnaire()));
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

        return questionnaireAsJson;
    }


    public List<Questionnaire> getAllQuestionnaires() {
        return questionnairesRepository.findAll();
    }


    public boolean saveQuestionnaire(String questionnaireAsJSON) {
        Optional<Questionnaire> questionnaireFromBD;
        Questionnaire questionnaire = null;
        String questionnaireName;
        long questionsCount;
        List<Question> questions = new ArrayList<>();

        System.out.println(questionnaireAsJSON);

        ObjectMapper mapper = new ObjectMapper();

        try {
            JsonNode node = mapper.readTree(questionnaireAsJSON);

            if (node.isObject()) {
                Iterator<Map.Entry<String, JsonNode>> fields = node.fields();

                while (fields.hasNext()) {
                    Map.Entry<String, JsonNode> jsonNodeEntry = fields.next();

                    String keyNode = jsonNodeEntry.getKey();
                    JsonNode valueNode = jsonNodeEntry.getValue();

                    if (keyNode.equals("questionnaireName")) {
                        questionnaireName = valueNode.asText();

                        questionnaireFromBD = questionnairesRepository.findQuestionnaireByName(questionnaireName);

                        questionnaire = questionnaireFromBD.orElse(new Questionnaire());
                        questionnaire.setName(questionnaireName);
                    } else if (keyNode.equals("questionsCount")) {
                        questionsCount = valueNode.asLong();

                        assert questionnaire != null;
                        questionnaire.setQuestionsCount(questionsCount);
                    } else {
                        if (valueNode.isArray()) {
                            Iterator<JsonNode> arrayAnswers = valueNode.elements();

                            Question question = new Question();
                            question.setName(keyNode);
                            question.setQuestionnaire(questionnaire);

                            List<Answer> answers = new ArrayList<>();

                            while (arrayAnswers.hasNext()) {
                                JsonNode answerNode = arrayAnswers.next();

                                Answer answer = new Answer();
                                answer.setName(answerNode.asText());
                                answer.setQuestion(question);
                                answerRepository.save(answer);

                                answers.add(answer);
                            }

                            question.setAnswers(answers);

                            questionRepository.save(question);

                            questions.add(question);
                        }
                    }
                }
            }
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

        assert questionnaire != null;
        questionnaire.setQuestions(questions);

       /* questions.forEach(que -> {
            que.setQuestionnaire(questionnaire);
            questionRepository.save(que);
        });*/

        questionnairesRepository.save(questionnaire);

        return true;
    }

    public boolean deleteQuestionnaire(Long questionnaireId) {

        if (questionnairesRepository.findById(questionnaireId).isPresent()) {
            questionnairesRepository.deleteById(questionnaireId);
            return true;
        }
        return false;
    }
}

package ru.ocode.questionnaires.model;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.util.List;

@Entity
@Table(name = "questions")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
public class Question {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    @Size(min = 1, message = "Не менее одного символа!")
    private String name;
    /* @Size(min = 2)
    @ElementCollection
    private List<String> answerChoices;*/
    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    /*   @JoinColumn(name = "questionnaire_id", nullable = false)*/
    private Questionnaire questionnaire;
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "question")
    private List<Answer> answers;

}

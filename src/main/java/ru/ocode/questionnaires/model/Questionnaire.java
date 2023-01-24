package ru.ocode.questionnaires.model;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import lombok.*;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.util.List;

@Entity
@Table(name = "questionnaires")
@Getter
@Setter
@NoArgsConstructor
@JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id")
public class Questionnaire {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    @Size(min = 1, message = "не менее одного символа!")
    @Column(name = "questionnaire_name", nullable = false, unique = true)
    private String name;
    private long questionsCount;
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "questionnaire")
    private List<Question> questions;
}

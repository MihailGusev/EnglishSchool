package mainApp.entity;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "workshops")
public class Workshop {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "explanations")
    private String explanations;

    @OneToMany(cascade = CascadeType.ALL,fetch = FetchType.EAGER)
    @JoinColumn(name = "workshop_id")
    private List<Question> questions;

    public Workshop() {
    }

    public Workshop(String explanations) {
        this.explanations = explanations;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getExplanations() {
        return explanations;
    }

    public void setExplanations(String explanations) {
        this.explanations = explanations;
    }

    public List<Question> getQuestions() {
        return questions;
    }

    public void setQuestions(List<Question> questions) {
        this.questions = questions;
    }

    @Override
    public String toString() {
        return "Workshop{" +
                "id=" + id +
                ", explanations='" + explanations + '\'' +
                ", questions=" + questions +
                '}';
    }

    public void addQuestion(Question question){
        if (questions==null)
            questions=new ArrayList<>();
        questions.add(question);
    }
}

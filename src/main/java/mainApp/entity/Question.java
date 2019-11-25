package mainApp.entity;

import mainApp.validation.FieldMatch;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "questions")
public class Question {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name = "workshop_id")
    private Long workshopId;

    @Column(name = "english")
    private String english;

    @Column(name = "russian")
    private String russian;

    @ManyToMany
    @JoinTable(name = "users_questions",
    joinColumns = @JoinColumn(name = "question_id"),
    inverseJoinColumns = @JoinColumn(name = "user_id"))
    private List<User> users;

    public Question() {
    }

    public Question(Long workshopId, String english, String russian) {
        this.workshopId=workshopId;
        this.english = english;
        this.russian = russian;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public Long getWorkshopId() {
        return workshopId;
    }

    public void setWorkshopId(Long workshopId) {
        this.workshopId = workshopId;
    }

    public String getEnglish() {
        return english;
    }

    public void setEnglish(String english) {
        this.english = english;
    }

    public String getRussian() {
        return russian;
    }

    public void setRussian(String russian) {
        this.russian = russian;
    }

    public List<User> getUsers() {
        return users;
    }

    public void setUsers(List<User> users) {
        this.users = users;
    }

    @Override
    public String toString() {
        return "Question{" +
                "id=" + id +
                ", english='" + english + '\'' +
                ", russian='" + russian + '\'' +
                '}';
    }

    public void addUser(User user){
        if (users==null)
            users=new ArrayList<>();
        users.add(user);
    }
}

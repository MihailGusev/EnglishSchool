package mainApp.user;


import mainApp.validation.FieldMatch;
import mainApp.validation.ValidEmail;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@FieldMatch.List({
        @FieldMatch(first = "password",second = "matchingPassword", message = "Пароли не совпадают")
})
public class CrmUser {

    private static final String message="Поле должно быть заполнено";

    @ValidEmail
    @NotNull(message = message)
    @Size(min=1,message = message)
    private String userName;

    @NotNull(message = message)
    @Size(min=1,message = message)
    private String password;

    @NotNull(message = message)
    @Size(min=1,message = message)
    private String matchingPassword;

    @NotNull(message = message)
    @Size(min=1,message = message)
    private String firstName;

    @NotNull(message = message)
    @Size(min=1,message = message)
    private String lastName;

    public CrmUser() {
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getMatchingPassword() {
        return matchingPassword;
    }

    public void setMatchingPassword(String matchingPassword) {
        this.matchingPassword = matchingPassword;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
}

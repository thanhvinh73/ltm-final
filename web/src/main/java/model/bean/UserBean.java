package model.bean;

import java.sql.Timestamp;

import javax.persistence.*;

import com.fasterxml.uuid.Generators;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Builder
@Entity
@Table(name = "users")
public class UserBean extends BaseBean {
    @Id
    @Column(name = "id")
    private String id;

    @Column(name = "email")
    private String email;

    @Column(name = "password")
    private String password;

    @Column(name = "name")
    private String name;

    @Column(name = "created_at")
    private Timestamp createdAt;

    @Override
    public void generateId() {
        this.id = Generators.randomBasedGenerator().generate().toString();
    }

    @Override
    public void prePersistNewData() {
        generateId();
        this.createdAt = new Timestamp(System.currentTimeMillis());
    }
}

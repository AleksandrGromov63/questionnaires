package ru.ocode.questionnaires.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.ocode.questionnaires.model.User;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);
}

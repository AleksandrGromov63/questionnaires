package ru.ocode.questionnaires.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import ru.ocode.questionnaires.model.Role;
import ru.ocode.questionnaires.model.User;
import ru.ocode.questionnaires.repository.UserRepository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;
import java.util.Optional;

@Service
public class UserService implements UserDetailsService {

    @PersistenceContext
    private EntityManager manager;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findByUsername(username);
        if (user == null) throw new UsernameNotFoundException("User not found");
        return user;
    }

    public boolean saveUser(User user) {
        User userFromDB = userRepository.findByUsername(user.getUsername());

        if (userFromDB != null) return false;

        if (user.getUsername().equals("admin")) user.setRole(Role.ADMIN);
        else user.setRole(Role.USER);

        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        //   user.setCompleteQuestionnaires(user.getCompleteQuestionnaires());
        userRepository.save(user);

        return true;
    }

    public boolean deleteUser(User user) {
        if (userRepository.findById(user.getId()).isPresent()) {
            userRepository.delete(user);
            return true;
        }
        return false;
    }

    public User getById(User user) {
        Optional<User> userById = userRepository.findById(user.getId());
        return userById.orElse(new User());
    }

    public User getById(Long id) {
        return userRepository.getById(id);
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }
}

package com.example.demo.repositories;
import com.example.demo.models.Evenement;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
public interface EvenementRepository extends JpaRepository<Evenement, Long> {
    List<Evenement> findAllByOrderByDateEvenementDesc();
}
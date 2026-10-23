package com.example.demo.repositories;

import com.example.demo.models.Utilisateur;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface UtilisateurRepository extends JpaRepository<Utilisateur, Long> {
    // Cette fonction permet de trier par équipe A-Z
    List<Utilisateur> findAllByOrderByEquipeAsc();
}
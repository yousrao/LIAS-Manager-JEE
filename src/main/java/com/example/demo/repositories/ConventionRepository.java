package com.example.demo.repositories;

import com.example.demo.models.Convention;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ConventionRepository extends JpaRepository<Convention, Long> {
    List<Convention> findAllByOrderByDateSignatureDesc();
}
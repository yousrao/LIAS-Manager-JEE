package com.example.demo.models;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
public class Convention {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String partenaire; // Ex: CNRST, Université de Lorraine
    private String type; // INTERNATIONALE, NATIONALE, INDUSTRIELLE
    private LocalDate dateSignature;
    private String objectif; // Ex: Mobilité doctorants, Co-encadrement

    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getPartenaire() { return partenaire; }
    public void setPartenaire(String partenaire) { this.partenaire = partenaire; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public LocalDate getDateSignature() { return dateSignature; }
    public void setDateSignature(LocalDate dateSignature) { this.dateSignature = dateSignature; }
    public String getObjectif() { return objectif; }
    public void setObjectif(String objectif) { this.objectif = objectif; }
}

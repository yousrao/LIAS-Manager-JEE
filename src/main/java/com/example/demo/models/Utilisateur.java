package com.example.demo.models;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
public class Utilisateur {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nom;
    private String email;
    private String password;
    private String role;   
    private String statut; 
    private String equipe; 
    
    @Column(columnDefinition = "TEXT")
    private String themes;

    // --- MODULE 4 : DONNÉES TEMPORELLES ---
    private LocalDate dateAdhesion = LocalDate.now(); // Date d'entrée automatique

    // --- MODULE 8 : DÉPART ET RETRAITE ---
    private boolean actif = true; // true = Membre actif, false = Retraité/Ancien

    // Getters et Setters (TOUS)
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }
    public String getEquipe() { return equipe; }
    public void setEquipe(String equipe) { this.equipe = equipe; }
    public String getThemes() { return themes; }
    public void setThemes(String themes) { this.themes = themes; }
    public LocalDate getDateAdhesion() { return dateAdhesion; }
    public void setDateAdhesion(LocalDate dateAdhesion) { this.dateAdhesion = dateAdhesion; }
    public boolean isActif() { return actif; }
    public void setActif(boolean actif) { this.actif = actif; }
}
package com.example.demo.models;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
public class Document {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String titre;
    private String type; // Demande financement, Programme, Attestation, Rapport
    private LocalDate dateDepot = LocalDate.now();
    private String lienFichier; // URL vers le document (ex: Drive ou Dropbox)

    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public LocalDate getDateDepot() { return dateDepot; }
    public void setDateDepot(LocalDate dateDepot) { this.dateDepot = dateDepot; }
    public String getLienFichier() { return lienFichier; }
    public void setLienFichier(String lienFichier) { this.lienFichier = lienFichier; }
}

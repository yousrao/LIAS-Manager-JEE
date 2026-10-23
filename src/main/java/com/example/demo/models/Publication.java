package com.example.demo.models;

import jakarta.persistence.*;

@Entity
public class Publication {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String titre;
    private int annee;
    private String type; // Article, Conférence, Livre
    private String lien;

    @ManyToOne // Un membre peut avoir plusieurs publications
    @JoinColumn(name = "auteur_id")
    private Utilisateur auteur;

    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }
    public int getAnnee() { return annee; }
    public void setAnnee(int annee) { this.annee = annee; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public String getLien() { return lien; }
    public void setLien(String lien) { this.lien = lien; }
    public Utilisateur getAuteur() { return auteur; }
    public void setAuteur(Utilisateur auteur) { this.auteur = auteur; }
}

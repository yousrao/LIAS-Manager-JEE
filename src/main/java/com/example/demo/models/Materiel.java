package com.example.demo.models;

import jakarta.persistence.*;

@Entity
public class Materiel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nom;
    private String marque;
    private String numeroInventaire;
    private String etat; 

    // SUIVI DE DISTRIBUTION : Qui possède ce matériel ?
    @ManyToOne
    @JoinColumn(name = "detenteur_id")
    private Utilisateur detenteur; // Si c'est null, le matériel est en stock (arrivage)

    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    public String getMarque() { return marque; }
    public void setMarque(String marque) { this.marque = marque; }
    public String getNumeroInventaire() { return numeroInventaire; }
    public void setNumeroInventaire(String numeroInventaire) { this.numeroInventaire = numeroInventaire; }
    public String getEtat() { return etat; }
    public void setEtat(String etat) { this.etat = etat; }
    public Utilisateur getDetenteur() { return detenteur; }
    public void setDetenteur(Utilisateur detenteur) { this.detenteur = detenteur; }
}

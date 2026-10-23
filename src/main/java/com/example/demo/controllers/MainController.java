package com.example.demo.controllers;

import com.example.demo.models.*;
import com.example.demo.repositories.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.stream.Collectors;

@Controller
public class MainController {

    @Autowired private UtilisateurRepository utilisateurRepository;
    @Autowired private PublicationRepository publicationRepository;
    @Autowired private EvenementRepository evenementRepository;
    @Autowired private MaterielRepository materielRepository;
    @Autowired private ReunionRepository reunionRepository;
    @Autowired private ConventionRepository conventionRepository;
    @Autowired private DocumentRepository documentRepository;
    @Autowired private MessageRepository messageRepository;
    @Autowired private NotificationRepository notificationRepository;

    // ==========================================
    // 1. ACCUEIL & CONNEXION
    // ==========================================
    @GetMapping("/") public String home() { return "home"; }
    @GetMapping("/login") public String loginPage() { return "login"; }
    
    @PostMapping("/connexion")
    public String connecter(@RequestParam String email, @RequestParam String password, HttpSession session, Model model) {
        String admin1 = "f.benabbou@univmsik.ma"; String admin2 = "a.belangour@univmsik.ma";
        Utilisateur user = utilisateurRepository.findAll().stream()
                .filter(u -> u.getEmail().equalsIgnoreCase(email) && u.getPassword().equals(password))
                .findFirst().orElse(null);
        if (user != null && (email.equalsIgnoreCase(admin1) || email.equalsIgnoreCase(admin2))) {
            session.setAttribute("utilisateurConnecte", user); return "redirect:/admin";
        }
        model.addAttribute("erreur", "Accès restreint à la direction."); return "login";
    }
    @GetMapping("/logout") public String logout(HttpSession session) { session.invalidate(); return "redirect:/"; }

    // ==========================================
    // 2. CENTRE DE NOTIFICATIONS (MODULE 19)
    // ==========================================
    @GetMapping("/notifications")
    public String listNotifs(Model model, HttpSession session) {
        if (session.getAttribute("utilisateurConnecte") == null) return "redirect:/login";
        model.addAttribute("notifications", notificationRepository.findAllByOrderByDateNotifDesc());
        return "notifications";
    }
    @GetMapping("/supprimer-notif/{id}")
    public String supprimerNotif(@PathVariable Long id) { notificationRepository.deleteById(id); return "redirect:/notifications"; }

    // ==========================================
    // 3. ÉQUIPE & MEMBRES (DASHBOARD)
    // ==========================================
    @GetMapping("/admin")
    public String dashboard(Model model, HttpSession session) {
        if (session.getAttribute("utilisateurConnecte") == null) return "redirect:/login";
        List<Utilisateur> actifs = utilisateurRepository.findAllByOrderByEquipeAsc().stream()
                .filter(u -> u.isActif() && !u.getRole().equals("VISITEUR")).collect(Collectors.toList());
        model.addAttribute("membres", actifs);
        return "index";
    }

    @GetMapping("/ajouter") public String formM(Model m) { m.addAttribute("user", new Utilisateur()); return "inscription"; }
    
    @PostMapping("/sauvegarder")
    public String sM(@ModelAttribute Utilisateur u) {
        utilisateurRepository.save(u);
        Notification n = new Notification(); n.setMessage("Mise à jour membre : " + u.getNom()); n.setType("MEMBRE"); notificationRepository.save(n);
        return "redirect:/admin";
    }
    @GetMapping("/modifier/{id}") public String modM(@PathVariable Long id, Model m) { m.addAttribute("user", utilisateurRepository.findById(id).get()); return "modifier"; }
    @GetMapping("/supprimer/{id}") public String delM(@PathVariable Long id) { utilisateurRepository.deleteById(id); return "redirect:/admin"; }
    @GetMapping("/archiver/{id}") public String arcM(@PathVariable Long id) { 
        Utilisateur u = utilisateurRepository.findById(id).get(); u.setActif(false); u.setStatut("RETRAITE"); utilisateurRepository.save(u); 
        return "redirect:/admin"; 
    }

    @GetMapping("/archives") public String listA(Model m, HttpSession s) {
        if (s.getAttribute("utilisateurConnecte") == null) return "redirect:/login";
        m.addAttribute("anciens", utilisateurRepository.findAll().stream().filter(u -> !u.isActif()).collect(Collectors.toList()));
        return "archives";
    }

    // ==========================================
    // 4. DEMANDES D'ADHÉSION (SIGNUP)
    // ==========================================
    @GetMapping("/rejoindre") 
    public String signupPage(Model model) { 
        model.addAttribute("user", new Utilisateur()); 
        return "signup"; 
    }

    @PostMapping("/envoyer-demande")
    public String envoyerDemande(@ModelAttribute("user") Utilisateur u) {
        u.setRole("VISITEUR"); u.setPassword("123456"); u.setActif(true);
        utilisateurRepository.save(u);
        Notification n = new Notification(); n.setMessage("Nouvelle candidature : " + u.getNom()); n.setType("DEMANDE"); notificationRepository.save(n);
        return "redirect:/login?success";
    }

    @GetMapping("/demandes") public String listDe(Model m, HttpSession s) {
        if (s.getAttribute("utilisateurConnecte") == null) return "redirect:/login";
        m.addAttribute("attentes", utilisateurRepository.findAll().stream().filter(u -> u.getRole().equals("VISITEUR")).collect(Collectors.toList()));
        return "demandes";
    }
    @GetMapping("/accepter/{id}") public String accM(@PathVariable Long id) {
        Utilisateur u = utilisateurRepository.findById(id).get(); u.setRole("MEMBRE"); u.setActif(true); utilisateurRepository.save(u);
        Notification n = new Notification(); n.setMessage("Candidat accepté : " + u.getNom()); n.setType("VALIDATION"); notificationRepository.save(n);
        return "redirect:/demandes";
    }

    // ==========================================
    // 5. PUBLICATIONS
    // ==========================================
    @GetMapping("/publications") public String listP(Model m, HttpSession s) { if (s.getAttribute("utilisateurConnecte") == null) return "redirect:/login"; m.addAttribute("publications", publicationRepository.findAll()); return "publications"; }
    @GetMapping("/ajouter-publication") public String addP(Model m) { m.addAttribute("pub", new Publication()); m.addAttribute("membres", utilisateurRepository.findAll()); return "ajout-pub"; }
    @PostMapping("/sauvegarder-pub") public String saveP(Publication p) { 
        publicationRepository.save(p); 
        Notification n = new Notification(); n.setMessage("Nouvelle publication : " + p.getTitre()); n.setType("RECHERCHE"); notificationRepository.save(n);
        return "redirect:/publications"; 
    }
    @GetMapping("/modifier-pub/{id}") public String modP(@PathVariable Long id, Model m) { m.addAttribute("pub", publicationRepository.findById(id).get()); m.addAttribute("membres", utilisateurRepository.findAll()); return "modifier-pub"; }
    @GetMapping("/supprimer-pub/{id}") public String delP(@PathVariable Long id) { publicationRepository.deleteById(id); return "redirect:/publications"; }

    // ==========================================
    // 6. ÉVÉNEMENTS & CALENDRIER
    // ==========================================
    @GetMapping("/evenements") public String listEv(Model m, HttpSession s) { if (s.getAttribute("utilisateurConnecte") == null) return "redirect:/login"; m.addAttribute("events", evenementRepository.findAllByOrderByDateEvenementDesc()); return "evenements"; }
    @GetMapping("/ajouter-evenement") public String addE(Model m) { m.addAttribute("event", new Evenement()); return "ajout-event"; }
    @PostMapping("/sauvegarder-event") public String saveE(Evenement e) { 
        evenementRepository.save(e); 
        Notification n = new Notification(); n.setMessage("Événement créé : " + e.getTitre()); n.setType("ÉVÉNEMENT"); notificationRepository.save(n);
        return "redirect:/evenements"; 
    }
    @GetMapping("/modifier-event/{id}") public String modE(@PathVariable Long id, Model m) { m.addAttribute("event", evenementRepository.findById(id).get()); return "ajout-event"; }
    @GetMapping("/supprimer-event/{id}") public String delE(@PathVariable Long id) { evenementRepository.deleteById(id); return "redirect:/evenements"; }
    @GetMapping("/calendrier") public String viewC(Model m, HttpSession s) { if (s.getAttribute("utilisateurConnecte") == null) return "redirect:/login"; m.addAttribute("events", evenementRepository.findAllByOrderByDateEvenementDesc()); return "calendrier"; }

    // ==========================================
    // 7. DOCUMENTS (ARCHIVAGE DOC)
    // ==========================================
    @GetMapping("/documents") public String listD(Model m, HttpSession s) { if (s.getAttribute("utilisateurConnecte") == null) return "redirect:/login"; m.addAttribute("documents", documentRepository.findAllByOrderByDateDepotDesc()); return "documents"; }
    @GetMapping("/ajouter-document") public String addD(Model m) { m.addAttribute("doc", new Document()); return "ajout-doc"; }
    @PostMapping("/sauvegarder-doc") public String saveD(Document d) { 
        documentRepository.save(d); 
        Notification n = new Notification(); n.setMessage("Document archivé : " + d.getTitre()); n.setType("DOCUMENT"); notificationRepository.save(n);
        return "redirect:/documents"; 
    }
    @GetMapping("/modifier-doc/{id}") public String modD(@PathVariable Long id, Model m) { m.addAttribute("doc", documentRepository.findById(id).get()); return "ajout-doc"; }
    @GetMapping("/supprimer-doc/{id}") public String delD(@PathVariable Long id) { documentRepository.deleteById(id); return "redirect:/documents"; }

    // ==========================================
    // 8. MATÉRIEL, CONVENTIONS, MESSAGES & RAPPORT
    // ==========================================
    @GetMapping("/materiel") public String lMa(Model m, HttpSession s) { if (s.getAttribute("utilisateurConnecte") == null) return "redirect:/login"; m.addAttribute("materiels", materielRepository.findAll()); return "materiel"; }
    @GetMapping("/ajouter-materiel") public String amM(Model m) { m.addAttribute("materiel", new Materiel()); m.addAttribute("membres", utilisateurRepository.findAll()); return "ajout-materiel"; }
    @PostMapping("/sauvegarder-materiel") public String smM(Materiel ma) { materielRepository.save(ma); Notification n = new Notification(); n.setMessage("Matériel mis à jour : " + ma.getNom()); n.setType("MATÉRIEL"); notificationRepository.save(n); return "redirect:/materiel"; }
    @GetMapping("/modifier-materiel/{id}") public String mmM(@PathVariable Long id, Model m) { m.addAttribute("materiel", materielRepository.findById(id).get()); m.addAttribute("membres", utilisateurRepository.findAll()); return "ajout-materiel"; }
    @GetMapping("/supprimer-materiel/{id}") public String dmM(@PathVariable Long id) { materielRepository.deleteById(id); return "redirect:/materiel"; }

    @GetMapping("/reunions") public String lR(Model m, HttpSession s) { if (s.getAttribute("utilisateurConnecte") == null) return "redirect:/login"; m.addAttribute("reunions", reunionRepository.findAllByOrderByDateReunionDesc()); return "reunions"; }
    @GetMapping("/ajouter-reunion") public String arR(Model m) { m.addAttribute("reunion", new Reunion()); return "ajout-reunion"; }
    @PostMapping("/sauvegarder-reunion") public String srR(Reunion r) { reunionRepository.save(r); Notification n = new Notification(); n.setMessage("Réunion archivée : " + r.getTitre()); n.setType("GOUVERNANCE"); notificationRepository.save(n); return "redirect:/reunions"; }
    @GetMapping("/modifier-reunion/{id}") public String mrR(@PathVariable Long id, Model m) { m.addAttribute("reunion", reunionRepository.findById(id).get()); return "ajout-reunion"; }
    @GetMapping("/supprimer-reunion/{id}") public String drR(@PathVariable Long id) { reunionRepository.deleteById(id); return "redirect:/reunions"; }

    @GetMapping("/conventions") public String lC(Model m, HttpSession s) { if (s.getAttribute("utilisateurConnecte") == null) return "redirect:/login"; m.addAttribute("conventions", conventionRepository.findAllByOrderByDateSignatureDesc()); return "conventions"; }
    @GetMapping("/ajouter-convention") public String acC(Model m) { m.addAttribute("convention", new Convention()); return "ajout-convention"; }
    @PostMapping("/sauvegarder-convention") public String scC(Convention c) { conventionRepository.save(c); Notification n = new Notification(); n.setMessage("Convention signée : " + c.getPartenaire()); n.setType("CONVENTION"); notificationRepository.save(n); return "redirect:/conventions"; }
    @GetMapping("/modifier-convention/{id}") public String mcC(@PathVariable Long id, Model m) { m.addAttribute("convention", conventionRepository.findById(id).get()); return "ajout-convention"; }
    @GetMapping("/supprimer-convention/{id}") public String dcC(@PathVariable Long id) { conventionRepository.deleteById(id); return "redirect:/conventions"; }

    @GetMapping("/messages") public String lMs(Model m, HttpSession s) { if (s.getAttribute("utilisateurConnecte") == null) return "redirect:/login"; m.addAttribute("messages", messageRepository.findAllByOrderByDateEnvoiDesc()); return "messages"; }
    @PostMapping("/envoyer-message") public String eMs(@RequestParam(required=false) Long id, @RequestParam String contenu, HttpSession s) { Utilisateur u = (Utilisateur) s.getAttribute("utilisateurConnecte"); if (u != null) { Message m = (id!=null)?messageRepository.findById(id).orElse(new Message()):new Message(); m.setExpediteur(u.getNom()); m.setContenu(contenu); messageRepository.save(m); } return "redirect:/messages"; }
    @GetMapping("/modifier-message/{id}") public String mMs(@PathVariable Long id, Model m) { m.addAttribute("msg", messageRepository.findById(id).get()); return "modifier-message"; }
    @GetMapping("/supprimer-message/{id}") public String dMs(@PathVariable Long id) { messageRepository.deleteById(id); return "redirect:/messages"; }

    @GetMapping("/rapport") public String rap(Model m, HttpSession s) { 
        if (s.getAttribute("utilisateurConnecte") == null) return "redirect:/login"; 
        m.addAttribute("totalMembres", utilisateurRepository.count()); m.addAttribute("totalPubs", publicationRepository.count()); m.addAttribute("totalEvents", evenementRepository.count()); m.addAttribute("totalMateriel", materielRepository.count()); m.addAttribute("totalReunions", reunionRepository.count()); m.addAttribute("totalConventions", conventionRepository.count()); m.addAttribute("pubList", publicationRepository.findAll()); m.addAttribute("eventList", evenementRepository.findAllByOrderByDateEvenementDesc()); m.addAttribute("reunionList", reunionRepository.findAllByOrderByDateReunionDesc()); 
        return "rapport"; 
    }
}
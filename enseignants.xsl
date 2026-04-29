<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="UTF-8"/>

<xsl:template match="/">
    <html>
        <head>
            <title>Liste des enseignants</title>
            <style>
                body {
                    font-family: Arial;
                    background-color: #f2f2f2;
                    padding: 20px;
                }
                h1 {
                    text-align: center;
                    color: #2c3e50;
                }
                table {
                    border-collapse: collapse;
                    width: 95%;
                    margin: 20px auto;
                    background-color: white;
                }
                th, td {
                    border: 1px solid black;
                    padding: 10px;
                    text-align: center;
                }
                th {
                    background-color: #3498db;
                    color: white;
                }
                tr:nth-child(even) {
                    background-color: #f2f2f2;
                }
                .add-form {
                    width: 95%;
                    margin: 20px auto;
                    padding: 20px;
                    background-color: white;
                    border-radius: 8px;
                }
                input, select {
                    padding: 8px;
                    margin: 5px;
                    width: 200px;
                }
                button {
                    padding: 8px 15px;
                    margin: 5px;
                    background-color: #3498db;
                    color: white;
                    border: none;
                    cursor: pointer;
                }
                button:hover {
                    background-color: #2980b9;
                }
                .delete-btn {
                    background-color: #e74c3c;
                }
                .delete-btn:hover {
                    background-color: #c0392b;
                }
                .edit-btn {
                    background-color: #f39c12;
                }
                .edit-btn:hover {
                    background-color: #e67e22;
                }
            </style>
        </head>
        <body>
            <h1>📚 Gestion des Enseignants</h1>
            
            <!-- Formulaire d'ajout -->
            <div class="add-form">
                <h3>Ajouter un enseignant</h3>
                <form name="addForm">
                    <input type="text" name="nom" placeholder="Nom" required/>
                    <input type="text" name="prenom" placeholder="Prénom" required/>
                    <select name="grade">
                        <option>Professeur</option>
                        <option>Maître de Conférences</option>
                        <option>Assistant</option>
                    </select>
                    <input type="email" name="email" placeholder="Email" required/>
                    <input type="text" name="fix" placeholder="Tél Fixe" required/>
                    <input type="text" name="port" placeholder="Tél Portable" required/>
                    <input type="text" name="ville" placeholder="Ville" required/>
                    <button type="button" onclick="ajouterEnseignant()">➕ Ajouter</button>
                </form>
            </div>
            
            <!-- Formulaire de modification (caché au début) -->
            <div class="add-form" id="editForm" style="display:none;">
                <h3>Modifier un enseignant</h3>
                <form name="editForm">
                    <input type="hidden" id="editRowIndex"/>
                    <input type="text" id="editNom" placeholder="Nom" required/>
                    <input type="text" id="editPrenom" placeholder="Prénom" required/>
                    <select id="editGrade">
                        <option>Professeur</option>
                        <option>Maître de Conférences</option>
                        <option>Assistant</option>
                    </select>
                    <input type="email" id="editEmail" placeholder="Email" required/>
                    <input type="text" id="editFix" placeholder="Tél Fixe" required/>
                    <input type="text" id="editPort" placeholder="Tél Portable" required/>
                    <input type="text" id="editVille" placeholder="Ville" required/>
                    <button type="button" onclick="enregistrerModification()">💾 Enregistrer</button>
                    <button type="button" onclick="annulerModification()">❌ Annuler</button>
                </form>
            </div>
            
            <!-- Tableau des enseignants -->
            <table>
                <thead>
                    <tr>
                        <th>Nom</th>
                        <th>Prénom</th>
                        <th>Grade</th>
                        <th>Email</th>
                        <th>Tél Fixe</th>
                        <th>Tél Portable</th>
                        <th>Ville</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <xsl:for-each select="université/enseignant">
                        <tr>
                            <td><xsl:value-of select="nom"/></td>
                            <td><xsl:value-of select="nom/@prénom"/></td>
                            <td><xsl:value-of select="@grade"/></td>
                            <td><xsl:value-of select="email"/></td>
                            <td><xsl:value-of select="telephone/fix"/></td>
                            <td><xsl:value-of select="telephone/port"/></td>
                            <td><xsl:value-of select="ville"/></td>
                            <td>
                                <button class="edit-btn" onclick="modifierEnseignant(this)">✏️ Modifier</button>
                                <button class="delete-btn" onclick="supprimerEnseignant(this)">🗑️ Supprimer</button>
                            </td>
                        </td>
                    </xsl:for-each>
                </tbody>
            </table>
            
            <script>
                // Fonction pour ajouter un enseignant
                function ajouterEnseignant() {
                    var form = document.forms.addForm;
                    var table = document.querySelector("tbody");
                    var newRow = table.insertRow();
                    
                    newRow.innerHTML = `
                        <td>${form.nom.value}</td>
                        <td>${form.prenom.value}</td>
                        <td>${form.grade.value}</td>
                        <td>${form.email.value}</td>
                        <td>${form.fix.value}</td>
                        <td>${form.port.value}</td>
                        <td>${form.ville.value}</td>
                        <td><button class="edit-btn" onclick="modifierEnseignant(this)">✏️ Modifier</button>
                                <button class="delete-btn" onclick="supprimerEnseignant(this)">🗑️ Supprimer</button></td>
                    `;
                    
                    form.reset();
                    alert("Enseignant ajouté avec succès!");
                }
                
                // Fonction pour supprimer un enseignant
                function supprimerEnseignant(btn) {
                    if(confirm("Voulez-vous vraiment supprimer cet enseignant?")) {
                        var row = btn.parentNode.parentNode;
                        row.parentNode.removeChild(row);
                        alert("Enseignant supprimé!");
                    }
                }
                
                // Fonction pour modifier un enseignant
                function modifierEnseignant(btn) {
                    var row = btn.parentNode.parentNode;
                    var cells = row.getElementsByTagName("td");
                    
                    // Remplir le formulaire de modification
                    document.getElementById("editNom").value = cells[0].innerHTML;
                    document.getElementById("editPrenom").value = cells[1].innerHTML;
                    document.getElementById("editGrade").value = cells[2].innerHTML;
                    document.getElementById("editEmail").value = cells[3].innerHTML;
                    document.getElementById("editFix").value = cells[4].innerHTML;
                    document.getElementById("editPort").value = cells[5].innerHTML;
                    document.getElementById("editVille").value = cells[6].innerHTML;
                    document.getElementById("editRowIndex").value = row.rowIndex;
                    
                    // Cacher le formulaire d'ajout et afficher le formulaire de modification
                    document.querySelector(".add-form").style.display = "none";
                    document.getElementById("editForm").style.display = "block";
                }
                
                // Fonction pour enregistrer la modification
                function enregistrerModification() {
                    var rowIndex = document.getElementById("editRowIndex").value;
                    var table = document.querySelector("tbody");
                    var row = table.rows[rowIndex - 1];
                    var cells = row.getElementsByTagName("td");
                    
                    cells[0].innerHTML = document.getElementById("editNom").value;
                    cells[1].innerHTML = document.getElementById("editPrenom").value;
                    cells[2].innerHTML = document.getElementById("editGrade").value;
                    cells[3].innerHTML = document.getElementById("editEmail").value;
                    cells[4].innerHTML = document.getElementById("editFix").value;
                    cells[5].innerHTML = document.getElementById("editPort").value;
                    cells[6].innerHTML = document.getElementById("editVille").value;
                    
                    annulerModification();
                    alert("Enseignant modifié avec succès!");
                }
                
                // Fonction pour annuler la modification
                function annulerModification() {
                    document.getElementById("editForm").style.display = "none";
                    document.querySelector(".add-form").style.display = "block";
                    document.getElementById("editForm").reset();
                }
            </script>
        </body>
    </html>
</xsl:template>

</xsl:stylesheet>
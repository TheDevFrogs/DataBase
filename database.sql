-- CREATION DE LA BASE DE DONNEE POUR LE DEPOT DE TRAVAUX

-- Creation de la table Session
CREATE TABLE Session
(
    id_session SERIAL NOT NULL,
    name VARCHAR NOT NULL,
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP NOT NULL,
    PRIMARY KEY (id_session)
);


-- Creation de la table Class pour les cours
CREATE TABLE Class
(
    id_class SERIAL NOT NULL,
    name VARCHAR NOT NULL,
    description VARCHAR NOT NULL,
    PRIMARY KEY (id_class)
);


-- Creation de la table SessionClass pour associer les cours a chaque session
CREATE TABLE SessionClass
(
    id_session INT NOT NULL,
    id_class INT NOT NULL,
    FOREIGN KEY (id_session) REFERENCES Session(id_session),
    FOREIGN KEY (id_class) REFERENCES Class(id_class)
);


-- Creation de la table noGroup pour le nom des numeros de groupe
CREATE TABLE NoGroup
(
    id_noGroup SERIAL NOT NULL,
    no_group VARCHAR NOT NULL,
    name VARCHAR NOT NULL,
    PRIMARY KEY (id_noGroup)
);


-- Creation de la table Groupe pour la création des groupe Session-cours-numero de groupe
CREATE TABLE Groupe
(
    id_group SERIAL NOT NULL,
    id_class INT NOT NULL,
    id_session INT NOT NULL,
    id_noGroup INT NOT NULL,
    PRIMARY KEY (id_group),
    FOREIGN KEY (id_class) REFERENCES Class(id_class),
    FOREIGN KEY (id_session) REFERENCES Session(id_session),
    FOREIGN KEY (id_noGroup) REFERENCES NoGroup(id_noGroup)
 );


-- Creation de la table Member pour la liste des membres
CREATE TABLE Member
(
    cip VARCHAR NOT NULL,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    PRIMARY KEY (cip)
);


-- Creation de la table Role pour les role qu'occupe les personnes qui depose dans un groupe
CREATE TABLE Role
(
    id_role SERIAL NOT NULL,
    name VARCHAR NOT NULL,
    PRIMARY KEY (id_role)
);


-- Creation de la table GroupMember
CREATE TABLE GroupMember
(
    cip VARCHAR NOT NULL,
    id_group INT NOT NULL,
    id_role INT NOT NULL,
    FOREIGN KEY (cip) REFERENCES Member(cip),
    FOREIGN KEY (id_group) REFERENCES Groupe(id_group),
    FOREIGN KEY (id_role) REFERENCES Role(id_role)
);


-- Creation de la table Assignment pour la liste des travaux
CREATE TABLE Assignment
(
    id_assignment SERIAL NOT NULL,
    id_group INT,     -- Optionnel, car on pourrait vouloir creer un travail, mais ne pas l'associer tout de suite a un groupe
    name VARCHAR NOT NULL,
    description VARCHAR,     -- Description optionnelle
    due_date TIMESTAMP NOT NULL,
    close_date TIMESTAMP NOT NULL,
    available_date TIMESTAMP NOT NULL,
    team_size INT NOT NULL,
    PRIMARY KEY (id_assignment),
    FOREIGN KEY (id_group) REFERENCES Groupe(id_group)
);


-- Creation de la table NomEquipe
CREATE TABLE NomEquipe
(
    id_nomEquipe SERIAL NOT NULL,
    name VARCHAR NOT NULL,
    PRIMARY KEY (id_nomEquipe)
);

-- Creation de la table Team pour la creation des equipes
CREATE TABLE Team
(
    id_team SERIAL NOT NULL,
    id_assignment INT NOT NULL,
    id_nomEquipe INT NOT NULL ,
    PRIMARY KEY (id_team),
    FOREIGN KEY (id_assignment) REFERENCES Assignment(id_assignment),
    FOREIGN KEY (id_nomEquipe) REFERENCES NomEquipe(id_nomEquipe)
);


-- Creation de la table TeamMember pour les membre des equipes
CREATE TABLE TeamMember
(
    cip VARCHAR NOT NULL,
    id_team INT NOT NULL,
    FOREIGN KEY (cip) REFERENCES Member(cip),
    FOREIGN KEY (id_team) REFERENCES Team(id_team)
);


-- Creation de la table File pour la liste des fichiers
CREATE TABLE File
(
    id_file SERIAL NOT NULL,
    path VARCHAR NOT NULL,
    name VARCHAR NOT NULL,
    PRIMARY KEY (id_file)
);


-- Creation de la table AssignmentFile qui associe des fichiers aux travaux
CREATE TABLE AssignmentFile
(
    id_assignment INT NOT NULL,
    id_file INT NOT NULL,
    FOREIGN KEY (id_assignment) REFERENCES Assignment(id_assignment),
    FOREIGN KEY (id_file) REFERENCES File(id_file)
);


-- Creation de la table TypeRemise pour savoir si la remise d'un fichier est fait par qui (enseignant etudiant, etc.)
CREATE TABLE TypeRemise
(
    id_typeRemise SERIAL NOT NULL,
    name VARCHAR NOT NULL,
    PRIMARY KEY (id_typeRemise)
);


-- Creation de la table HandedAssignment pour les fichiers remis
CREATE TABLE HandedAssignment
(
    id_handedAssignment SERIAL NOT NULL,
    id_team INT NOT NULL,
    id_file INT NOT NULL,
    handed_date TIMESTAMP NOT NULL,
    id_typeRemise INT NOT NULL,
    PRIMARY KEY (id_handedAssignment),
    FOREIGN KEY (id_team) REFERENCES Team(id_team),
    FOREIGN KEY (id_file) REFERENCES File(id_file),
    FOREIGN KEY (id_typeRemise) REFERENCES TypeRemise(id_typeRemise)
);

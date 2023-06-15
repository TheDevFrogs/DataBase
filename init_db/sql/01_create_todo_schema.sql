
-- Creation de la table des cours
CREATE TABLE Class
(
    id_class SERIAL NOT NULL,
    name VARCHAR NOT NULL,
    PRIMARY KEY (id_class)
);

-- Insertion d'une liste de cours
INSERT INTO Class VALUES (DEFAULT, 'GEN101');
INSERT INTO Class VALUES (DEFAULT, 'GEN111');
INSERT INTO Class VALUES (DEFAULT, 'GEN122');
INSERT INTO Class VALUES (DEFAULT, 'GEN135');
INSERT INTO Class VALUES (DEFAULT, 'GEN136');
INSERT INTO Class VALUES (DEFAULT, 'GEN181');
INSERT INTO Class VALUES (DEFAULT, 'GEN145');
INSERT INTO Class VALUES (DEFAULT, 'GEN146');
INSERT INTO Class VALUES (DEFAULT, 'GEN170');
INSERT INTO Class VALUES (DEFAULT, 'GEN182');
INSERT INTO Class VALUES (DEFAULT, 'GEN124');
INSERT INTO Class VALUES (DEFAULT, 'GEN134');
INSERT INTO Class VALUES (DEFAULT, 'GEN137');


-- Creation de la table des groupes
CREATE TABLE Groupe
(
    id_group SERIAL NOT NULL,
    id_class INT NOT NULL,
    group_number VARCHAR NOT NULL,
    PRIMARY KEY (id_group, id_class),
    FOREIGN KEY (id_class) REFERENCES Class(id_class)
);

-- Insertion de groupes
INSERT INTO Groupe VALUES (DEFAULT, 2, '01');
INSERT INTO Groupe VALUES (DEFAULT, 2, '02');
INSERT INTO Groupe VALUES (DEFAULT, 2, '03');
INSERT INTO Groupe VALUES (DEFAULT, 2, '04');
INSERT INTO Groupe VALUES (DEFAULT, 3, '01');


-- Creation de la table des membres
CREATE TABLE Member
(
  cip VARCHAR NOT NULL,
  PRIMARY KEY (cip)
);

-- Insertion d'une liste de membres
INSERT INTO Member VALUES ('lavd2311');
INSERT INTO Member VALUES ('trus1706');
INSERT INTO Member VALUES ('bils2704');
INSERT INTO Member VALUES ('chab1704');
INSERT INTO Member VALUES ('lavm2134');
INSERT INTO Member VALUES ('bild2707');


-- Creation de la table des sessions
CREATE TABLE Session
(
    id_session SERIAL NOT NULL,
    name VARCHAR NOT NULL,
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP NOT NULL,
    PRIMARY KEY (id_session)
);

-- Insertion d'une liste de session
INSERT INTO Session VALUES (DEFAULT, 'Hiver', '2023-01-01 00:00:00', '2023-04-30 23:59:59');
INSERT INTO Session VALUES (DEFAULT, 'Ete', '2023-05-01 00:00:00', '2023-08-31 23:59:59');
INSERT INTO Session VALUES (DEFAULT, 'Automne', '2023-09-01 00:00:00', '2023-12-31 23:59:59');


-- Creation de la table des fichiers
CREATE TABLE File
(
    id_file SERIAL NOT NULL,
    path VARCHAR NOT NULL,
    name VARCHAR NOT NULL,
    PRIMARY KEY (id_file)
);

-- Insertion d'une liste de fichiers
INSERT INTO File VALUES (DEFAULT, '/file/dossier1/', 'Fichier 1');
INSERT INTO File VALUES (DEFAULT, '/file/dossier1/', 'Fichier 2');
INSERT INTO File VALUES (DEFAULT, '/file/dossier1/', 'Fichier 3');


-- Creation de la table des equipes
CREATE TABLE Team
(
    id_team SERIAL NOT NULL,
    nom_equipe VARCHAR NOT NULL,
    PRIMARY KEY (id_team)
);

-- Insertion d'une liste d'equipes
INSERT INTO Team VALUES (DEFAULT, 'Equipe 1');
INSERT INTO Team VALUES (DEFAULT, 'Equipe 2');
INSERT INTO Team VALUES (DEFAULT, 'Equipe 3');
INSERT INTO Team VALUES (DEFAULT, 'Equipe 4');
INSERT INTO Team VALUES (DEFAULT, 'Equipe 5');


-- Creation d'une table pour les travaux remis
CREATE TABLE Handed_assignment
(
    id_HandedAssignement SERIAL NOT NULL,
    handed_date TIMESTAMP NOT NULL,
    id_team INT NOT NULL,
    id_file INT NOT NULL,
    PRIMARY KEY (id_HandedAssignement),
    FOREIGN KEY (id_team) REFERENCES Team(id_team),
    FOREIGN KEY (id_file) REFERENCES File(id_file)
);

-- Insertion d'une liste de travaux remis
INSERT INTO Handed_assignment VALUES (DEFAULT, '2023-06-11 10:40:31', 2, 3);


-- Creation d'une table pour les roles (enseignant ou etudiant
CREATE TABLE Role
(
    id_role SERIAL NOT NULL,
    description VARCHAR NOT NULL,
    PRIMARY KEY (id_role)
);

-- Insertion de roles
INSERT INTO Role VALUES (DEFAULT, 'Enseignant');
INSERT INTO Role VALUES (DEFAULT, 'Etudiant');


-- Creation d'une table pour le type de remise (par un enseignant ou par un etudiant)
CREATE TABLE TypeRemise
(
    id_TypeRemise SERIAL NOT NULL,
    id_role INT NOT NULL,
    id_HandedAssignement INT NOT NULL,
    PRIMARY KEY (id_TypeRemise),
    FOREIGN KEY (id_HandedAssignement) REFERENCES Handed_assignment(id_HandedAssignement),
    FOREIGN KEY (id_role) REFERENCES Role(id_role)
);

-- Insertion d'une liste de travaux remis
INSERT INTO TypeRemise VALUES (DEFAULT, 1, 1);


-- Creation d'une table
CREATE TABLE GroupMember
(
    id_role INT NOT NULL,
    id_group INT NOT NULL,
    id_class INT NOT NULL,
    cip VARCHAR NOT NULL,
    PRIMARY KEY (id_group, id_class, cip),
    FOREIGN KEY (id_group, id_class) REFERENCES Groupe(id_group, id_class),
    FOREIGN KEY (cip) REFERENCES Member(cip),
    FOREIGN KEY (id_role) REFERENCES Role(id_role)
);

-- Insertion de membres dans des groupes
INSERT INTO GroupMember VALUES (1, 1, 2, 'lavd2311');
INSERT INTO GroupMember VALUES (2, 1, 2, 'trus1706');
INSERT INTO GroupMember VALUES (2, 2, 2, 'bild2707');
INSERT INTO GroupMember VALUES (1, 1, 2, 'bils2704');
INSERT INTO GroupMember VALUES (2, 1, 2, 'chab1704');
INSERT INTO GroupMember VALUES (2, 3, 2, 'lavm2134');


CREATE TABLE SessionClass
(
    id_session INT NOT NULL,
    id_class INT NOT NULL,
    PRIMARY KEY (id_session, id_class),
    FOREIGN KEY (id_session) REFERENCES Session(id_session),
    FOREIGN KEY (id_class) REFERENCES Class(id_class)
);

-- Insertion de class dans des session (ex: Gen101 et GEN 111 dans la session automne)
INSERT INTO SessionClass VALUES (3, 1);
INSERT INTO SessionClass VALUES (3, 2);
INSERT INTO SessionClass VALUES (3, 3);
INSERT INTO SessionClass VALUES (3, 4);
INSERT INTO SessionClass VALUES (3, 5);
INSERT INTO SessionClass VALUES (1, 4);
INSERT INTO SessionClass VALUES (1, 5);
INSERT INTO SessionClass VALUES (1, 2);
INSERT INTO SessionClass VALUES (2, 2);
INSERT INTO SessionClass VALUES (2, 10);


CREATE TABLE TeamMember
(
  id_team INT NOT NULL,
  cip VARCHAR NOT NULL,
  PRIMARY KEY (id_team, cip),
  FOREIGN KEY (id_team) REFERENCES Team(id_team),
  FOREIGN KEY (cip) REFERENCES Member(cip)
);

-- Insertion de membres dans des equipes
INSERT INTO TeamMember VALUES (1, 'lavd2311');
INSERT INTO TeamMember VALUES (1, 'trus1706');
INSERT INTO TeamMember VALUES (1, 'bild2707');
INSERT INTO TeamMember VALUES (2, 'bils2704');
INSERT INTO TeamMember VALUES (2, 'chab1704');
INSERT INTO TeamMember VALUES (3, 'lavm2134');


-- Creation d'une table de travaux
CREATE TABLE Assignment
(
    id_assignement SERIAL NOT NULL,
    name VARCHAR NOT NULL,
    description VARCHAR NOT NULL,
    due_date TIMESTAMP NOT NULL,
    close_date TIMESTAMP NOT NULL,
    available_date TIMESTAMP NOT NULL,
    team_size INT NOT NULL,
    id_group INT NOT NULL,
    id_class INT NOT NULL,
    PRIMARY KEY (id_assignement),
    FOREIGN KEY (id_group, id_class) REFERENCES Groupe(id_group, id_class)
);

-- Insertion de travaux cree par les enseignants
INSERT INTO Assignment VALUES (DEFAULT, 'Travail 1', 'Instructions 1', '2023-06-24 23:59:59', '2023-06-24 23:59:59', '2023-06-10 00:00:00', 2, 1, 2);


-- Creation d'une table de fichier dans travaux
CREATE TABLE AssignementFile
(
  id_file INT NOT NULL,
  id_assignement INT NOT NULL,
  PRIMARY KEY (id_file, id_assignement),
  FOREIGN KEY (id_file) REFERENCES File(id_file),
  FOREIGN KEY (id_assignement) REFERENCES Assignment(id_assignement)
);

-- Insertion de fichier dans des travaux
--INSERT INTO AssignementFile VALUES (1, 2);
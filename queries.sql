-- SCRIPT DE REQUETES SQL UTILE


-- EXEMPLE
-- Liste des sessions dans lesquelles un membre a ete actif

-- Liste des sessions en tant qu'etudiant pour le membre 'dava2957'
SELECT session_name
FROM CoursMembre
WHERE cip = 'dava2957' AND
             role_name = 'Etudiant'
GROUP BY session_name;

-- Liste des sessions en tant qu'enseignant pour le membre 'turs2482'
SELECT session_name
FROM CoursMembre
WHERE cip = 'turs2482' AND
             role_name = 'Enseignant'
GROUP BY session_name;

-- EXEMPLE
-- Liste des cours du membre 'dava2957' a la session 'A22'
SELECT class_name
FROM CoursMembre
WHERE session_name = 'A22' AND
                     cip = 'dava2957';


-- Liste des cours de la session 'E23' pour le membre 'dava2957' en tant qu'etudiant
SELECT class_name, class_description
FROM CoursMembre
WHERE session_name = 'E23' AND
                     cip = 'dava2957' AND
                     role_name = 'Etudiant';



-- EXEMPLE
-- Liste des travaux par cours

-- Liste des travaux pour le cours GIF302 suivi à l'été 2023 par le membre dava2957
SELECT assignment_name
FROM CoursMembre
WHERE cip = 'dava2957' AND
             session_name = 'E23' AND
             class_name = 'GIF302'
GROUP BY assignment_name;

-- Liste des informations sur le travail 'Memoire d'approbation de projet' pour le cours GIF302 suivi à l'été 2023 par le membre dava2957
SELECT assignment_name, description, due_date, close_date, available_date, team_size
FROM CoursMembre
WHERE cip = 'dava2957' AND
      session_name = 'E23' AND
      class_name = 'GIF302' AND
      assignment_name = 'Memoire d''approbation de projet';

-- Liste des professeurs pour un cours suivi par un membre
SELECT cip
FROM coursmembre
WHERE role_name = 'Enseignant' AND
      id_group = (SELECT id_group
                  FROM coursmembre
                  WHERE cip = 'dava2957' AND
                        session_name = 'E23' AND
                        class_name = 'GIF302'
                  GROUP BY id_group)
GROUP BY cip;



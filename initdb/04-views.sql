-- Creation des vues utiles
    
CREATE VIEW SessionRole as
SELECT s.name as SessionNom, r.name as RoleName, gm.cip as Cip
	FROM SESSION AS S
		INNER JOIN sessionclass sc on S.id_session = sc.id_session
		INNER JOIN class c on c.id_class = sc.id_class
		INNER JOIN groupe as g ON c.id_class = g.id_class
		INNER JOIN groupmember gm on g.id_group = gm.id_group
		INNER JOIN role r on gm.id_role = r.id_role
			group by s.name, r.name, gm.cip;
    
--CREATE VIEW Equipe as
--SELECT tm.id_team as idEquipe, ne.name as NomDequipe, s.id_session as session, g.id_group as groupe, --t.id_assignment as assignement,  m.cip as Cip
--FROM member AS m
--         INNER JOIN teammember tm on m.cip = tm.cip
--         INNER JOIN team t on tm.id_team = t.id_team
--         INNER JOIN nomequipe as ne on t.id_team = ne.id_nomequipe
--         INNER JOIN assignment a on t.id_assignment = a.id_assignment
--         INNER JOIN groupe as g ON a.id_group = g.id_group
--         INNER JOIN session s on g.id_session = s.id_session
--order by  tm.id_team, ne.name, m.cip, s.id_session, g.id_group, t.id_assignment;



-- View get the class list of a student at a particular session with the list of assignment for each course.
CREATE VIEW StudentClass AS
SELECT class.description AS ClassDescription, s2.path AS Session, g2.cip AS CIP, a.id_group, a.name AS AssignmentName, a.due_date, a.close_date, a.available_date
FROM class
INNER JOIN sessionclass s on class.id_class = s.id_class
INNER JOIN session s2 on s2.id_session = s.id_session
INNER JOIN groupe g on class.id_class = g.id_class
INNER JOIN groupmember g2 on g.id_group = g2.id_group
INNER JOIN assignment a on g.id_group = a.id_group;
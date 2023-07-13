-- Creation des vues utiles
    
CREATE VIEW SessionRole as
SELECT s.name as SessionNom, r.name as RoleName, gm.cip as Cip
	FROM SESSION AS S
		INNER JOIN sessionclass sc on S.id_session = sc.id_session
		INNER JOIN class c on c.id_class = sc.id_class
		INNER JOIN groupe as g ON c.id_class = g.id_class
		INNER JOIN groupmember gm on g.id_group = gm.id_group
		INNER JOIN role r on gm.id_role = r.id_role
			group by s.name, r.name, gm.cip

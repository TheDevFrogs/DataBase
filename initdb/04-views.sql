-- Creation des vues utiles
    
CREATE VIEW SessionRole as
SELECT s.id_session as id_session, s.name as SessionNom,r.id_role as id_role ,r.name as RoleName, gm.cip as Cip
FROM SESSION AS S
         INNER JOIN sessionclass sc on S.id_session = sc.id_session
         INNER JOIN class c on c.id_class = sc.id_class
         INNER JOIN groupe as g ON c.id_class = g.id_class
         INNER JOIN groupmember gm on g.id_group = gm.id_group
         INNER JOIN role r on gm.id_role = r.id_role
group by s.name, r.name, gm.cip, s.id_session, r.id_role;
			
CREATE VIEW GroupMemberAndInformations as
    SELECT g.id_group as id_group, c.description as name, c.id_class as classTag, g.no_group
    FROM groupmember as gm
    INNER JOIN groupe as g on g.id_group = gm.id_group
    INNER JOIN session s on g.id_session = s.id_session
    INNER JOIN role as r on r.id_role = gm.id_role
    INNER JOIN class c on g.id_class = c.id_class
    


-- Creation des vues utiles

-- Liste des cours par session pour un membre
CREATE VIEW CoursMembre AS
    SELECT s.id_session, s.name AS session_name,
           c.id_class, c.name AS class_name, c.description AS class_description,
           gr.id_group, nogr.no_group, nogr.name, grmem.cip,
           r.id_role, r.name AS role_name,
           a.id_assignment, a.name AS assignment_name, a.description, a.due_date, a.close_date, a.available_date, a.team_size
    FROM groupe gr
    JOIN session s on gr.id_session = s.id_session
    JOIN class c on gr.id_class = c.id_class
    JOIN groupmember grmem on gr.id_group = grmem.id_group
    JOIN role r on grmem.id_role = r.id_role
    JOIN nogroup nogr on gr.id_nogroup = nogr.id_nogroup
    JOIN assignment a on gr.id_group = a.id_group;

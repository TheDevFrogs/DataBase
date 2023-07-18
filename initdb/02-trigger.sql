--Trigger to make sure a student is not in two different groups of the same class of the same year
CREATE OR REPLACE FUNCTION trigger_insertion_groupmember()
    RETURNS TRIGGER
    LANGUAGE PLPGSQL
AS
$$
BEGIN
    --Verifier si l'etudiant fait deja partis d'un de ces cours dans une autre classe
    --de la meme annee
    IF (SELECT 1
        from groupe as g
                 INNER JOIN (
            SELECT id_session, id_class
            FROM groupe
            where groupe.id_group = NEW.id_group
        ) AS memberclass on memberclass.id_class = g.id_class AND memberclass.id_session = g.id_session
                 INNER JOIN groupmember as gm on gm.id_group = g.id_group
                 INNER JOIN role as r on gm.id_role = r.id_role
        WHERE gm.cip = NEW.cip and r.name = 'Etudiant') THEN
        RAISE EXCEPTION 'Student is already in this class in an other group %' , NEW.cip;
    END IF;
    RETURN NEW;
END
$$;

CREATE OR REPLACE FUNCTION trigger_insertion_team()
    RETURNS TRIGGER
    LANGUAGE PLPGSQL
AS
$$
BEGIN
    NEW.NO_EQUIPE = (SELECT COALESCE( 
    (SELECT t.no_equipe
    FROM team as t
    WHERE t.id_assignment = NEW.id_assignment
    ORDER BY t.no_equipe DESC
    LIMIT 1),0) + 1);

    RETURN NEW;
END
$$;



CREATE TRIGGER groupmember_insert
    BEFORE INSERT
    ON GroupMember
    FOR EACH ROW
EXECUTE PROCEDURE trigger_insertion_groupmember();

CREATE TRIGGER groupmember_insert
    BEFORE INSERT
    ON Team
    FOR EACH ROW
EXECUTE PROCEDURE trigger_insertion_team();

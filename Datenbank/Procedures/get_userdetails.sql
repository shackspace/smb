CREATE OR REPLACE FUNCTION public.get_userdetails(p_user_id integer)
 RETURNS text
 LANGUAGE plpgsql
AS $function$DECLARE
   v_userdetails TEXT;
BEGIN
SELECT row_to_json(q)
  INTO v_userdetails
  FROM (SELECT id,
               uuid,
               user_prename,
               user_name,
               username,
               user_create_date,
               user_create_user_id
          FROM users
         WHERE id = $1
       ) q;
          
   RETURN v_userdetails;
END;$function$


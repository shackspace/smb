CREATE OR REPLACE FUNCTION public.get_username(p_user_id integer)
 RETURNS text
 LANGUAGE plpgsql
AS $function$DECLARE
   v_user_username TEXT;
BEGIN
   SELECT username
     INTO v_user_username
     FROM public.users
    WHERE id = $1;
   
   RETURN v_user_username;
END;$function$


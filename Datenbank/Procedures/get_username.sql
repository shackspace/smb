CREATE OR REPLACE FUNCTION public.get_username(p_user_id integer)
 RETURNS text
 LANGUAGE plpgsql
AS $function$DECLARE
   v_user_username TEXT;
BEGIN
   SELECT user_username
     INTO v_user_username
     FROM public.user
    WHERE user_id = $1;
   
   RETURN v_user_username;
END;$function$


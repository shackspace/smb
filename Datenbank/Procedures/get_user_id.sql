CREATE OR REPLACE FUNCTION public.get_user_id(p_uuid text)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$DECLARE
   v_user_id INTEGER;
BEGIN
   SELECT id
     INTO v_user_id
     FROM public.users
    WHERE uuid = $1;
   
   RETURN v_user_id;
END;$function$


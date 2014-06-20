CREATE OR REPLACE FUNCTION public.get_uuid(p_user_id integer)
 RETURNS text
 LANGUAGE plpgsql
AS $function$DECLARE
   v_uuid TEXT;
BEGIN
   SELECT uuid
     INTO v_uuid
     FROM public.users
    WHERE id = $1;
   
   RETURN v_uuid;
END;$function$


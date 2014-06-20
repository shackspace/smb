CREATE OR REPLACE FUNCTION public.is_authorized(p_access_token text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$DECLARE
   v_uuid TEXT;
BEGIN
   SELECT uuid
     INTO v_uuid
     FROM oauth_access_tokens  
    WHERE access_token = $3
      AND expires > now();
   
   IF v_uuid IS null THEN    
      RETURN true;
   ELSE
      RETURN false;
   END IF;
END;$function$


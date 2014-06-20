CREATE OR REPLACE FUNCTION public.create_transaction(p_acco_id_src integer, p_acco_id_dest integer, p_token_id_src text, p_amount numeric, p_description text, p_curr_id integer DEFAULT NULL::integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$DECLARE
   v_curr_id INTEGER;
   v_tran_id INTEGER;
   v_uuid    TEXT;
BEGIN

   IF is_authorized(p_token_id_src) THEN
  
      IF p_curr_id IS null THEN

         /* TODO: Default-Currency definieren */
         SELECT min(curr_id)
           INTO v_curr_id
           FROM public.currency;
      END IF;
   
      INSERT INTO transaction(tran_acco_id_src,
                              tran_acco_id_dest,
                              tran_amount,
                              tran_description,
                              tran_curr_id)
           VALUES (p_acco_id_src,
                   p_acco_id_dest,
                   p_amount,
                   p_description,
                   p_curr_id)
        RETURNING tran_id INTO v_tran_id;
   
      RETURN v_tran_id;
   
   ELSE
      RETURN null;
   END IF;
   
   
END;$function$
	
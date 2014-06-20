CREATE OR REPLACE FUNCTION public.create_transaction(p_user_id_src integer, p_user_id_dest integer, p_amount integer, p_description integer, p_curr_id integer DEFAULT NULL::integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$DECLARE
   v_curr_id INTEGER;
   v_tran_id INTEGER;
BEGIN

/* TODO: Verifizieren, dass der aktuelle User das auch darf.. */

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
        VALUES (p_user_id_src,
                p_user_id_dest,
                p_amount,
                p_description,
                p_curr_id)
     RETURNING tran_id INTO v_tran_id;
   
   RETURN v_tran_id;
END;$function$


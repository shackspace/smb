CREATE
  TABLE account
  (
    acco_id             SERIAL NOT NULL ,
    acco_name           TEXT ,
    acco_create_date    DATE ,
    acco_create_user_id INTEGER
  ) ;
ALTER TABLE account ADD CONSTRAINT account_PK PRIMARY KEY ( acco_id ) ;

CREATE
  TABLE currency
  (
    curr_id             SERIAL NOT NULL ,
    curr_name           VARCHAR (2000) NOT NULL ,
    curr_create_date    DATE ,
    curr_create_user_id INTEGER NOT NULL
  ) ;
ALTER TABLE currency ADD CONSTRAINT currency_PK PRIMARY KEY ( curr_id ) ;

CREATE
  TABLE "transaction"
  (
    tran_id             SERIAL NOT NULL ,
    tran_acco_id_src    INTEGER NOT NULL ,
    tran_acco_id_dest   INTEGER NOT NULL ,
    tran_amount         NUMERIC NOT NULL ,
    tran_description    VARCHAR (2000) ,
    tran_curr_id        INTEGER NOT NULL ,
    tran_create_date    DATE ,
    tran_create_user_id INTEGER
  ) ;
ALTER TABLE "transaction" ADD CONSTRAINT transaction_PK PRIMARY KEY ( tran_id )
;

CREATE
  TABLE transaction_relation
  (
    trre_id             SERIAL NOT NULL ,
    trre_tran_id_src    INTEGER NOT NULL ,
    trre_tran_id_dest   INTEGER NOT NULL ,
    trre_create_date    DATE ,
    trre_create_user_id INTEGER NOT NULL
  ) ;
ALTER TABLE transaction_relation ADD CONSTRAINT transaction_relation_PK PRIMARY
KEY ( trre_id ) ;

CREATE
  TABLE users
  (
    id             SERIAL NOT NULL ,
    uuid       TEXT NOT NULL,
    user_prename        TEXT NOT NULL ,
    user_name           TEXT NOT NULL ,
    username         TEXT NOT NULL ,
    password       VARCHAR NOT NULL ,
    user_create_date    DATE ,
    user_create_user_id INTEGER
  ) ;
ALTER TABLE users ADD CONSTRAINT user_PK PRIMARY KEY ( id ) ;

CREATE
  TABLE user_account
  (
    usac_id             SERIAL NOT NULL ,
    usac_user_id        INTEGER NOT NULL ,
    usac_acco_id        INTEGER NOT NULL ,
    usac_create_date    DATE ,
    usac_create_user_id INTEGER
  ) ;
ALTER TABLE user_account ADD CONSTRAINT user_account_PK PRIMARY KEY ( usac_id )
;

ALTER TABLE "transaction" ADD CONSTRAINT transaction_account_FK FOREIGN KEY (
tran_acco_id_src ) REFERENCES account ( acco_id ) ;

ALTER TABLE "transaction" ADD CONSTRAINT transaction_account_FKv1 FOREIGN KEY (
tran_acco_id_dest ) REFERENCES account ( acco_id ) ;

ALTER TABLE "transaction" ADD CONSTRAINT transaction_currency_FK FOREIGN KEY (
tran_curr_id ) REFERENCES currency ( curr_id ) ;

ALTER TABLE transaction_relation ADD CONSTRAINT
transaction_relation_transaction_FK FOREIGN KEY ( trre_tran_id_src ) REFERENCES
"transaction" ( tran_id );

ALTER TABLE transaction_relation ADD CONSTRAINT
transaction_relation_transaction_FKv1 FOREIGN KEY ( trre_tran_id_dest )
REFERENCES "transaction" ( tran_id );

ALTER TABLE user_account ADD CONSTRAINT user_account_account_FK FOREIGN KEY (
usac_acco_id ) REFERENCES account ( acco_id );

ALTER TABLE user_account ADD CONSTRAINT user_account_user_FK FOREIGN KEY (
usac_user_id ) REFERENCES users ( id ) ;

CREATE TABLE oauth_access_tokens (
    access_token text NOT NULL,
    client_id text NOT NULL,
    user_id text NOT NULL,
    expires timestamp without time zone NOT NULL
);

CREATE TABLE oauth_clients (
    client_id text NOT NULL,
    client_secret text NOT NULL,
    redirect_uri text NOT NULL
);

CREATE TABLE oauth_refresh_tokens (
    refresh_token text NOT NULL,
    client_id text NOT NULL,
    user_id text NOT NULL,
    expires timestamp without time zone NOT NULL
);


ALTER TABLE ONLY oauth_access_tokens
    ADD CONSTRAINT oauth_access_tokens_pkey PRIMARY KEY (access_token);

ALTER TABLE ONLY oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (client_id, client_secret);

ALTER TABLE ONLY oauth_refresh_tokens
    ADD CONSTRAINT oauth_refresh_tokens_pkey PRIMARY KEY (refresh_token);


--
-- Name: users_username_password; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX users_username_password ON users USING btree (username, password);


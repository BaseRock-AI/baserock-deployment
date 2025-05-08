CREATE TABLE IF NOT EXISTS github_app_installations (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    acc_id VARCHAR(255) NOT NULL,
    acc_type VARCHAR(255) NOT NULL,
    installation_id INTEGER NOT NULL,
    access_token TEXT NOT NULL,
    type VARCHAR(255) NOT NULL,
    token_expires TIMESTAMP NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

ALTER TABLE IF EXISTS public.github_app_installations
    OWNER to ${POSTGRES_USERNAME};

GRANT ALL ON TABLE public.github_app_installations TO ${POSTGRES_USERNAME};

CREATE TABLE IF NOT EXISTS oauth_states (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    org_id VARCHAR(255) NOT NULL,
    state VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

ALTER TABLE IF EXISTS public.oauth_states
    OWNER to ${POSTGRES_USERNAME};

GRANT ALL ON TABLE public.oauth_states TO ${POSTGRES_USERNAME};

CREATE DATABASE todo;

CREATE TABLE IF NOT EXISTS public.to_do_item
(
    id bigint NOT NULL,
    completed boolean NOT NULL,
    name character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT to_do_item_pkey PRIMARY KEY (id)
) TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.to_do_item
    OWNER to ${POSTGRES_USERNAME};

CREATE SEQUENCE IF NOT EXISTS public.to_do_item_seq
    INCREMENT 50
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.to_do_item_seq
    OWNER TO ${POSTGRES_USERNAME};

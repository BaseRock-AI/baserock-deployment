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

CREATE TABLE IF NOT EXISTS public.organization
(
    id uuid NOT NULL DEFAULT gen_random_uuid(),
    type character varying(255),
    created_time bigint NOT NULL DEFAULT extract(epoch from now()),
    last_updated_time bigint NOT NULL DEFAULT extract(epoch from now()),
    name character varying(255),
    license_type character varying(30),
    expiry_time bigint,
    status character varying(30),
    no_of_license integer,
    enterprise_license_user_count integer DEFAULT 0,
    non_enterprise_license_user_count integer DEFAULT 0,
    enable_codeless_testing boolean DEFAULT true,
    use_llm boolean DEFAULT true,
    obfuscate_code boolean DEFAULT false,
    llm_api_key character varying(1000),
    llm_api_key_type character varying(50),
    CONSTRAINT organization_pkey PRIMARY KEY (id)
) TABLESPACE pg_default;

-- Create index on llm_api_key_type for better query performance
CREATE INDEX IF NOT EXISTS idx_organization_llm_api_key_type ON public.organization(llm_api_key_type);

ALTER TABLE IF EXISTS public.organization
    OWNER to ${POSTGRES_USERNAME};

GRANT ALL ON TABLE public.organization TO ${POSTGRES_USERNAME};

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

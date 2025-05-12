CREATE TYPE email_verification_status AS ENUM('SENT', 'VERIFIED');
CREATE TABLE IF NOT EXISTS public.email_login_user_info
(
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    access_token uuid,
    email character varying(255) COLLATE pg_catalog."default",
    email_token uuid,
    email_token_expiry_time bigint NOT NULL,
    name character varying(255) COLLATE pg_catalog."default",
    status smallint,
    machine_id character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT email_login_user_info_pkey PRIMARY KEY (id)
    )

    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.email_login_user_info
    OWNER to postgres;
GRANT ALL ON TABLE public.email_login_user_info TO postgres;
CREATE TABLE IF NOT EXISTS public.files
(
    id uuid NOT NULL DEFAULT gen_random_uuid(),
    content_type character varying(255) COLLATE pg_catalog."default",
    data oid,
    lob character varying(255) COLLATE pg_catalog."default",
    name character varying(255) COLLATE pg_catalog."default",
    size bigint NOT NULL,
    CONSTRAINT files_pkey PRIMARY KEY (id)
    )

    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.files
    OWNER to postgres;
GRANT ALL ON TABLE public.files TO postgres;

CREATE TABLE IF NOT EXISTS public.help_requests
(
    id uuid NOT NULL DEFAULT gen_random_uuid(),
    category character(50) COLLATE pg_catalog."default" NOT NULL,
    subject text COLLATE pg_catalog."default",
    description text COLLATE pg_catalog."default",
    user_id uuid,
    attachmentid uuid,
    attachment_id uuid,
    CONSTRAINT help_requests_pkey PRIMARY KEY (id)
    )

    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.help_requests
    OWNER to postgres;

GRANT ALL ON TABLE public.help_requests TO postgres;
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
    CONSTRAINT organization_pkey PRIMARY KEY (id)
    ) TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.usage_credit_limit_codeless
    OWNER to postgres;

GRANT ALL ON TABLE public.usage_credit_limit_codeless TO postgres;


CREATE TABLE IF NOT EXISTS public."user"
(
    id uuid NOT NULL DEFAULT gen_random_uuid(),
    org_id uuid NOT NULL,
    created_time bigint NOT NULL DEFAULT extract(epoch from now()),
    email_id character varying(255) COLLATE pg_catalog."default",
    last_updated_time bigint NOT NULL,
    name character varying(255) COLLATE pg_catalog."default",
    provider_identifier character(255) COLLATE pg_catalog."default",
    status character varying(30) COLLATE pg_catalog."default",
    o_auth_token_id character varying(255) COLLATE pg_catalog."default",
    plugin_token_id character varying(255) COLLATE pg_catalog."default",
    last_login_time bigint,
    machine_id character varying(255) COLLATE pg_catalog."default",
    new_user boolean DEFAULT true,
    CONSTRAINT user_pkey PRIMARY KEY (id),
    CONSTRAINT user_email_unique UNIQUE (email_id)
    )

    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."user"
    OWNER to postgres;
GRANT ALL ON TABLE public."user" TO postgres;
CREATE TABLE IF NOT EXISTS public.user_group
(
    id uuid NOT NULL DEFAULT gen_random_uuid(),
    access_type character varying(255) COLLATE pg_catalog."default",
    created_time bigint NOT NULL,
    info character varying(255) COLLATE pg_catalog."default",
    role character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT user_group_pkey PRIMARY KEY (id)
    )

    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.user_group
    OWNER to postgres;

GRANT ALL ON TABLE public.user_group TO postgres;


CREATE TABLE IF NOT EXISTS public.user_invite
(
    id uuid NOT NULL DEFAULT gen_random_uuid(),
    created_time bigint NOT NULL,
    email character varying(255) COLLATE pg_catalog."default",
    updated_time bigint NOT NULL,
    invite_status character varying(30) COLLATE pg_catalog."default",
    message text COLLATE pg_catalog."default",
    notification_count integer,
    inviter_id uuid,
    next_notification_retry_after bigint NOT NULL DEFAULT 0,
    CONSTRAINT user_invite_pkey PRIMARY KEY (id),
    CONSTRAINT fk8g7fbeh1sogewc3yeskpjuw0y FOREIGN KEY (inviter_id)
    REFERENCES public."user" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    )

    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.user_invite OWNER to postgres;

GRANT ALL ON TABLE public.user_invite TO postgres;
CREATE TABLE IF NOT EXISTS public.marketing_events
(
    id uuid NOT NULL DEFAULT gen_random_uuid(),
    user_id uuid,
    event character varying(255) COLLATE pg_catalog."default",
    status character varying(255) COLLATE pg_catalog."default",
    description character varying(255) COLLATE pg_catalog."default",
    created_time timestamp with time zone DEFAULT timezone('PST'::text, CURRENT_TIMESTAMP),
    updated_time timestamp with time zone DEFAULT timezone('PST'::text, CURRENT_TIMESTAMP),
    CONSTRAINT marketing_events_pkey PRIMARY KEY (id),
    CONSTRAINT user_fkey FOREIGN KEY (user_id)
    REFERENCES public."user" (id) MATCH SIMPLE
                           ON UPDATE NO ACTION
                           ON DELETE NO ACTION
    )

    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.marketing_events
    OWNER to postgres;

GRANT ALL ON TABLE public.marketing_events TO postgres;
INSERT INTO public.user_group(
    id, access_type, created_time, info, role)
VALUES (gen_random_uuid(), 'DOMAIN_NAME', 0 , 'baserock.ai', 'ADMIN');

CREATE TABLE IF NOT EXISTS public.token
(
    id uuid NOT NULL,
    token text COLLATE pg_catalog."default",
    refresh_token text COLLATE pg_catalog."default",
    expiry_time bigint,
    created_time bigint NOT NULL,
    updated_time bigint NOT NULL,
    type text COLLATE pg_catalog."default",
    encrypted_refresh_token text COLLATE pg_catalog."default",
    encrypted_token text COLLATE pg_catalog."default",
    license_type text COLLATE pg_catalog."default" DEFAULT 'FREEMIUM'::text,
    CONSTRAINT token_pkey PRIMARY KEY (id)
    )

    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.token
    OWNER to postgres;

GRANT ALL ON TABLE public.token TO postgres;

CREATE TABLE IF NOT EXISTS public.org_usage_statistic
(
    id uuid NOT NULL,
    org_id uuid,
    event_date DATE,
    number_of_lines_of_code bigint NOT NULL DEFAULT 0,
    number_of_lines_of_code_covered bigint NOT NULL DEFAULT 0,
    number_of_test_cases bigint NOT NULL DEFAULT 0
)

    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.org_usage_statistic
    OWNER to postgres;

GRANT ALL ON TABLE public.org_usage_statistic TO postgres;
CREATE TABLE IF NOT EXISTS public.usage_statistic
(
    id uuid NOT NULL,
    last_updated_time bigint NOT NULL,
    number_of_lines_of_code bigint NOT NULL,
    number_of_lines_of_code_covered bigint NOT NULL DEFAULT 0,
    number_of_test_cases bigint NOT NULL,
    type smallint,
    user_id uuid,
    CONSTRAINT usage_statistic_pkey PRIMARY KEY (id),
    CONSTRAINT uki52oak79wcu2lixgscs2bsmsi UNIQUE (user_id, type),
    CONSTRAINT fkbk8b49vxqswfrgxrhml9qpnl5 FOREIGN KEY (user_id)
        REFERENCES public."user" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.usage_statistic
    OWNER to postgres;

GRANT ALL ON TABLE public.usage_statistic TO postgres;

CREATE INDEX IF NOT EXISTS idxdb3qr53pmy0hfb41olwri7e96
    ON public.usage_statistic USING btree
    (user_id ASC NULLS LAST)
    TABLESPACE pg_default;
CREATE TABLE IF NOT EXISTS public.usage_credit_limit
(
    id uuid NOT NULL,
    created_time bigint,
    expiry_time bigint,
    last_updated_time bigint,
    org_id uuid,
    start_time bigint,
    updated boolean,
    credit_limit bigint NOT NULL DEFAULT 0,
    max_credits bigint,
    CONSTRAINT usage_credit_limit_pkey PRIMARY KEY (id)
    )

    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.usage_credit_limit
    OWNER to postgres;

GRANT ALL ON TABLE public.usage_credit_limit TO postgres;
CREATE TABLE IF NOT EXISTS public.usage_credit_limit_codeless
(
    id uuid NOT NULL DEFAULT gen_random_uuid(),
    created_time bigint,
    credit_limit bigint,
    expiry_time bigint,
    last_updated_time bigint,
    max_credits bigint,
    org_id uuid,
    start_time bigint,
    updated boolean,
    CONSTRAINT usage_credit_limit_codeless_pkey PRIMARY KEY (id)
    )

    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.usage_credit_limit_codeless
    OWNER to postgres;

GRANT ALL ON TABLE public.usage_credit_limit_codeless TO postgres;



CREATE TABLE IF NOT EXISTS public.rate_limit
(
    id                uuid   NOT NULL DEFAULT gen_random_uuid(),
    entity_id         uuid   NOT NULL,
    entity_type       smallint,
    max_limit         bigint,
    created_time      bigint NOT NULL DEFAULT extract(epoch from now()),
    updated_time bigint NOT NULL DEFAULT extract(epoch from now()),
    CONSTRAINT rate_limit_pkey PRIMARY KEY (id),
    CONSTRAINT rate_limit_entity_id_unique UNIQUE (entity_id)
    )
    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.rate_limit OWNER to postgres;

GRANT ALL ON TABLE public.rate_limit TO postgres;

CREATE TABLE IF NOT EXISTS public.api_key
(
    id uuid NOT NULL,
    api_key_token character varying(255) COLLATE pg_catalog."default",
    creation_date timestamp(6) without time zone,
    description character varying(255) COLLATE pg_catalog."default",
    expiry_date timestamp(6) without time zone,
    name character varying(255) COLLATE pg_catalog."default",
    role character varying(255) COLLATE pg_catalog."default",
    service_account_id uuid,
    CONSTRAINT api_key_pkey PRIMARY KEY (id)
    )

    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.api_key OWNER to postgres;

GRANT ALL ON TABLE public.api_key TO postgres;
CREATE TABLE IF NOT EXISTS public.service_account
(
    service_account_id uuid NOT NULL,
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    org_id uuid NOT NULL,
    CONSTRAINT service_account_pkey PRIMARY KEY (service_account_id),
    CONSTRAINT uk_31da08ct9xr5bm7spwvx90efr UNIQUE (name)
    )

    TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.service_account
    OWNER to postgres;

GRANT ALL ON TABLE public.service_account TO postgres;


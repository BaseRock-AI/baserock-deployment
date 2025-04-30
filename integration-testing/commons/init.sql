CREATE TABLE IF NOT EXISTS github_app_installations (                                              name VARCHAR(255) NOT NULL,
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

-- +goose Up
CREATE TABLE organization (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT NOT NULL DEFAULT '',

    created_at TIMESTAMP(0) with time zone NOT NULL DEFAULT NOW(),
    active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    email TEXT NOT NULL UNIQUE,
    hashed_password TEXT NOT NULL,
    last_login TIMESTAMP NOT NULL,

    created_at TIMESTAMP(0) with time zone NOT NULL DEFAULT NOW(),
    active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE sessions (
    id BIGSERIAL PRIMARY KEY,
    token_hash TEXT NOT NULL,
    user_id BIGINT NOT NULL,

    created_at TIMESTAMP(0) with time zone NOT NULL DEFAULT NOW(),
    active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE organization_users (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    organization_id BIGINT NOT NULL,
    roles TEXT NOT NULL,

    created_at TIMESTAMP(0) with time zone NOT NULL DEFAULT NOW(),
    active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE events (
    id BIGSERIAL PRIMARY KEY,
    organization_id BIGINT NOT NULL,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    capacity BIGINT NOT NULL,
    date TIMESTAMP NOT NULL,
    duration BIGINT NOT NULL,
    venue TEXT NOT NULL,
    is_online BOOLEAN NOT NULL,
    meeting_link TEXT NOT NULL,

    created_at TIMESTAMP(0) with time zone NOT NULL DEFAULT NOW(),
    active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE interests (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    category_id BIGINT NOT NULL,

    created_at TIMESTAMP(0) with time zone NOT NULL DEFAULT NOW(),
    active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE favorites (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    event_id BIGINT NOT NULL,

    created_at TIMESTAMP(0) with time zone NOT NULL DEFAULT NOW(),
    active BOOLEAN NOT NULL DEFAULT TRUE
);


CREATE TABLE event_categories (
    id BIGSERIAL PRIMARY KEY,
    category_id BIGINT NOT NULL,
    event_id BIGINT NOT NULL,

    created_at TIMESTAMP(0) with time zone NOT NULL DEFAULT NOW(),
    active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE categories (
    id BIGSERIAL PRIMARY KEY,
    name TEXT NOT NULL,

    created_at TIMESTAMP(0) with time zone NOT NULL DEFAULT NOW(),
    active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE event_registers (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    event_id BIGINT NOT NULL,
    did_attend BOOLEAN NOT NULL,

    created_at TIMESTAMP(0) with time zone NOT NULL DEFAULT NOW(),
    active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE reviews (
    id BIGSERIAL PRIMARY KEY,
    author_id BIGINT NOT NULL,
    event_id BIGINT NOT NULL,
    rating BIGINT NOT NULL,
    comment TEXT NOT NULL,

    created_at TIMESTAMP(0) with time zone NOT NULL DEFAULT NOW(),
    active BOOLEAN NOT NULL DEFAULT TRUE
);

ALTER TABLE sessions ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE favorites ADD CONSTRAINT favorites_event_id_fkey FOREIGN KEY (event_id) REFERENCES events(id);
ALTER TABLE interests ADD CONSTRAINT interests_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE organization_users ADD CONSTRAINT organization_users_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE event_categories ADD CONSTRAINT event_categories_event_id_fkey FOREIGN KEY (event_id) REFERENCES events(id);
ALTER TABLE interests ADD CONSTRAINT interests_category_id_fkey FOREIGN KEY (category_id) REFERENCES categories(id);
ALTER TABLE event_registers ADD CONSTRAINT event_registers_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE event_registers ADD CONSTRAINT event_registers_event_id_fkey FOREIGN KEY (event_id) REFERENCES events(id);
ALTER TABLE reviews ADD CONSTRAINT reviews_event_id_fkey FOREIGN KEY (event_id) REFERENCES events(id);
ALTER TABLE favorites ADD CONSTRAINT favorites_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE organization_users ADD CONSTRAINT organization_users_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES organization(id);
ALTER TABLE event_categories ADD CONSTRAINT event_categories_category_id_fkey FOREIGN KEY (category_id) REFERENCES categories(id);
ALTER TABLE reviews ADD CONSTRAINT reviews_author_id_fkey FOREIGN KEY (author_id) REFERENCES users(id);

-- +goose Down
DROP TABLE users;
DROP TABLE sessions;

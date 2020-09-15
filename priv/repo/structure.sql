--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE accounts_users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255),
    is_admin boolean DEFAULT false NOT NULL,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: accounts_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE accounts_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: accounts_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE accounts_users_id_seq OWNED BY accounts_users.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp without time zone
);


--
-- Name: stash_channels; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE stash_channels (
    id integer NOT NULL,
    team_id integer,
    name character varying(255),
    provider_id character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: stash_channels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE stash_channels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stash_channels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE stash_channels_id_seq OWNED BY stash_channels.id;


--
-- Name: stash_links; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE stash_links (
    id integer NOT NULL,
    team_id integer,
    link character varying(255),
    link_message character varying(255),
    link_service_name character varying(255),
    text_message character varying(255),
    time_stamp timestamp without time zone,
    poster_id integer,
    channel_id integer,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: stash_links_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE stash_links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stash_links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE stash_links_id_seq OWNED BY stash_links.id;


--
-- Name: stash_teams; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE stash_teams (
    id integer NOT NULL,
    token character varying(255),
    provider integer,
    user_id integer,
    valide boolean,
    name character varying(255),
    provider_team_id character varying(255),
    provider_user_id character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: stash_teams_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE stash_teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stash_teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE stash_teams_id_seq OWNED BY stash_teams.id;


--
-- Name: stash_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE stash_users (
    id integer NOT NULL,
    team_id integer,
    name character varying(255),
    real_name character varying(255),
    provider_id character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: stash_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE stash_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stash_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE stash_users_id_seq OWNED BY stash_users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY accounts_users ALTER COLUMN id SET DEFAULT nextval('accounts_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY stash_channels ALTER COLUMN id SET DEFAULT nextval('stash_channels_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY stash_links ALTER COLUMN id SET DEFAULT nextval('stash_links_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY stash_teams ALTER COLUMN id SET DEFAULT nextval('stash_teams_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY stash_users ALTER COLUMN id SET DEFAULT nextval('stash_users_id_seq'::regclass);


--
-- Name: accounts_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY accounts_users
    ADD CONSTRAINT accounts_users_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: stash_channels_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY stash_channels
    ADD CONSTRAINT stash_channels_pkey PRIMARY KEY (id);


--
-- Name: stash_links_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY stash_links
    ADD CONSTRAINT stash_links_pkey PRIMARY KEY (id);


--
-- Name: stash_teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY stash_teams
    ADD CONSTRAINT stash_teams_pkey PRIMARY KEY (id);


--
-- Name: stash_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY stash_users
    ADD CONSTRAINT stash_users_pkey PRIMARY KEY (id);


--
-- Name: accounts_users_email_index; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX accounts_users_email_index ON accounts_users USING btree (email);


--
-- Name: stash_channels_provider_id_name_index; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX stash_channels_provider_id_name_index ON stash_channels USING btree (provider_id, name);


--
-- Name: stash_links_team_id_poster_id_channel_id_time_stamp_index; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX stash_links_team_id_poster_id_channel_id_time_stamp_index ON stash_links USING btree (team_id, poster_id, channel_id, time_stamp);


--
-- Name: stash_teams_user_id_index; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX stash_teams_user_id_index ON stash_teams USING btree (user_id);


--
-- Name: stash_users_name_real_name_index; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX stash_users_name_real_name_index ON stash_users USING btree (name, real_name);


--
-- Name: stash_channels_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stash_channels
    ADD CONSTRAINT stash_channels_team_id_fkey FOREIGN KEY (team_id) REFERENCES stash_teams(id);


--
-- Name: stash_links_channel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stash_links
    ADD CONSTRAINT stash_links_channel_id_fkey FOREIGN KEY (channel_id) REFERENCES stash_channels(id);


--
-- Name: stash_links_poster_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stash_links
    ADD CONSTRAINT stash_links_poster_id_fkey FOREIGN KEY (poster_id) REFERENCES stash_users(id);


--
-- Name: stash_links_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stash_links
    ADD CONSTRAINT stash_links_team_id_fkey FOREIGN KEY (team_id) REFERENCES stash_teams(id);


--
-- Name: stash_teams_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stash_teams
    ADD CONSTRAINT stash_teams_user_id_fkey FOREIGN KEY (user_id) REFERENCES accounts_users(id);


--
-- Name: stash_users_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stash_users
    ADD CONSTRAINT stash_users_team_id_fkey FOREIGN KEY (team_id) REFERENCES stash_teams(id);


--
-- PostgreSQL database dump complete
--

INSERT INTO "schema_migrations" (version) VALUES (20170315131206), (20170319141747), (20170401182913), (20170401182925), (20170401182943);


--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 9.6.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: artwork_decoration_translations; Type: TABLE; Schema: public; Owner: scarfacedeb
--

CREATE TABLE artwork_decoration_translations (
    id integer NOT NULL,
    artwork_decoration_id integer NOT NULL,
    locale character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    title character varying(255)
);


ALTER TABLE artwork_decoration_translations OWNER TO scarfacedeb;

--
-- Name: artwork_decoration_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: scarfacedeb
--

CREATE SEQUENCE artwork_decoration_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE artwork_decoration_translations_id_seq OWNER TO scarfacedeb;

--
-- Name: artwork_decoration_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: scarfacedeb
--

ALTER SEQUENCE artwork_decoration_translations_id_seq OWNED BY artwork_decoration_translations.id;


--
-- Name: artwork_decorations; Type: TABLE; Schema: public; Owner: scarfacedeb
--

CREATE TABLE artwork_decorations (
    id integer NOT NULL,
    type character varying(255),
    "values" hstore DEFAULT ''::hstore,
    "position" integer DEFAULT 0
);


ALTER TABLE artwork_decorations OWNER TO scarfacedeb;

--
-- Name: artwork_decorations_id_seq; Type: SEQUENCE; Schema: public; Owner: scarfacedeb
--

CREATE SEQUENCE artwork_decorations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE artwork_decorations_id_seq OWNER TO scarfacedeb;

--
-- Name: artwork_decorations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: scarfacedeb
--

ALTER SEQUENCE artwork_decorations_id_seq OWNED BY artwork_decorations.id;


--
-- Name: artwork_translations; Type: TABLE; Schema: public; Owner: scarfacedeb
--

CREATE TABLE artwork_translations (
    id integer NOT NULL,
    artwork_id integer NOT NULL,
    locale character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    title character varying(255) NOT NULL,
    subtitle character varying(255),
    "desc" text,
    technique character varying(255)
);


ALTER TABLE artwork_translations OWNER TO scarfacedeb;

--
-- Name: artwork_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: scarfacedeb
--

CREATE SEQUENCE artwork_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE artwork_translations_id_seq OWNER TO scarfacedeb;

--
-- Name: artwork_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: scarfacedeb
--

ALTER SEQUENCE artwork_translations_id_seq OWNED BY artwork_translations.id;


--
-- Name: artworks; Type: TABLE; Schema: public; Owner: scarfacedeb
--

CREATE TABLE artworks (
    id integer NOT NULL,
    category_id integer,
    is_published boolean DEFAULT true NOT NULL,
    image character varying(255) NOT NULL,
    price_kopeks integer,
    year character varying(255),
    dimensions character varying(255),
    is_available boolean DEFAULT true NOT NULL,
    slug character varying(255) NOT NULL,
    inserted_at timestamp without time zone,
    updated_at timestamp without time zone,
    framed_dimensions character varying(255),
    translations jsonb DEFAULT '{}'::jsonb,
    image_ratio numeric(7,3)
);


ALTER TABLE artworks OWNER TO scarfacedeb;

--
-- Name: artworks_id_seq; Type: SEQUENCE; Schema: public; Owner: scarfacedeb
--

CREATE SEQUENCE artworks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE artworks_id_seq OWNER TO scarfacedeb;

--
-- Name: artworks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: scarfacedeb
--

ALTER SEQUENCE artworks_id_seq OWNED BY artworks.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: scarfacedeb
--

CREATE TABLE categories (
    id integer NOT NULL,
    slug character varying(255) NOT NULL,
    image character varying(255) NOT NULL,
    inserted_at timestamp without time zone,
    updated_at timestamp without time zone,
    "position" integer DEFAULT 0,
    translations jsonb DEFAULT '{}'::jsonb
);


ALTER TABLE categories OWNER TO scarfacedeb;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: scarfacedeb
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE categories_id_seq OWNER TO scarfacedeb;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: scarfacedeb
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: category_translations; Type: TABLE; Schema: public; Owner: scarfacedeb
--

CREATE TABLE category_translations (
    id integer NOT NULL,
    category_id integer NOT NULL,
    locale character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    title character varying(255) NOT NULL,
    "desc" text
);


ALTER TABLE category_translations OWNER TO scarfacedeb;

--
-- Name: category_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: scarfacedeb
--

CREATE SEQUENCE category_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE category_translations_id_seq OWNER TO scarfacedeb;

--
-- Name: category_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: scarfacedeb
--

ALTER SEQUENCE category_translations_id_seq OWNED BY category_translations.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: scarfacedeb
--

CREATE TABLE order_items (
    id integer NOT NULL,
    artwork_id integer,
    order_id integer,
    quantity integer DEFAULT 1 NOT NULL,
    mat_bg_id integer DEFAULT 0 NOT NULL,
    frame_bg_id integer DEFAULT 0 NOT NULL,
    frame_id integer DEFAULT 0 NOT NULL,
    no_decoration boolean DEFAULT true,
    price_cents integer DEFAULT 0 NOT NULL,
    price_currency character varying(255) DEFAULT 'RUB'::character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE order_items OWNER TO scarfacedeb;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: scarfacedeb
--

CREATE SEQUENCE order_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE order_items_id_seq OWNER TO scarfacedeb;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: scarfacedeb
--

ALTER SEQUENCE order_items_id_seq OWNED BY order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: scarfacedeb
--

CREATE TABLE orders (
    id integer NOT NULL,
    status integer DEFAULT 0,
    completed_at timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    first_name character varying(255),
    last_name character varying(255),
    email character varying(255),
    phone character varying(255),
    message text,
    country character varying(255),
    zip integer,
    state character varying(255),
    city character varying(255),
    address character varying(255),
    shipping integer,
    payment integer
);


ALTER TABLE orders OWNER TO scarfacedeb;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: scarfacedeb
--

CREATE SEQUENCE orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE orders_id_seq OWNER TO scarfacedeb;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: scarfacedeb
--

ALTER SEQUENCE orders_id_seq OWNED BY orders.id;


--
-- Name: page_translations; Type: TABLE; Schema: public; Owner: scarfacedeb
--

CREATE TABLE page_translations (
    id integer NOT NULL,
    page_id integer NOT NULL,
    locale character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    title character varying(255) NOT NULL,
    body text,
    "desc" text
);


ALTER TABLE page_translations OWNER TO scarfacedeb;

--
-- Name: page_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: scarfacedeb
--

CREATE SEQUENCE page_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE page_translations_id_seq OWNER TO scarfacedeb;

--
-- Name: page_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: scarfacedeb
--

ALTER SEQUENCE page_translations_id_seq OWNED BY page_translations.id;


--
-- Name: pages; Type: TABLE; Schema: public; Owner: scarfacedeb
--

CREATE TABLE pages (
    id integer NOT NULL,
    slug character varying(255),
    is_published boolean DEFAULT true,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE pages OWNER TO scarfacedeb;

--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: scarfacedeb
--

CREATE SEQUENCE pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pages_id_seq OWNER TO scarfacedeb;

--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: scarfacedeb
--

ALTER SEQUENCE pages_id_seq OWNED BY pages.id;


--
-- Name: post_translations; Type: TABLE; Schema: public; Owner: scarfacedeb
--

CREATE TABLE post_translations (
    id integer NOT NULL,
    post_id integer NOT NULL,
    locale character varying(255) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    title character varying(255) NOT NULL,
    summary text,
    body text
);


ALTER TABLE post_translations OWNER TO scarfacedeb;

--
-- Name: post_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: scarfacedeb
--

CREATE SEQUENCE post_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE post_translations_id_seq OWNER TO scarfacedeb;

--
-- Name: post_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: scarfacedeb
--

ALTER SEQUENCE post_translations_id_seq OWNED BY post_translations.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: scarfacedeb
--

CREATE TABLE posts (
    id integer NOT NULL,
    slug character varying(255) NOT NULL,
    image character varying(255) NOT NULL,
    published_at date,
    is_published boolean DEFAULT true,
    is_homepage boolean DEFAULT true,
    inserted_at timestamp without time zone,
    updated_at timestamp without time zone,
    is_bordered boolean DEFAULT true,
    translations jsonb DEFAULT '{}'::jsonb
);


ALTER TABLE posts OWNER TO scarfacedeb;

--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: scarfacedeb
--

CREATE SEQUENCE posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE posts_id_seq OWNER TO scarfacedeb;

--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: scarfacedeb
--

ALTER SEQUENCE posts_id_seq OWNED BY posts.id;


--
-- Name: rails_admin_histories; Type: TABLE; Schema: public; Owner: scarfacedeb
--

CREATE TABLE rails_admin_histories (
    id integer NOT NULL,
    message text,
    username character varying(255),
    item integer,
    "table" character varying(255),
    month smallint,
    year bigint,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE rails_admin_histories OWNER TO scarfacedeb;

--
-- Name: rails_admin_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: scarfacedeb
--

CREATE SEQUENCE rails_admin_histories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE rails_admin_histories_id_seq OWNER TO scarfacedeb;

--
-- Name: rails_admin_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: scarfacedeb
--

ALTER SEQUENCE rails_admin_histories_id_seq OWNED BY rails_admin_histories.id;


--
-- Name: redactor_assets; Type: TABLE; Schema: public; Owner: scarfacedeb
--

CREATE TABLE redactor_assets (
    id integer NOT NULL,
    data_file_name character varying(255) NOT NULL,
    data_content_type character varying(255),
    data_file_size integer,
    assetable_id integer,
    assetable_type character varying(30),
    type character varying(30),
    width integer,
    height integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE redactor_assets OWNER TO scarfacedeb;

--
-- Name: redactor_assets_id_seq; Type: SEQUENCE; Schema: public; Owner: scarfacedeb
--

CREATE SEQUENCE redactor_assets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE redactor_assets_id_seq OWNER TO scarfacedeb;

--
-- Name: redactor_assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: scarfacedeb
--

ALTER SEQUENCE redactor_assets_id_seq OWNED BY redactor_assets.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: scarfacedeb
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE schema_migrations OWNER TO scarfacedeb;

--
-- Name: users; Type: TABLE; Schema: public; Owner: scarfacedeb
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE users OWNER TO scarfacedeb;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: scarfacedeb
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO scarfacedeb;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: scarfacedeb
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: artwork_decoration_translations id; Type: DEFAULT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY artwork_decoration_translations ALTER COLUMN id SET DEFAULT nextval('artwork_decoration_translations_id_seq'::regclass);


--
-- Name: artwork_decorations id; Type: DEFAULT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY artwork_decorations ALTER COLUMN id SET DEFAULT nextval('artwork_decorations_id_seq'::regclass);


--
-- Name: artwork_translations id; Type: DEFAULT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY artwork_translations ALTER COLUMN id SET DEFAULT nextval('artwork_translations_id_seq'::regclass);


--
-- Name: artworks id; Type: DEFAULT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY artworks ALTER COLUMN id SET DEFAULT nextval('artworks_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: category_translations id; Type: DEFAULT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY category_translations ALTER COLUMN id SET DEFAULT nextval('category_translations_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY order_items ALTER COLUMN id SET DEFAULT nextval('order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY orders ALTER COLUMN id SET DEFAULT nextval('orders_id_seq'::regclass);


--
-- Name: page_translations id; Type: DEFAULT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY page_translations ALTER COLUMN id SET DEFAULT nextval('page_translations_id_seq'::regclass);


--
-- Name: pages id; Type: DEFAULT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY pages ALTER COLUMN id SET DEFAULT nextval('pages_id_seq'::regclass);


--
-- Name: post_translations id; Type: DEFAULT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY post_translations ALTER COLUMN id SET DEFAULT nextval('post_translations_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY posts ALTER COLUMN id SET DEFAULT nextval('posts_id_seq'::regclass);


--
-- Name: rails_admin_histories id; Type: DEFAULT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY rails_admin_histories ALTER COLUMN id SET DEFAULT nextval('rails_admin_histories_id_seq'::regclass);


--
-- Name: redactor_assets id; Type: DEFAULT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY redactor_assets ALTER COLUMN id SET DEFAULT nextval('redactor_assets_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: artwork_decoration_translations; Type: TABLE DATA; Schema: public; Owner: scarfacedeb
--

COPY artwork_decoration_translations (id, artwork_decoration_id, locale, created_at, updated_at, title) FROM stdin;
1	1	en	2014-02-18 11:07:45.391629	2014-02-18 11:07:45.391629	blue
4	2	en	2014-02-18 11:07:45.415542	2014-02-18 11:07:45.415542	yellow
7	3	en	2014-02-18 11:07:45.437982	2014-02-18 11:07:45.437982	white
10	4	en	2014-02-18 11:07:45.455874	2014-02-18 11:07:45.455874	red
13	5	en	2014-02-18 11:07:45.473288	2014-02-18 11:07:45.473288	green
16	6	en	2014-02-18 11:07:45.498976	2014-02-18 11:07:45.498976	black
17	6	ru	2014-02-18 11:07:45.501605	2014-02-18 11:07:45.501605	black
18	6	cz	2014-02-18 11:07:45.503844	2014-02-18 11:07:45.503844	black
19	7	en	2014-02-18 11:07:45.527336	2014-02-18 11:07:45.527336	black
20	7	ru	2014-02-18 11:07:45.528818	2014-02-18 11:07:45.528818	черный
22	8	en	2014-02-18 11:07:45.53676	2014-02-18 11:07:45.53676	silver
23	8	ru	2014-02-18 11:07:45.538253	2014-02-18 11:07:45.538253	серебрянный
25	9	en	2014-02-18 11:07:45.55705	2014-02-18 11:07:45.55705	Plastic
26	9	ru	2014-02-18 11:07:45.558481	2014-02-18 11:07:45.558481	Пластик
28	10	en	2014-02-18 11:07:45.56607	2014-02-18 11:07:45.56607	Aluminium
29	10	ru	2014-02-18 11:07:45.567441	2014-02-18 11:07:45.567441	Алюминий
30	10	cz	2014-02-18 11:07:45.568589	2014-03-11 17:00:31.425963	Hliník
27	9	cz	2014-02-18 11:07:45.559838	2014-03-11 17:02:24.854439	Umělá hmota
24	8	cz	2014-02-18 11:07:45.539673	2014-03-11 17:02:51.934056	stříbro
21	7	cz	2014-02-18 11:07:45.530151	2014-03-11 17:03:11.986361	černý
15	5	cz	2014-02-18 11:07:45.481116	2014-03-11 17:03:54.626134	zelený
14	5	ru	2014-02-18 11:07:45.475333	2014-03-11 17:04:17.81941	зелёный
12	4	cz	2014-02-18 11:07:45.459374	2014-03-11 17:04:44.233156	červený
11	4	ru	2014-02-18 11:07:45.458043	2014-03-11 17:04:54.384043	красный
9	3	cz	2014-02-18 11:07:45.441549	2014-03-11 17:05:15.228161	bílý
8	3	ru	2014-02-18 11:07:45.439866	2014-03-11 17:05:24.64068	белый
6	2	cz	2014-02-18 11:07:45.419439	2014-03-11 17:05:43.686212	žlutý
3	1	cz	2014-02-18 11:07:45.39896	2014-03-11 17:06:15.458094	modrý
2	1	ru	2014-02-18 11:07:45.396719	2014-03-11 17:06:26.373152	синий
5	2	ru	2014-02-18 11:07:45.417682	2014-03-11 17:06:51.350879	жёлтый
\.


--
-- Name: artwork_decoration_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: scarfacedeb
--

SELECT pg_catalog.setval('artwork_decoration_translations_id_seq', 30, true);


--
-- Data for Name: artwork_decorations; Type: TABLE DATA; Schema: public; Owner: scarfacedeb
--

COPY artwork_decorations (id, type, "values", "position") FROM stdin;
2	MatBg	"image"=>"image.jpg", "background"=>"FBC541"	5
7	FrameBg	"background"=>"000000"	1
8	FrameBg	"background"=>"c0c0c0"	2
9	Frame		1
10	Frame		2
5	MatBg	"image"=>"green_new_150.png", "background"=>"2da335"	6
1	MatBg	"image"=>"blue_line_150.png", "background"=>"264B65"	4
6	MatBg	"image"=>"image.jpg", "background"=>"282828"	3
4	MatBg	"image"=>"paper_red.png", "background"=>"B8424E"	1
3	MatBg	"image"=>"image.jpg", "background"=>"EEECE0"	2
\.


--
-- Name: artwork_decorations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: scarfacedeb
--

SELECT pg_catalog.setval('artwork_decorations_id_seq', 10, true);


--
-- Data for Name: artwork_translations; Type: TABLE DATA; Schema: public; Owner: scarfacedeb
--

COPY artwork_translations (id, artwork_id, locale, created_at, updated_at, title, subtitle, "desc", technique) FROM stdin;
261	87	cz	2014-03-15 12:17:49.078858	2014-12-17 08:59:49.378394	Kachny	Disk na obloze	<iframe width="100%" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/176203611&color=ff5500&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false"></iframe><p>\r\n\tVelikost pasparti na každé straně - 7cm</p><p>\r\n\tKaždý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
258	86	cz	2014-03-15 12:12:34.259647	2014-05-06 09:32:41.760266	Bez názvu #1	...	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
256	86	en	2014-03-15 12:12:34.249446	2014-05-06 09:32:41.785275	Untitled #1	...	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
255	85	cz	2014-03-15 12:08:52.030799	2014-05-06 09:50:10.896451	"Hej, chlapi!"	Lano	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
253	85	en	2014-03-15 12:08:52.02708	2014-05-06 09:50:10.900414	"Hey, dudes!"	Ropes	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
252	84	cz	2014-03-15 12:04:37.366774	2014-05-06 12:12:20.887069	"Pomozte nám..."	Lano	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
276	92	cz	2014-03-15 13:35:18.63429	2014-05-06 07:36:42.349359	Separátor		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
274	92	en	2014-03-15 13:35:18.631125	2014-05-06 07:36:42.365859	Separator		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
270	90	cz	2014-03-15 13:07:35.315607	2014-05-06 07:55:01.654531	Strom nápadů		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
249	83	cz	2014-03-15 11:54:34.73815	2014-05-06 12:42:26.586351	"Chyťte ho!"	Staré a nové nápady	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
247	83	en	2014-03-15 11:54:34.734305	2014-05-06 12:42:26.591391	"Catch him!"	Old and new ideas	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
332	111	ru	2014-03-16 07:50:17.059875	2014-05-05 10:55:05.273404	Без названия #10		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
331	111	en	2014-03-16 07:50:17.057597	2014-05-05 10:55:05.275062	Untitled #10		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
269	90	ru	2014-03-15 13:07:35.314054	2014-05-06 07:55:01.658636	Дерево идей		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
329	110	ru	2014-03-16 07:46:21.268695	2014-05-05 11:26:03.5802	Логика		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
326	109	ru	2014-03-16 04:12:20.055383	2014-05-05 11:28:31.059623	Время	Расширение пространства	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
268	90	en	2014-03-15 13:07:35.31211	2014-05-06 07:55:01.660649	Tree of Ideas		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
267	89	cz	2014-03-15 12:59:01.255822	2014-05-06 08:25:59.607367	Tančící stíny		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
266	89	ru	2014-03-15 12:59:01.254421	2014-05-06 08:25:59.609997	Танцующие тени		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
265	89	en	2014-03-15 12:59:01.251993	2014-05-06 08:25:59.611297	Dancing shadows		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
264	88	cz	2014-03-15 12:49:24.838431	2014-05-06 08:46:15.077215	Kachny II	Disk na obloze	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
262	88	en	2014-03-15 12:49:24.835177	2014-05-06 08:46:15.090035	Ducks II	 Spinning disc in the sky	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
508	170	en	2014-06-03 11:50:22.206349	2014-06-03 11:50:22.206349	Jellyfishes on Land		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
509	170	ru	2014-06-03 11:50:22.232809	2014-06-03 11:50:22.232809	Медузы		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
510	170	cz	2014-06-03 11:50:22.234969	2014-06-03 11:50:22.234969	Jellyfishes		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
297	99	cz	2014-03-15 15:04:06.307097	2014-05-06 05:02:35.987106	Rádiové věže		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
295	99	en	2014-03-15 15:04:06.303655	2014-05-06 05:02:35.991154	Radio towers		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
291	97	cz	2014-03-15 14:39:45.696925	2014-05-06 05:08:46.793702	Něco jako západ slunce		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
325	109	en	2014-03-16 04:12:20.052567	2014-05-05 11:28:31.061783	Time	Expansion of space	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
323	108	ru	2014-03-15 17:05:35.06464	2014-05-05 11:32:51.788295	Без названия #9	...	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
285	95	cz	2014-03-15 14:33:05.446686	2014-05-06 05:35:32.778478	Pod měsícem		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
284	95	ru	2014-03-15 14:33:05.444175	2014-05-06 05:35:32.780259	Под луной		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
283	95	en	2014-03-15 14:33:05.440486	2014-05-06 05:35:32.78168	Under the moon		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
320	107	ru	2014-03-15 16:15:53.736361	2014-05-05 11:38:13.422443	Без названия #8	...	<object width="200" height="150"><param name="movie" value="//www.youtube.com/v/ZI_iy09RFZg?version=3&hl=ru_RU&rel=0"><param name="allowFullScreen" value="true"><param name="allowscriptaccess" value="always"><embed src="//www.youtube.com/v/ZI_iy09RFZg?version=3&hl=ru_RU&rel=0" type="application/x-shockwave-flash" width="200" height="150" allowscriptaccess="always" allowfullscreen="true"><p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p></object>	бумага, тушь, рапидограф
318	106	cz	2014-03-15 16:01:19.407364	2014-05-05 11:40:35.515552	Bez názvu #7	...	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
312	104	cz	2014-03-15 15:44:14.517268	2014-05-05 11:44:22.226672	Hvizd		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
311	104	ru	2014-03-15 15:44:14.51574	2014-05-05 11:44:22.228263	Свист		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
309	103	cz	2014-03-15 15:39:46.078352	2014-05-05 11:46:12.739099	Stejně jako stíny Plata		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
306	102	cz	2014-03-15 15:18:47.242903	2014-05-05 11:48:18.516893	Grain elevator		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
304	102	en	2014-03-15 15:18:47.24015	2014-05-05 11:48:18.52234	Grain elevator		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
300	100	cz	2014-03-15 15:08:25.772756	2014-05-06 04:58:27.046528	Bez názvu #5	...	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
290	97	ru	2014-03-15 14:39:45.695451	2014-05-06 05:08:46.795421	Что-то похожее на закат		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
289	97	en	2014-03-15 14:39:45.693693	2014-05-06 05:08:46.797186	Something like a sunset		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
288	96	cz	2014-03-15 14:34:47.878156	2014-05-06 05:16:06.478122	Bez názvu #4	...	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
287	96	ru	2014-03-15 14:34:47.876296	2014-05-06 05:16:06.479817	Без названия #4	...	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
286	96	en	2014-03-15 14:34:47.874533	2014-05-06 05:16:06.481351	Untitled #4	...	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
511	171	en	2014-06-03 12:11:00.696635	2014-06-03 12:11:00.696635	Birds over the tower	Like neurons in the head	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
512	171	ru	2014-06-03 12:11:00.699929	2014-06-03 12:11:00.699929	Птицы над вышкой	Словно нейроны в голове	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
333	111	cz	2014-03-16 07:50:17.061857	2014-05-05 10:55:05.271429	Bez názvu #10		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
330	110	cz	2014-03-16 07:46:21.270498	2014-05-05 11:26:03.578648	Logika		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
328	110	en	2014-03-16 07:46:21.266455	2014-05-05 11:26:03.581809	Logic		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
327	109	cz	2014-03-16 04:12:20.056908	2014-05-05 11:28:31.057285	Doba	Rozšíření prostoru	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
324	108	cz	2014-03-15 17:05:35.066568	2014-05-05 11:32:51.78689	Bez názvu #9	...	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
322	108	en	2014-03-15 17:05:35.06133	2014-05-05 11:32:51.789706	Untitled #9	...	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
315	105	cz	2014-03-15 15:58:14.282911	2014-05-05 11:42:24.992517	"Jsem velké Slunce..."	by Charles Causley	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
382	128	en	2014-03-27 14:20:06.595956	2014-05-03 14:46:56.937593	Home	I	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
351	117	cz	2014-03-27 13:28:55.029055	2014-05-05 10:31:42.194239	Zapomenutý zvuk		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
378	126	cz	2014-03-27 14:16:39.287888	2014-05-05 09:27:21.596005	Bez názvu #15		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
375	125	cz	2014-03-27 14:15:08.349346	2014-05-05 10:09:11.146695	Moment		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
373	125	en	2014-03-27 14:15:08.345603	2014-05-05 10:09:11.151252	Moment		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
372	124	cz	2014-03-27 14:09:45.961602	2014-05-05 10:11:49.52736	Smysl života		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
369	123	cz	2014-03-27 14:07:02.444269	2014-05-05 10:14:24.277284	Čas na práci a čas k odpočinku		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
367	123	en	2014-03-27 14:07:02.439449	2014-05-05 10:14:24.280772	Time to work and time to rest		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
363	121	cz	2014-03-27 13:54:19.566656	2014-05-05 10:19:33.361041	Ἡράκλειτος	Dřímající Hérakleitos a jeho vize o nás	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
360	120	cz	2014-03-27 13:45:15.481447	2014-05-05 10:23:21.056773	Umění myšlení	Idea a realizace	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
359	120	ru	2014-03-27 13:45:15.479786	2014-05-05 10:23:21.058225	Искусство мысли	Идея и воплощение	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
357	119	cz	2014-03-27 13:34:10.023426	2014-05-05 10:24:57.742691	Vítr		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
355	119	en	2014-03-27 13:34:10.018624	2014-05-05 10:24:57.750527	Wind		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
354	118	cz	2014-03-27 13:32:11.81272	2014-05-05 10:27:33.026288	Bez názvu #13		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
381	127	cz	2014-03-27 14:18:26.564452	2014-05-05 10:31:30.256073	Bez názvu #16		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
349	117	en	2014-03-27 13:28:55.025175	2014-05-05 10:31:42.202328	Lost sound		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
366	122	cz	2014-03-27 14:04:59.567656	2014-05-05 10:32:04.89037	Bez názvu #14		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
348	116	cz	2014-03-27 10:34:24.619288	2014-05-05 10:35:36.478414	Bez názvu #12		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
345	115	cz	2014-03-27 10:32:55.924708	2014-05-05 10:39:10.430129	Plnovous		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
343	115	en	2014-03-27 10:32:55.920899	2014-05-05 10:39:10.43406	Beard		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
342	114	cz	2014-03-27 10:31:00.815303	2014-05-05 10:43:44.107734	Klaním se ti		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
341	114	ru	2014-03-27 10:31:00.813291	2014-05-05 10:43:44.110102	Мы обожаем тебя		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
340	114	en	2014-03-27 10:31:00.810169	2014-05-05 10:43:44.111429	Adore you		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
339	113	cz	2014-03-27 10:26:22.201475	2014-05-05 10:46:13.063483	Bez názvu #11		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
314	105	ru	2014-03-15 15:58:14.281164	2014-05-05 11:42:24.994326	"Я великое Солнце..."	by Charles Causley	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
399	133	cz	2014-03-28 08:17:20.719996	2014-03-28 08:22:14.147667	Land of pylons		<p><embed src="//www.youtube.com/v/dQEmaj9C6ko?hl=ru_RU&version=3&rel=0" type="application/x-shockwave-flash" width="200" height="150" allowscriptaccess="always" allowfullscreen="true" style="background-color: rgb(246, 246, 246); font-size: 15px; line-height: 1.5rem;"></p><p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
398	133	ru	2014-03-28 08:17:20.718127	2014-03-28 08:22:14.152857	Земля пилонов		<p><embed src="//www.youtube.com/v/dQEmaj9C6ko?hl=ru_RU&version=3&rel=0" type="application/x-shockwave-flash" width="200" height="150" allowscriptaccess="always" allowfullscreen="true" style="background-color: rgb(246, 246, 246); font-size: 15px; line-height: 1.5rem;"></p><p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
397	133	en	2014-03-28 08:17:20.710661	2014-03-28 08:22:14.154391	Land of pylons		<p><embed src="//www.youtube.com/v/dQEmaj9C6ko?hl=ru_RU&version=3&rel=0" type="application/x-shockwave-flash" width="200" height="150" allowscriptaccess="always" allowfullscreen="true" style="background-color: rgb(246, 246, 246); font-size: 15px; line-height: 1.5rem;"></p><p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
423	141	cz	2014-03-28 08:52:40.430056	2014-04-28 16:25:15.078368	Noèsis		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
466	156	en	2014-03-28 11:51:36.041738	2014-04-18 04:04:01.265853	Radio tower		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
420	140	cz	2014-03-28 08:49:22.79332	2014-04-28 16:32:43.615627	Light and sound of time		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
418	140	en	2014-03-28 08:49:22.79007	2014-04-28 16:32:43.626081	Light and sound of time		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
441	147	cz	2014-03-28 09:14:54.915064	2014-04-28 12:27:12.221853	Inverze		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
438	146	cz	2014-03-28 09:12:45.324824	2014-04-28 12:29:28.715317	Kouř	Nový nápad	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
435	145	cz	2014-03-28 09:08:25.601972	2014-04-28 12:35:24.044784	Pohyb	Stejně jako Dopplerův jev	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero, pastelka
432	144	cz	2014-03-28 09:04:27.149929	2014-04-28 13:02:15.050823	V hlubokém lese	Leto	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
431	144	ru	2014-03-28 09:04:27.145713	2014-04-28 13:02:15.052536	В глубоком лесу	Лето	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
429	143	cz	2014-03-28 09:02:43.043346	2014-04-28 13:50:09.729973	V hlubokém lese	Zima	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
426	142	cz	2014-03-28 08:56:31.457135	2014-04-28 16:22:07.54791	New power		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero, pastelka
424	142	en	2014-03-28 08:56:31.453274	2014-04-28 16:22:07.552636	New power		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen, color pencil
417	139	cz	2014-03-28 08:47:18.05836	2014-04-28 16:45:35.586547	Les myšlení		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
414	138	cz	2014-03-28 08:44:00.622635	2014-04-28 16:50:26.770377	Topoly		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
412	138	en	2014-03-28 08:44:00.619075	2014-04-28 16:50:26.774184	Poplars		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
411	137	cz	2014-03-28 08:41:36.000542	2014-04-28 16:53:55.417891	Přistání		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
408	136	cz	2014-03-28 08:38:16.520801	2014-04-28 16:58:02.522545	Přístav		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
405	135	cz	2014-03-28 08:32:55.17035	2014-04-28 17:06:22.437891	Moje dílna		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
403	135	en	2014-03-28 08:32:55.166527	2014-04-28 17:06:22.443169	In my workshop		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
402	134	cz	2014-03-28 08:30:21.713086	2014-04-28 17:10:17.525794	Sníh a slunce		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
393	131	cz	2014-03-28 07:50:47.05927	2014-04-28 17:19:57.214541	Kouř a střechy		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
391	131	en	2014-03-28 07:50:47.045731	2014-04-28 17:19:57.242526	Smoke and roofs		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
390	130	cz	2014-03-27 14:27:19.599924	2014-05-03 14:30:33.836634	Houpám se		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	papír, tuš, technické pero
387	129	cz	2014-03-27 14:21:19.66283	2014-05-03 14:42:25.147931	Dům	II	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
313	105	en	2014-03-15 15:58:14.27816	2014-05-05 11:42:24.995693	"I am the great sun..."	by Charles Causley	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
310	104	en	2014-03-15 15:44:14.513598	2014-05-05 11:44:22.229592	Whistle		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
490	164	en	2014-03-28 12:21:53.257477	2014-04-18 03:51:20.355574	The sound of pylons		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
487	163	en	2014-03-28 12:19:42.85097	2014-04-18 03:51:54.88118	The burning tree	Dam	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
489	163	cz	2014-03-28 12:19:42.854681	2014-04-28 08:29:07.032918	Hořící strom	Přehrada	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
484	162	en	2014-03-28 12:17:15.69063	2014-04-18 03:54:28.262159	Pastorale 		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
472	158	en	2014-03-28 12:03:28.029379	2014-04-18 04:02:12.595076	Alley		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
481	161	en	2014-03-28 12:13:10.2048	2014-04-18 03:55:22.029946	The edge of the edge		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
478	160	en	2014-03-28 12:09:32.314255	2014-04-18 03:56:44.607527	Bird and satellite dish		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
475	159	en	2014-03-28 12:06:16.302924	2014-04-18 04:00:42.553055	Waves		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
469	157	en	2014-03-28 12:01:44.470921	2014-04-18 04:02:53.375009	The Crying side of the Earth		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen, color pencil
474	158	cz	2014-03-28 12:03:28.032564	2014-04-28 09:19:58.487945	Alej		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
492	164	cz	2014-03-28 12:21:53.261018	2014-04-28 08:18:37.176767	Pylonový zvuk		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	
491	164	ru	2014-03-28 12:21:53.259703	2014-04-28 08:18:37.180855	Звук пилонов		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
486	162	cz	2014-03-28 12:17:15.695426	2014-04-28 08:38:06.254269	Pastorale 		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
483	161	cz	2014-03-28 12:13:10.208338	2014-04-28 08:56:07.63516	The edge of the edge		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
480	160	cz	2014-03-28 12:09:32.317792	2014-04-28 09:01:06.39868	Pták a parabolická anténa		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
477	159	cz	2014-03-28 12:06:16.306721	2014-04-28 09:02:44.285278	Vlny		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
471	157	cz	2014-03-28 12:01:44.476819	2014-04-28 09:23:10.126628	The Crying side of the Earth		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero, pastelka
468	156	cz	2014-03-28 11:51:36.045885	2014-04-28 09:26:30.314428	Vysílač		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
465	155	cz	2014-03-28 11:33:26.335607	2014-04-28 09:28:56.639872	Oheň znalostí	Smutek a štěstí	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
463	155	en	2014-03-28 11:33:26.326926	2014-04-28 09:28:56.643107	The Bonfire of knowledge	Sadness and happiness	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
459	153	cz	2014-03-28 11:28:48.464573	2014-04-28 11:12:07.192255	Obdiv		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
462	154	cz	2014-03-28 11:29:56.631013	2014-05-05 10:30:45.542859	Bez názvu #18		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
453	151	cz	2014-03-28 11:25:16.491331	2014-04-28 11:24:43.914254	Kdo je další?		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero, pastelka
451	151	en	2014-03-28 11:25:16.486875	2014-04-28 11:24:43.91796	Who's next?		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen, color pencil
450	150	cz	2014-03-28 11:23:22.875729	2014-04-28 12:15:17.303219	Ptáci a sníh	The Wind Coming	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
447	149	cz	2014-03-28 11:20:58.344216	2014-04-28 12:18:06.054559	Jednoho dne budu vidět kopce a sopky		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
445	149	en	2014-03-28 11:20:58.340852	2014-04-28 12:18:06.058405	Someday I'll see the hills and volcanoes		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
444	148	cz	2014-03-28 11:18:18.085793	2014-04-28 12:21:38.803657	Hlava		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
436	146	en	2014-03-28 09:12:45.315576	2014-04-28 12:29:28.718583	Smoke	New idea	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
488	163	ru	2014-03-28 12:19:42.852989	2014-04-28 08:29:07.0348	Горящее дерево	Дамба	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
485	162	ru	2014-03-28 12:17:15.693473	2014-04-28 08:38:06.257282	Пастораль		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
482	161	ru	2014-03-28 12:13:10.206552	2014-04-28 08:56:07.637193	Край края		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
479	160	ru	2014-03-28 12:09:32.316123	2014-04-28 09:01:06.40039	Птица и спутниковая антенна		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
476	159	ru	2014-03-28 12:06:16.30509	2014-04-28 09:02:44.287061	Волны		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
473	158	ru	2014-03-28 12:03:28.031112	2014-04-28 09:19:58.489984	Аллея		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
470	157	ru	2014-03-28 12:01:44.474768	2014-04-28 09:23:10.128229	The Crying side of the Earth		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф, цветной карандаш
467	156	ru	2014-03-28 11:51:36.044429	2014-04-28 09:26:30.316094	Радиовышка		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
464	155	ru	2014-03-28 11:33:26.331788	2014-04-28 09:28:56.641562	Костер знания	Грусть и счастье	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
458	153	ru	2014-03-28 11:28:48.462945	2014-04-28 11:12:07.19404	Восхищение		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
457	153	en	2014-03-28 11:28:48.461195	2014-04-28 11:12:07.196227	Admiration		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
308	103	ru	2014-03-15 15:39:46.076896	2014-05-05 11:46:12.74501	Словно тени Платона		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
307	103	en	2014-03-15 15:39:46.074842	2014-05-05 11:46:12.750976	Like shadows of Plato		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
452	151	ru	2014-03-28 11:25:16.489308	2014-04-28 11:24:43.91595	Кто следующий? 		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф, цветной карандаш
449	150	ru	2014-03-28 11:23:22.874323	2014-04-28 12:15:17.305226	Птицы и снег	Ветер приходит	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
448	150	en	2014-03-28 11:23:22.872678	2014-04-28 12:15:17.306842	Birds and Snow	The Wind Coming	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
446	149	ru	2014-03-28 11:20:58.34272	2014-04-28 12:18:06.056378	Когда-нибудь я увижу холмы и вулканы		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
443	148	ru	2014-03-28 11:18:18.082762	2014-04-28 12:21:38.805501	Голова		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
442	148	en	2014-03-28 11:18:18.080509	2014-04-28 12:21:38.808015	Head		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
440	147	ru	2014-03-28 09:14:54.913125	2014-04-28 12:27:12.229423	Инверсия		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
439	147	en	2014-03-28 09:14:54.908856	2014-04-28 12:27:12.231048	Inverse		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
437	146	ru	2014-03-28 09:12:45.322591	2014-04-28 12:29:28.716985	Дым	Новая идея	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
461	154	ru	2014-03-28 11:29:56.629489	2014-05-05 10:30:45.540759	Без названия #18		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
434	145	ru	2014-03-28 09:08:25.600241	2014-04-28 12:35:24.04692	Движение	Словно Эффект Доплера	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф, цветной карандаш
433	145	en	2014-03-28 09:08:25.5983	2014-04-28 12:35:24.049936	The Motion 	Like Doppler effect	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen, color pencil
430	144	en	2014-03-28 09:04:27.143642	2014-04-28 13:02:15.053964	In the deep forest	Summer	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
428	143	ru	2014-03-28 09:02:43.041886	2014-04-28 13:50:09.732038	В глубоком лесу	Зима	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
427	143	en	2014-03-28 09:02:43.039558	2014-04-28 13:50:09.734631	In the deep forest	Winter	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
425	142	ru	2014-03-28 08:56:31.455547	2014-04-28 16:22:07.550756	Новая мощность		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф, цветной карандаш
422	141	ru	2014-03-28 08:52:40.428446	2014-04-28 16:25:15.079857	Ноэзис		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
421	141	en	2014-03-28 08:52:40.426186	2014-04-28 16:25:15.081288	Noèsis		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
419	140	ru	2014-03-28 08:49:22.791764	2014-04-28 16:32:43.618748	Свет и звук времени		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
416	139	ru	2014-03-28 08:47:18.056884	2014-04-28 16:45:35.588374	Лес размышлений		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
415	139	en	2014-03-28 08:47:18.054154	2014-04-28 16:45:35.590357	Forest of thinking		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
413	138	ru	2014-03-28 08:44:00.621154	2014-04-28 16:50:26.772331	Тополя		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
410	137	ru	2014-03-28 08:41:35.998861	2014-04-28 16:53:55.420062	Приземление		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
409	137	en	2014-03-28 08:41:35.996332	2014-04-28 16:53:55.4228	The Landing		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
407	136	ru	2014-03-28 08:38:16.519315	2014-04-28 16:58:02.52452	Пристань		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
406	136	en	2014-03-28 08:38:16.517044	2014-04-28 16:58:02.52641	The pier		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
404	135	ru	2014-03-28 08:32:55.168483	2014-04-28 17:06:22.440507	В моей мастерской		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
401	134	ru	2014-03-28 08:30:21.711061	2014-04-28 17:10:17.527445	Снег и солнце		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
400	134	en	2014-03-28 08:30:21.708774	2014-04-28 17:10:17.529048	Snow and sun		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
392	131	ru	2014-03-28 07:50:47.057764	2014-04-28 17:19:57.216802	Дым и крыши		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
454	152	en	2014-03-28 11:26:35.394172	2014-05-03 11:20:19.217221	Untitled #17		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
389	130	ru	2014-03-27 14:27:19.598287	2014-05-03 14:30:33.838362	Качаюсь		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
388	130	en	2014-03-27 14:27:19.589304	2014-05-03 14:30:33.840793	Houpám se		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
386	129	ru	2014-03-27 14:21:19.661006	2014-05-03 14:42:25.14957	Дом	II	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
385	129	en	2014-03-27 14:21:19.658967	2014-05-03 14:42:25.152052	Home	II	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
384	128	cz	2014-03-27 14:20:06.599514	2014-05-03 14:46:56.923129	Dům	I	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
383	128	ru	2014-03-27 14:20:06.597971	2014-05-03 14:46:56.929332	Дом	I	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
305	102	ru	2014-03-15 15:18:47.24169	2014-05-05 11:48:18.520081	Зерновой элеватор		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
577	193	en	2014-06-04 05:57:20.055698	2014-06-04 05:57:20.055698	Untitled #26		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
494	165	ru	2014-05-03 15:26:19.438942	2014-05-03 15:26:19.438942	Пожалуйста, будьте тише	Солнечно-суточные вариации		ДВП, масло, аэрозольный акрил
497	166	ru	2014-05-03 15:30:37.282759	2014-05-03 15:30:37.282759	Помоги себе сам			ДВП, масло, аэрозольный акрил
500	167	ru	2014-05-03 15:34:48.944487	2014-05-03 15:34:48.944487	Зал создания			ДВП, масло, аэрозольный акрил
503	168	ru	2014-05-03 15:40:12.732992	2014-05-03 15:40:12.732992	Это тебе, и тебе, и тебе, и тебе...			ДВП, масло, аэрозольный акрил
504	168	cz	2014-05-03 15:40:12.734549	2014-05-03 15:42:24.94871	This is for you and for you and for you and for you...			dřevovláknitá deska, olejomalba, akryl spray
502	168	en	2014-05-03 15:40:12.731068	2014-05-03 15:42:24.950774	This is for you and for you and for you and for you...			fibreboard, oil, acrylic spray
501	167	cz	2014-05-03 15:34:48.946105	2014-05-03 15:42:42.966608	Hall of creation			dřevovláknitá deska, olejomalba, akryl spray
499	167	en	2014-05-03 15:34:48.942481	2014-05-03 15:42:42.968194	Hall of creation			fibreboard, oil, acrylic spray
498	166	cz	2014-05-03 15:30:37.284236	2014-05-03 15:43:10.432022	Help yourself			dřevovláknitá deska, olejomalba, akryl spray
496	166	en	2014-05-03 15:30:37.280457	2014-05-03 15:43:10.433722	Help yourself			fibreboard, oil, acrylic spray
495	165	cz	2014-05-03 15:26:19.440548	2014-05-03 15:44:36.263982	Hey, please be quiet	Quiet solar diurnal variation		dřevovláknitá deska, olejomalba, akryl spray
493	165	en	2014-05-03 15:26:19.435554	2014-05-03 15:44:36.265558	Hey, please be quiet	Quiet solar diurnal variation		fibreboard, oil, acrylic spray
507	169	cz	2014-05-03 15:51:33.642837	2014-05-03 15:52:37.081062	Light and sound of time		<p>From <a href="http://nonpandoras.com/artworks/140-0057">http://nonpandoras.com/artworks/140-0057</a></p>	dřevovláknitá deska, olejomalba, akryl spray
506	169	ru	2014-05-03 15:51:33.638016	2014-05-03 15:52:37.082971	Свет и звук времени		<p>From <a href="http://nonpandoras.com/artworks/140-0057">http://nonpandoras.com/artworks/140-0057</a></p>	ДВП, масло, аэрозольный акрил
505	169	en	2014-05-03 15:51:33.632396	2014-05-03 15:52:37.084061	Light and sound of time		<p>From&nbsp;<a href="http://nonpandoras.com/artworks/140-0057">http://nonpandoras.com/artworks/140-0057</a></p>	fibreboard, oil, acrylic spray
377	126	ru	2014-03-27 14:16:39.286362	2014-05-05 09:27:21.597915	Без названия #15		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
376	126	en	2014-03-27 14:16:39.284773	2014-05-05 09:27:21.617743	Untitled #15		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
374	125	ru	2014-03-27 14:15:08.347835	2014-05-05 10:09:11.149049	Мгновение		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
371	124	ru	2014-03-27 14:09:45.959955	2014-05-05 10:11:49.528841	Смысл жизни		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
370	124	en	2014-03-27 14:09:45.95747	2014-05-05 10:11:49.530321	The sense of life		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
368	123	ru	2014-03-27 14:07:02.44255	2014-05-05 10:14:24.278874	Время работать и время отдыхать		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
362	121	ru	2014-03-27 13:54:19.565176	2014-05-05 10:19:33.363918	Ἡράκλειτος	Дремлющий Гераклит и его видения о нас	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
361	121	en	2014-03-27 13:54:19.563313	2014-05-05 10:19:33.365665	Ἡράκλειτος	Slumbering Heraclitus and his vision about us	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
358	120	en	2014-03-27 13:45:15.477019	2014-05-05 10:23:21.059382	The art of thought	Idea and embodiment	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
356	119	ru	2014-03-27 13:34:10.021474	2014-05-05 10:24:57.744667	Ветер		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
455	152	ru	2014-03-28 11:26:35.397557	2014-05-05 10:27:17.586281	Без названия #17		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
456	152	cz	2014-03-28 11:26:35.400462	2014-05-05 10:27:17.589937	Bez názvu #17		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
364	122	en	2014-03-27 14:04:59.563981	2014-05-05 10:32:04.88755	Untitled #14		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
365	122	ru	2014-03-27 14:04:59.566003	2014-05-05 10:32:04.88907	Без названия #14		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
353	118	ru	2014-03-27 13:32:11.811131	2014-05-05 10:27:33.027857	Без названия #13		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
352	118	en	2014-03-27 13:32:11.808635	2014-05-05 10:27:33.049489	Untitled #13		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
460	154	en	2014-03-28 11:29:56.627592	2014-05-05 10:30:45.545136	Untitled #18		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
379	127	en	2014-03-27 14:18:26.561337	2014-05-05 10:31:30.252034	Untitled #16		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
380	127	ru	2014-03-27 14:18:26.563027	2014-05-05 10:31:30.254771	Без названия #16		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
350	117	ru	2014-03-27 13:28:55.027316	2014-05-05 10:31:42.19832	Потерянный звук		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
347	116	ru	2014-03-27 10:34:24.617269	2014-05-05 10:35:36.480409	Без названия #12		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
346	116	en	2014-03-27 10:34:24.614969	2014-05-05 10:35:36.482264	Untitled #12		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
344	115	ru	2014-03-27 10:32:55.922957	2014-05-05 10:39:10.432198	Борода		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
337	113	en	2014-03-27 10:26:22.195559	2014-05-05 10:46:13.06061	Untitled #11		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
338	113	ru	2014-03-27 10:26:22.199102	2014-05-05 10:46:13.064696	Без названия #11		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
319	107	en	2014-03-15 16:15:53.734629	2014-05-05 11:38:13.420476	Untitled #8	...	<object width="200" height="150"><param name="movie" value="//www.youtube.com/v/ZI_iy09RFZg?version=3&hl=ru_RU&rel=0"><param name="allowFullScreen" value="true"><param name="allowscriptaccess" value="always"><embed src="//www.youtube.com/v/ZI_iy09RFZg?version=3&hl=ru_RU&rel=0" type="application/x-shockwave-flash" width="200" height="150" allowscriptaccess="always" allowfullscreen="true"><p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p></object>	paper, ink, technical pen
321	107	cz	2014-03-15 16:15:53.737835	2014-05-05 11:38:13.424402	Bez názvu #8	...	<object width="200" height="150"><param name="movie" value="//www.youtube.com/v/ZI_iy09RFZg?version=3&hl=ru_RU&rel=0"><param name="allowFullScreen" value="true"><param name="allowscriptaccess" value="always"><embed src="//www.youtube.com/v/ZI_iy09RFZg?version=3&hl=ru_RU&rel=0" type="application/x-shockwave-flash" width="200" height="150" allowscriptaccess="always" allowfullscreen="true"><p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p></object>	papír, tuš, technické pero
316	106	en	2014-03-15 16:01:19.404053	2014-05-05 11:40:35.512177	Untitled #7	...	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
317	106	ru	2014-03-15 16:01:19.406024	2014-05-05 11:40:35.514198	Без названия #7	...	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
301	101	en	2014-03-15 15:10:02.230936	2014-05-05 11:52:54.825752	Untitled #6	...	<object width="200" height="150"><param name="movie" value="//www.youtube.com/v/G0m-137dGHc?version=3&hl=ru_RU&rel=0"><param name="allowFullScreen" value="true"><param name="allowscriptaccess" value="always"><embed src="//www.youtube.com/v/G0m-137dGHc?version=3&hl=ru_RU&rel=0" type="application/x-shockwave-flash" width="200" height="150" allowscriptaccess="always" allowfullscreen="true"><p>Size of mat on each side - 7 cm</p></object><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
303	101	cz	2014-03-15 15:10:02.234977	2014-05-05 11:52:54.829877	Bez názvu #6	...	<object width="200" height="150"><param name="movie" value="//www.youtube.com/v/G0m-137dGHc?version=3&hl=ru_RU&rel=0"><param name="allowFullScreen" value="true"><param name="allowscriptaccess" value="always"><embed src="//www.youtube.com/v/G0m-137dGHc?version=3&hl=ru_RU&rel=0" type="application/x-shockwave-flash" width="200" height="150" allowscriptaccess="always" allowfullscreen="true"><p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p></object>	papír, tuš, technické pero
271	91	en	2014-03-15 13:27:40.118844	2014-05-06 07:50:13.09547	New days	Omnis accipiunt	<p><embed src="//www.youtube.com/v/MWh-2l0Hv0Y?version=3&hl=ru_RU&rel=0" type="application/x-shockwave-flash" width="200" height="150" allowscriptaccess="always" allowfullscreen="true" style="background-color: rgb(246, 246, 246); font-size: 15px; line-height: 1.5rem;"></p><p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
263	88	ru	2014-03-15 12:49:24.836931	2014-05-06 08:46:15.078911	Утки II	Крутящийся диск в небе	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
302	101	ru	2014-03-15 15:10:02.232776	2014-05-05 11:52:54.827552	Без названия #6	...	<object width="200" height="150"><param name="movie" value="//www.youtube.com/v/G0m-137dGHc?version=3&hl=ru_RU&rel=0"><param name="allowFullScreen" value="true"><param name="allowscriptaccess" value="always"><embed src="//www.youtube.com/v/G0m-137dGHc?version=3&hl=ru_RU&rel=0" type="application/x-shockwave-flash" width="200" height="150" allowscriptaccess="always" allowfullscreen="true"><p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p></object>	бумага, тушь, рапидограф
299	100	ru	2014-03-15 15:08:25.771207	2014-05-06 04:58:27.049724	Без названия #5	...	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
298	100	en	2014-03-15 15:08:25.769407	2014-05-06 04:58:27.051499	Untitled #5	...	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
296	99	ru	2014-03-15 15:04:06.30572	2014-05-06 05:02:35.989396	Радиовышки		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
294	98	cz	2014-03-15 14:56:13.988636	2014-05-06 05:05:48.834085	Krajina	Hvězdy a kopce	<object width="200" height="150"><param name="movie" value="//www.youtube.com/v/hck89wOfil8?hl=ru_RU&version=3&rel=0"><param name="allowFullScreen" value="true"><param name="allowscriptaccess" value="always"><embed src="//www.youtube.com/v/hck89wOfil8?hl=ru_RU&version=3&rel=0" type="application/x-shockwave-flash" width="200" height="150" allowscriptaccess="always" allowfullscreen="true"><p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p></object>	papír, tuš, technické pero
293	98	ru	2014-03-15 14:56:13.987127	2014-05-06 05:05:48.836228	Ландшафт	Звезды и холмы	<object width="200" height="150"><param name="movie" value="//www.youtube.com/v/hck89wOfil8?hl=ru_RU&version=3&rel=0"><param name="allowFullScreen" value="true"><param name="allowscriptaccess" value="always"><embed src="//www.youtube.com/v/hck89wOfil8?hl=ru_RU&version=3&rel=0" type="application/x-shockwave-flash" width="200" height="150" allowscriptaccess="always" allowfullscreen="true"><p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p></object>	бумага, тушь, рапидограф
542	181	ru	2014-06-03 17:02:28.081321	2014-06-03 17:02:28.081321	Без названия #21		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
292	98	en	2014-03-15 14:56:13.984971	2014-05-06 05:05:48.837585	Landscape	Stars and hills	<object width="200" height="150"><param name="movie" value="//www.youtube.com/v/hck89wOfil8?hl=ru_RU&version=3&rel=0"><param name="allowFullScreen" value="true"><param name="allowscriptaccess" value="always"><embed src="//www.youtube.com/v/hck89wOfil8?hl=ru_RU&version=3&rel=0" type="application/x-shockwave-flash" width="200" height="150" allowscriptaccess="always" allowfullscreen="true"><p>Size of mat on each side - 7 cm</p></object><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
282	94	cz	2014-03-15 13:42:18.187145	2014-05-06 07:25:00.007813	Bez názvu #3	...	<p><embed src="//www.youtube.com/v/TY5vx7_704A?version=3&hl=ru_RU&rel=0" type="application/x-shockwave-flash" width="200" height="150" allowscriptaccess="always" allowfullscreen="true" style="background-color: rgb(246, 246, 246); font-size: 15px; line-height: 1.5rem;"></p><p>Pečujte o své dítě</p><p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
281	94	ru	2014-03-15 13:42:18.185616	2014-05-06 07:25:00.010479	Без названия #3	...	<p><embed src="//www.youtube.com/v/TY5vx7_704A?version=3&hl=ru_RU&rel=0" type="application/x-shockwave-flash" width="200" height="150" allowscriptaccess="always" allowfullscreen="true" style="background-color: rgb(246, 246, 246); font-size: 15px; line-height: 1.5rem;"></p><p>Берегите своего ребёнка</p><p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
280	94	en	2014-03-15 13:42:18.183059	2014-05-06 07:25:00.01187	Untitled #3	...	<p><embed src="//www.youtube.com/v/TY5vx7_704A?version=3&hl=ru_RU&rel=0" type="application/x-shockwave-flash" width="200" height="150" allowscriptaccess="always" allowfullscreen="true" style="background-color: rgb(246, 246, 246); font-size: 15px; line-height: 1.5rem;"></p><p>Save your child</p><p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
279	93	cz	2014-03-15 13:39:11.364218	2014-05-06 07:27:52.215098	Bez názvu #2	...	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
278	93	ru	2014-03-15 13:39:11.362554	2014-05-06 07:27:52.216773	Без названия #2	...	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
277	93	en	2014-03-15 13:39:11.360425	2014-05-06 07:27:52.218183	Untitled #2	...	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
275	92	ru	2014-03-15 13:35:18.632835	2014-05-06 07:36:42.351414	Разделитель		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
273	91	cz	2014-03-15 13:27:40.122127	2014-05-06 07:50:13.083691	Nové dní	Omnis accipiunt	<p><embed src="//www.youtube.com/v/MWh-2l0Hv0Y?version=3&hl=ru_RU&rel=0" type="application/x-shockwave-flash" width="200" height="150" allowscriptaccess="always" allowfullscreen="true" style="background-color: rgb(246, 246, 246); font-size: 15px; line-height: 1.5rem;"></p><p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
272	91	ru	2014-03-15 13:27:40.120598	2014-05-06 07:50:13.093727	Новые дни	Omnis accipiunt	<p><embed src="//www.youtube.com/v/MWh-2l0Hv0Y?version=3&hl=ru_RU&rel=0" type="application/x-shockwave-flash" width="200" height="150" allowscriptaccess="always" allowfullscreen="true" style="background-color: rgb(246, 246, 246); font-size: 15px; line-height: 1.5rem;"></p><p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
257	86	ru	2014-03-15 12:12:34.257885	2014-05-06 09:32:41.761748	Без названия #1 	...	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
254	85	ru	2014-03-15 12:08:52.029188	2014-05-06 09:50:10.898418	"Эй, ребята!"	Канаты	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
251	84	ru	2014-03-15 12:04:37.36517	2014-05-06 12:12:20.888553	"Помогите нам..."	Канаты	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
250	84	en	2014-03-15 12:04:37.363529	2014-05-06 12:12:20.89002	"Help us..."	Ropes	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
248	83	ru	2014-03-15 11:54:34.736483	2014-05-06 12:42:26.589941	"Поймайте его!"	Старые и новые идеи	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
246	82	cz	2014-03-14 07:44:21.347358	2014-05-06 12:55:19.258644	Šťastný den	Samotář	<object width="200" height="150"><param name="movie" value="//www.youtube.com/v/jPnP3Sqi3kQ?hl=ru_RU&version=3&rel=0"><param name="allowFullScreen" value="true"><param name="allowscriptaccess" value="always"><embed src="//www.youtube.com/v/jPnP3Sqi3kQ?hl=ru_RU&version=3&rel=0" type="application/x-shockwave-flash" width="200" height="150" allowscriptaccess="always" allowfullscreen="true"><p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p></object>	papír, tuš, technické pero
245	82	ru	2014-03-14 07:44:21.345839	2014-05-06 12:55:19.300815	Счастливый день	Одиночка	<object width="200" height="150"><param name="movie" value="//www.youtube.com/v/jPnP3Sqi3kQ?hl=ru_RU&version=3&rel=0"><param name="allowFullScreen" value="true"><param name="allowscriptaccess" value="always"><embed src="//www.youtube.com/v/jPnP3Sqi3kQ?hl=ru_RU&version=3&rel=0" type="application/x-shockwave-flash" width="200" height="150" allowscriptaccess="always" allowfullscreen="true"><p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p></object>	бумага, тушь, рапидограф
244	82	en	2014-03-14 07:44:21.342291	2014-05-06 12:55:19.303013	Happy day	Loner	<object width="200" height="150"><param name="movie" value="//www.youtube.com/v/jPnP3Sqi3kQ?hl=ru_RU&version=3&rel=0"><param name="allowFullScreen" value="true"><param name="allowscriptaccess" value="always"><embed src="//www.youtube.com/v/jPnP3Sqi3kQ?hl=ru_RU&version=3&rel=0" type="application/x-shockwave-flash" width="200" height="150" allowscriptaccess="always" allowfullscreen="true"><p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p></object>	paper, ink, technical pen
513	171	cz	2014-06-03 12:11:00.701632	2014-06-03 12:11:00.701632	Ptáci nad věží	Stejně jako neurony v hlavě	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
517	173	en	2014-06-03 12:38:21.358892	2014-06-03 12:38:21.358892	Down-Up-Down		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
518	173	ru	2014-06-03 12:38:21.361225	2014-06-03 12:38:21.361225	Down-Up-Down		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
519	173	cz	2014-06-03 12:38:21.362911	2014-06-03 12:38:21.362911	Down-Up-Down		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
520	174	en	2014-06-03 12:45:43.84302	2014-06-03 12:45:43.84302	Parallel lines on a field		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
521	174	ru	2014-06-03 12:45:43.845558	2014-06-03 12:45:43.845558	Параллельные линии на поле		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
522	174	cz	2014-06-03 12:45:43.847048	2014-06-03 12:45:43.847048	Paralelní linie na poli		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
526	176	en	2014-06-03 13:06:12.348042	2014-06-03 13:06:12.348042	Untitled #19	...	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
527	176	ru	2014-06-03 13:06:12.350547	2014-06-03 13:06:12.350547	Без названия #19	...	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
528	176	cz	2014-06-03 13:06:12.352048	2014-06-03 13:06:12.352048	Bez názvu #19	...	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
529	177	en	2014-06-03 13:13:34.142416	2014-06-03 13:13:34.142416	Untitled #20		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
530	177	ru	2014-06-03 13:13:34.144886	2014-06-03 13:13:34.144886	Без названия #20		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
531	177	cz	2014-06-03 13:13:34.146531	2014-06-03 13:13:34.146531	Bez názvu #20		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
532	178	en	2014-06-03 13:29:04.231671	2014-06-03 13:29:04.231671	Sequence		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
533	178	ru	2014-06-03 13:29:04.234096	2014-06-03 13:29:04.234096	Последовательность		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
534	178	cz	2014-06-03 13:29:04.235586	2014-06-03 13:29:04.235586	Posloupnost		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
535	179	en	2014-06-03 13:34:51.379496	2014-06-03 13:34:51.379496	Haystacks		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
536	179	ru	2014-06-03 13:34:51.381886	2014-06-03 13:34:51.381886	Стога		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
537	179	cz	2014-06-03 13:34:51.383409	2014-06-03 13:34:51.383409	Kupky sena		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
538	180	en	2014-06-03 16:52:43.636184	2014-06-03 16:52:43.636184	Lost in the stacks		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
523	175	en	2014-06-03 12:57:25.322565	2014-07-07 14:27:54.492892	The Moths		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
524	175	ru	2014-06-03 12:57:25.324856	2014-07-07 14:27:54.504137	The Moths		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
525	175	cz	2014-06-03 12:57:25.326445	2014-07-07 14:27:54.505748	The Moths		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
539	180	ru	2014-06-03 16:52:43.638318	2014-06-03 16:52:43.638318	Потерявшийся в стогах		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
540	180	cz	2014-06-03 16:52:43.641104	2014-06-03 16:52:43.641104	Ztraceni v stohů		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
541	181	en	2014-06-03 17:02:28.079318	2014-06-03 17:02:28.079318	Untitled #21		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
601	201	en	2014-06-04 06:53:03.161654	2014-06-04 06:53:03.161654	Radio towers		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
543	181	cz	2014-06-03 17:02:28.082819	2014-06-03 17:02:28.082819	Bez názvu #21		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
544	182	en	2014-06-03 17:29:04.643957	2014-06-03 17:39:34.899199	Aníta KE-399	In work	<p><img src="/uploads/redactor_assets/pictures/12/DeliverFile.jpg" alt="" style="width: 366px;"></p><p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
545	182	ru	2014-06-03 17:29:04.646412	2014-06-03 17:39:34.903191	Aníta KE-399	In work	<p><img src="http://nonpandoras.com/uploads/redactor_assets/pictures/12/DeliverFile.jpg" alt="" style="width: 366px;"></p><p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
546	182	cz	2014-06-03 17:29:04.647888	2014-06-03 17:39:34.904399	Aníta KE-399	In work	<p><img src="http://nonpandoras.com/uploads/redactor_assets/pictures/12/DeliverFile.jpg" alt="" style="width: 366px;"></p><p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
547	183	en	2014-06-04 04:38:57.696188	2014-06-04 04:38:57.696188	Untitled #22		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
548	183	ru	2014-06-04 04:38:57.69864	2014-06-04 04:38:57.69864	Без названия #22		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
549	183	cz	2014-06-04 04:38:57.700272	2014-06-04 04:38:57.700272	Bez názvu #22		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
550	184	en	2014-06-04 04:43:38.218937	2014-06-04 04:43:38.218937	Partly Cloudy		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
551	184	ru	2014-06-04 04:43:38.222177	2014-06-04 04:43:38.222177	Переменная облачность		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
552	184	cz	2014-06-04 04:43:38.223858	2014-06-04 04:43:38.223858	Částečně oblačno		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
553	185	en	2014-06-04 04:49:29.632207	2014-06-04 04:49:29.632207	Untitled #23	...	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
554	185	ru	2014-06-04 04:49:29.642443	2014-06-04 04:49:29.642443	Без названия #23	...	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
555	185	cz	2014-06-04 04:49:29.644468	2014-06-04 04:49:29.644468	Bez názvu #23	...	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
556	186	en	2014-06-04 05:00:16.971739	2014-06-04 05:00:16.971739	In the hills		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
557	186	ru	2014-06-04 05:00:16.974122	2014-06-04 05:00:16.974122	In the hills		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
558	186	cz	2014-06-04 05:00:16.975685	2014-06-04 05:00:16.975685	In the hills		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
559	187	en	2014-06-04 05:07:19.482532	2014-06-04 05:07:19.482532	Voyageur		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
514	172	en	2014-06-03 12:30:28.500218	2014-06-05 15:00:22.13757	Somewhere on the field		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
560	187	ru	2014-06-04 05:07:19.486448	2014-06-04 05:07:19.486448	Voyageur		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
561	187	cz	2014-06-04 05:07:19.49433	2014-06-04 05:07:19.49433	Voyageur		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
562	188	en	2014-06-04 05:10:19.358529	2014-06-04 05:10:19.358529	...		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen, color pencil
563	188	ru	2014-06-04 05:10:19.360832	2014-06-04 05:10:19.360832	...		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф, цветной карандаш
564	188	cz	2014-06-04 05:10:19.362378	2014-06-04 05:10:19.362378	...		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero, pastelka
565	189	en	2014-06-04 05:20:49.993517	2014-06-04 05:20:49.993517	Untitled #24		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
566	189	ru	2014-06-04 05:20:49.99727	2014-06-04 05:20:49.99727	Без названия #24		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
567	189	cz	2014-06-04 05:20:49.998703	2014-06-04 05:20:49.998703	Bez názvu #24		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
568	190	en	2014-06-04 05:28:14.644057	2014-06-04 05:28:14.644057	Be careful!	Bad mood!	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
600	200	cz	2014-06-04 06:49:23.796162	2014-06-04 06:49:23.796162	Králíci na střeše		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
569	190	ru	2014-06-04 05:28:14.646051	2014-06-04 05:28:14.646051	Будь осторожнее! 	Плохое настроение!	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
570	190	cz	2014-06-04 05:28:14.647607	2014-06-04 05:28:14.647607	Be careful!	Bad mood!	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
571	191	en	2014-06-04 05:36:48.70811	2014-06-04 05:36:48.70811	Untitled #25	...	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
572	191	ru	2014-06-04 05:36:48.710314	2014-06-04 05:36:48.710314	Без названия #25	...	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
573	191	cz	2014-06-04 05:36:48.71184	2014-06-04 05:36:48.71184	Bez názvu #25	...	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
574	192	en	2014-06-04 05:39:28.703797	2014-06-04 05:42:05.968251	When we go to work 	The Song of thoughts	<p><embed src="//www.youtube.com/v/3A786lOX8jc?version=3&hl=ru_RU&rel=0" type="application/x-shockwave-flash" width="200" height="150" allowscriptaccess="always" allowfullscreen="true" style="font-size: 15px; line-height: 1.5rem; background-color: rgb(246, 246, 246);"></p><p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
575	192	ru	2014-06-04 05:39:28.706373	2014-06-04 05:42:05.975717	Когда мы идем на работу	Песня мыслей	<p><embed src="//www.youtube.com/v/3A786lOX8jc?version=3&hl=ru_RU&rel=0" type="application/x-shockwave-flash" width="200" height="150" allowscriptaccess="always" allowfullscreen="true" style="font-size: 15px; line-height: 1.5rem; background-color: rgb(246, 246, 246);"></p><p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
576	192	cz	2014-06-04 05:39:28.707978	2014-06-04 05:42:05.97721	Když jdeme do práce	Píseň myšlenek	<p><embed src="//www.youtube.com/v/3A786lOX8jc?version=3&hl=ru_RU&rel=0" type="application/x-shockwave-flash" width="200" height="150" allowscriptaccess="always" allowfullscreen="true" style="font-size: 15px; line-height: 1.5rem; background-color: rgb(246, 246, 246);"></p><p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
578	193	ru	2014-06-04 05:57:20.074126	2014-06-04 05:57:20.074126	Без названия #26		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
579	193	cz	2014-06-04 05:57:20.076538	2014-06-04 05:57:20.076538	Bez názvu #26		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
580	194	en	2014-06-04 06:05:39.252515	2014-06-04 06:05:39.252515	When we come back from work	The Song of thoughts	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
581	194	ru	2014-06-04 06:05:39.261774	2014-06-04 06:05:39.261774	Когда мы возвращаемся с работы	Песня мыслей	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
582	194	cz	2014-06-04 06:05:39.263613	2014-06-04 06:05:39.263613	Když se vrátíme z práce	Píseň myšlenek	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
583	195	en	2014-06-04 06:11:33.998713	2014-06-04 06:11:33.998713	Calm		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
584	195	ru	2014-06-04 06:11:34.006652	2014-06-04 06:11:34.006652	Спокойствие		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
585	195	cz	2014-06-04 06:11:34.008462	2014-06-04 06:11:34.008462	Klid		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
586	196	en	2014-06-04 06:18:22.022084	2014-06-04 06:18:22.022084	Mixed forests		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
587	196	ru	2014-06-04 06:18:22.024468	2014-06-04 06:18:22.024468	Смешанный лес		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
588	196	cz	2014-06-04 06:18:22.026131	2014-06-04 06:18:22.026131	Smíšený les		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
593	198	ru	2014-06-04 06:33:40.303175	2014-06-04 06:33:40.303175	Чистое небо	Прошлое и будущее	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
594	198	cz	2014-06-04 06:33:40.305524	2014-06-04 06:33:40.305524	Jasné obloze	Minulost a budoucnost	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
592	198	en	2014-06-04 06:33:40.293461	2014-06-04 06:34:51.208592	Clear sky	Past and Future	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
598	200	en	2014-06-04 06:49:23.783886	2014-06-04 06:49:23.783886	Rabbits on the roof		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
599	200	ru	2014-06-04 06:49:23.794295	2014-06-04 06:49:23.794295	Кролики на крыше		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
602	201	ru	2014-06-04 06:53:03.163985	2014-06-04 06:53:03.163985	Радиовышки		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
603	201	cz	2014-06-04 06:53:03.166194	2014-06-04 06:53:03.166194	Rádiové věže		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
604	202	en	2014-06-04 06:55:44.045943	2014-06-04 06:55:44.045943	Untitled #28		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
634	212	en	2014-07-16 07:52:00.482355	2014-07-16 07:57:22.148367	Forest of thinking		<p><a href="http://nonpandoras.com/artworks/139-0056">http://nonpandoras.com/artworks/139-0056</a></p>	fibreboard, oil, acrylic spray
635	212	ru	2014-07-16 07:52:00.484543	2014-07-16 07:57:22.150138	Лес размышлений		<p><a href="http://nonpandoras.com/artworks/139-0056">http://nonpandoras.com/artworks/139-0056</a></p>	ДВП, масло, аэрозольный акрил
591	197	cz	2014-06-04 06:25:26.996335	2014-07-26 14:11:52.466224	Sklon rotační osy		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
589	197	en	2014-06-04 06:25:26.982641	2014-07-26 14:11:52.469677	Axial tilt		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
605	202	ru	2014-06-04 06:55:44.048835	2014-06-04 06:55:44.048835	Без названия #28		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
606	202	cz	2014-06-04 06:55:44.051252	2014-06-04 06:55:44.051252	Bez názvu #28		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
610	204	en	2014-06-04 07:06:17.578646	2014-06-04 07:06:17.578646	Melancholic smell of distant rain	2 May's evening	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
611	204	ru	2014-06-04 07:06:17.582505	2014-06-04 07:06:17.582505	Melancholic smell of distant rain	2 May's evening	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
612	204	cz	2014-06-04 07:06:17.595343	2014-06-04 07:06:17.595343	Melancholic smell of distant rain	2 May's evening	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
613	205	en	2014-06-04 07:26:41.303578	2014-06-04 07:26:41.303578	In a landscape	When we need love	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
614	205	ru	2014-06-04 07:26:41.306998	2014-06-04 07:26:41.306998	In a landscape	Когда мы нуждаемся в любви	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
615	205	cz	2014-06-04 07:26:41.308694	2014-06-04 07:26:41.308694	In a landscape	Když potřebujeme lásku	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
616	206	en	2014-06-04 07:28:28.397355	2014-06-04 07:28:28.397355	Blinded by the Sun		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
617	206	ru	2014-06-04 07:28:28.406146	2014-06-04 07:28:28.406146	Ослепленный солнцем		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
618	206	cz	2014-06-04 07:28:28.408013	2014-06-04 07:28:28.408013	Zaslepeni sluncem		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
619	207	en	2014-06-04 07:32:29.690154	2014-06-04 07:32:29.690154	Empathy		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
620	207	ru	2014-06-04 07:32:29.691928	2014-06-04 07:32:29.691928	Эмпатия		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
621	207	cz	2014-06-04 07:32:29.69347	2014-06-04 07:32:29.69347	Empatie		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
622	208	en	2014-06-04 07:38:11.933859	2014-06-04 07:38:11.933859	The Hot Sunshine and Cold Air		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
623	208	ru	2014-06-04 07:38:11.935716	2014-06-04 07:38:11.935716	Горячий солнечный свет и холодный воздух		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
624	208	cz	2014-06-04 07:38:11.941307	2014-06-04 07:38:11.941307	Horké slunce a studený vzduch		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
625	209	en	2014-06-04 08:29:08.007781	2014-06-04 08:29:08.007781	Sound of the Wind passing through branches and leaves of trees		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
626	209	ru	2014-06-04 08:29:08.010562	2014-06-04 08:29:08.010562	Звук ветра, проходящий сквозь ветви и листья деревьев		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
627	209	cz	2014-06-04 08:29:08.012089	2014-06-04 08:29:08.012089	Sound of the Wind passing through branches and leaves of trees		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
628	210	en	2014-06-04 08:30:22.202636	2014-06-04 08:30:22.202636	A thousand and one times		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
629	210	ru	2014-06-04 08:30:22.204566	2014-06-04 08:30:22.204566	Тысяча и один раз		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
630	210	cz	2014-06-04 08:30:22.206288	2014-06-04 08:30:22.206288	Tisíc a jeden krát		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
631	211	en	2014-07-16 07:47:30.988166	2014-07-16 07:56:20.843281	...		<p><a href="http://nonpandoras.com/artworks/188-0100">http://nonpandoras.com/artworks/188-0100</a></p>	fibreboard, oil, acrylic spray
632	211	ru	2014-07-16 07:47:31.020552	2014-07-16 07:56:20.848186	...		<p><a href="http://nonpandoras.com/artworks/188-0100">http://nonpandoras.com/artworks/188-0100</a></p>	ДВП, масло, аэрозольный акрил
633	211	cz	2014-07-16 07:47:31.022763	2014-07-16 07:56:20.849814	...		<p><a href="http://nonpandoras.com/artworks/188-0100">http://nonpandoras.com/artworks/188-0100</a></p>	dřevovláknitá deska, olejomalba, akryl spray
636	212	cz	2014-07-16 07:52:00.486145	2014-07-16 07:57:22.151357	Les myšlení		<p><a href="http://nonpandoras.com/artworks/139-0056">http://nonpandoras.com/artworks/139-0056</a></p>	dřevovláknitá deska, olejomalba, akryl spray
515	172	ru	2014-06-03 12:30:28.50406	2014-06-05 15:00:22.13971	Где-то в поле		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
516	172	cz	2014-06-03 12:30:28.506398	2014-06-05 15:00:22.140804	Někde v poli		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
637	213	en	2014-07-16 08:02:48.776352	2014-07-16 15:49:46.76982	In the deep forest		<p><a href="http://nonpandoras.com/artworks/143-0060">http://nonpandoras.com/artworks/143-0060</a></p>	fibreboard, oil, acrylic spray
638	213	ru	2014-07-16 08:02:48.778365	2014-07-16 15:49:46.771755	В глубоком лесу		<p><a href="http://nonpandoras.com/artworks/143-0060">http://nonpandoras.com/artworks/143-0060</a></p>	ДВП, масло, аэрозольный акрил
639	213	cz	2014-07-16 08:02:48.781002	2014-07-16 15:49:46.772924	V hlubokém lese		<p><a href="http://nonpandoras.com/artworks/143-0060">http://nonpandoras.com/artworks/143-0060</a></p>	dřevovláknitá deska, olejomalba, akryl spray
643	215	en	2014-07-20 18:19:07.660518	2014-07-20 18:19:07.660518	Untitled #29		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
644	215	ru	2014-07-20 18:19:07.66323	2014-07-20 18:19:07.66323	Без названия #29		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
645	215	cz	2014-07-20 18:19:07.664818	2014-07-20 18:19:07.664818	Bez názvu #29		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
640	214	en	2014-07-20 17:26:33.568103	2014-07-21 08:22:12.032998	Outer		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
641	214	ru	2014-07-20 17:26:33.570944	2014-07-21 08:22:12.037292	Outer		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
642	214	cz	2014-07-20 17:26:33.57244	2014-07-21 08:22:12.038866	Outer		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
649	217	en	2014-07-21 10:56:31.919915	2014-07-21 10:56:31.919915	Absorbers of photons		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
650	217	ru	2014-07-21 10:56:31.927396	2014-07-21 10:56:31.927396	Поглотители фотонов		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
651	217	cz	2014-07-21 10:56:31.929376	2014-07-21 10:56:31.929376	Absorbers of photons		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
652	218	en	2014-07-21 12:05:56.046741	2014-07-21 12:05:56.046741	Cascade of shadow	Composition I	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
653	218	ru	2014-07-21 12:05:56.049182	2014-07-21 12:05:56.049182	Cascade of shadow	Composition I	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
654	218	cz	2014-07-21 12:05:56.050695	2014-07-21 12:05:56.050695	Cascade of shadow	Composition I	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
648	216	cz	2014-07-21 08:13:51.718624	2014-12-10 10:53:17.570097	Černozem	Recurring time	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
647	216	ru	2014-07-21 08:13:51.717083	2014-12-10 10:53:17.614989	Чернозём	Повторяющееся время	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
646	216	en	2014-07-21 08:13:51.714501	2014-12-10 10:53:17.622642	Chernozem	Recurring time	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
590	197	ru	2014-06-04 06:25:26.994539	2014-07-26 14:11:52.468218	Наклон оси вращения		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
657	219	cz	2014-07-24 18:40:41.449545	2014-07-30 11:01:46.258685	Cascade of shadows	Composition II	<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	
677	226	ru	2014-12-09 20:40:39.446379	2014-12-09 20:40:39.446379	Nocturnal wind		<iframe width="200" height="113" src="//www.youtube.com/embed/1WyuZDhx3GE?rel=0" frameborder="0" allowfullscreen=""></iframe>	бумага, тушь, рапидограф
656	219	ru	2014-07-24 18:40:41.44675	2014-07-30 11:01:46.261158	Cascade of shadows	Composition II	<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
655	219	en	2014-07-24 18:40:41.443772	2014-07-30 11:01:46.262961	Cascade of shadows	Composition II	<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	
670	224	en	2014-11-28 10:11:59.206388	2014-11-28 10:11:59.206388	Untitled #32		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p><p><a href="http://nonpandoras.com/blog/5-forty-two-views">forty-two views of 57°10'14.2"n 65°29'54.0"e</a></p>	paper, ink, technical pen
661	221	en	2014-10-28 19:07:32.405744	2014-10-29 14:11:52.063043	Our friend is a moonlight		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p><p><a href="http://nonpandoras.com/blog/5-forty-two-views">forty-two views of 57°10'14.2"n 65°29'54.0"e</a></p>	paper, ink, technical pen
660	220	cz	2014-10-28 18:26:42.132024	2014-10-29 14:11:56.26933	Bez názvu #30		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p><p><a href="http://nonpandoras.com/blog/5-forty-two-views">forty-two views of 57°10'14.2"n 65°29'54.0"e</a></p>	papír, tuš, technické pero
659	220	ru	2014-10-28 18:26:42.123347	2014-10-29 14:11:56.2737	Без названия #30		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p><p><a href="http://nonpandoras.com/blog/5-forty-two-views">сорок два вида 57°10'14.2"n 65°29'54.0"e</a></p>	бумага, тушь, рапидограф
666	222	cz	2014-10-29 10:09:37.834631	2014-10-29 14:11:49.541817	Bez názvu #31		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p><p><a href="http://nonpandoras.com/blog/5-forty-two-views">forty-two views of 57°10'14.2"n 65°29'54.0"e</a></p>	papír, tuš, technické pero
665	222	ru	2014-10-29 10:09:37.829407	2014-10-29 14:11:49.554112	Без названия #31		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p><p><a href="http://nonpandoras.com/blog/5-forty-two-views">сорок два вида 57°10'14.2"n 65°29'54.0"e</a></p>	бумага, тушь, рапидограф
664	222	en	2014-10-29 10:09:37.822675	2014-10-29 14:11:49.561535	Untitled #31		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p><p><a href="http://nonpandoras.com/blog/5-forty-two-views">forty-two views of 57°10'14.2"n 65°29'54.0"e</a></p>	paper, ink, technical pen
663	221	cz	2014-10-28 19:07:32.422136	2014-10-29 14:11:52.053717	Náš přítel je měsíční svit		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p><p><a href="http://nonpandoras.com/blog/5-forty-two-views">forty-two views of 57°10'14.2"n 65°29'54.0"e</a></p>	papír, tuš, technické pero
662	221	ru	2014-10-28 19:07:32.414277	2014-10-29 14:11:52.058852	Наш друг - лунный свет		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p><p><a href="http://nonpandoras.com/blog/5-forty-two-views">сорок два вида 57°10'14.2"n 65°29'54.0"e</a></p>	бумага, тушь, рапидограф
658	220	en	2014-10-28 18:26:42.095995	2014-10-29 14:11:56.277224	Untitled #30		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p><p><a href="http://nonpandoras.com/blog/5-forty-two-views" target="_blank">forty-two views of 57°10'14.2"n 65°29'54.0"e</a></p>	paper, ink, technical pen
667	223	en	2014-11-06 09:17:35.897447	2014-11-06 09:17:35.897447	The Small. The Big. 		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
668	223	ru	2014-11-06 09:17:35.916536	2014-11-06 09:17:35.916536	Маленькое. Большое.		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
669	223	cz	2014-11-06 09:17:35.92392	2014-11-06 09:17:35.92392	The Small. The Big. 		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>	papír, tuš, technické pero
671	224	ru	2014-11-28 10:11:59.233342	2014-11-28 10:11:59.233342	Без названия #32		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p><p><a href="http://nonpandoras.com/blog/5-forty-two-views">сорок два вида 57°10'14.2"n 65°29'54.0"e</a></p>	бумага, тушь, рапидограф
690	230	cz	2015-02-05 21:52:35.010586	2015-02-05 22:05:40.88929	Brzy ráno února	Ospalost	<iframe width="200" height="113" src="https://www.youtube.com/embed/r9SnbhDEmgg?rel=0" frameborder="0" allowfullscreen=""></iframe>	papír, tuš, technické pero
689	230	ru	2015-02-05 21:52:35.00366	2015-02-05 22:05:40.898364	Раннее февральское утро	Дремота	<iframe width="200" height="113" src="https://www.youtube.com/embed/r9SnbhDEmgg?rel=0" frameborder="0" allowfullscreen=""></iframe>	бумага, тушь, рапидограф
688	230	en	2015-02-05 21:52:34.98347	2015-02-05 22:05:40.904711	Early February morning	Drowsiness	<iframe width="200" height="113" src="https://www.youtube.com/embed/r9SnbhDEmgg?rel=0" frameborder="0" allowfullscreen=""></iframe>	paper, ink, technical pen
672	224	cz	2014-11-28 10:11:59.241897	2014-11-28 10:11:59.241897	Bez názvu #32		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p><p><a href="http://nonpandoras.com/blog/5-forty-two-views">forty-two views of 57°10'14.2"n 65°29'54.0"e</a></p>	papír, tuš, technické pero
673	225	en	2014-12-06 19:10:46.706695	2014-12-06 19:10:46.706695	The Burning Hills		<iframe width="200" height="113" src="//www.youtube.com/embed/_WMP4jgXM3c?rel=0" frameborder="0" allowfullscreen=""></iframe>	paper, ink, technical pen
674	225	ru	2014-12-06 19:10:46.722701	2014-12-06 19:10:46.722701	Горящие холмы		<iframe width="200" height="113" src="//www.youtube.com/embed/_WMP4jgXM3c?rel=0" frameborder="0" allowfullscreen=""></iframe>	бумага, тушь, рапидограф
675	225	cz	2014-12-06 19:10:46.728435	2014-12-06 19:10:46.728435	The Burning Hills		<iframe width="200" height="113" src="//www.youtube.com/embed/_WMP4jgXM3c?rel=0" frameborder="0" allowfullscreen=""></iframe>	papír, tuš, technické pero
676	226	en	2014-12-09 20:40:39.430701	2014-12-09 20:40:39.430701	Nocturnal wind		<iframe width="200" height="113" src="//www.youtube.com/embed/1WyuZDhx3GE?rel=0" frameborder="0" allowfullscreen=""></iframe>	paper, ink, technical pen
678	226	cz	2014-12-09 20:40:39.451321	2014-12-09 20:40:39.451321	Nocturnal wind		<iframe width="200" height="113" src="//www.youtube.com/embed/1WyuZDhx3GE?rel=0" frameborder="0" allowfullscreen=""></iframe>	papír, tuš, technické pero
260	87	ru	2014-03-15 12:17:49.077533	2014-12-17 08:59:49.361	Утки	Крутящийся диск в небе	<iframe width="100%" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/176203611&color=ff5500&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false"></iframe><p>\r\n\tРазмер паспарту с каждой стороны - 7 см.</p><p>\r\n\tКаждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>	бумага, тушь, рапидограф
259	87	en	2014-03-15 12:17:49.075812	2014-12-17 08:59:49.374625	Ducks	 Spinning disc in the sky	<iframe width="100%" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/176203611&color=ff5500&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false"></iframe><p>\r\n\tSize of mat on each side - 7 cm</p><p>\r\n\tEach decorated drawing comes complete with glass and pendant system.</p>	paper, ink, technical pen
679	227	en	2014-12-22 10:55:05.322629	2014-12-22 10:55:05.322629	Good news		<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p><p><a href="http://nonpandoras.com/blog/5-forty-two-views">forty-two views of 57°10'14.2"n 65°29'54.0"e</a></p>	paper, ink, technical pen, color pencil
680	227	ru	2014-12-22 10:55:05.345977	2014-12-22 10:55:05.345977	Хорошие новости		<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p><p><a href="http://nonpandoras.com/blog/5-forty-two-views">сорок два вида 57°10'14.2"n 65°29'54.0"e</a></p>	бумага, тушь, рапидограф, цветной карандаш
681	227	cz	2014-12-22 10:55:05.351808	2014-12-22 10:55:31.369618	Dobré zprávy		<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p><p><a href="http://nonpandoras.com/blog/5-forty-two-views">forty-two views of 57°10'14.2"n 65°29'54.0"e</a></p>	papír, tuš, technické pero, pastelka
682	228	en	2014-12-27 16:46:27.05932	2014-12-27 16:46:27.05932	Forgotten Good Memories 		<p><a href="http://nonpandoras.com/blog/5-forty-two-views">forty-two views of 57°10'14.2"n 65°29'54.0"e</a></p>	paper, ink, technical pen
683	228	ru	2014-12-27 16:46:27.081115	2014-12-27 16:46:27.081115	Забытые хорошие воспоминания		<p><a href="http://nonpandoras.com/blog/5-forty-two-views">сорок два вида 57°10'14.2"n 65°29'54.0"e</a></p>	бумага, тушь, рапидограф
684	228	cz	2014-12-27 16:46:27.091726	2014-12-27 16:46:27.091726	Forgotten Good Memories 		<p><a href="http://nonpandoras.com/blog/5-forty-two-views">forty-two views of 57°10'14.2"n 65°29'54.0"e</a></p>	papír, tuš, technické pero
685	229	en	2015-02-01 17:35:12.493337	2015-02-01 17:35:12.493337	Untitled #33		<iframe width="200" height="150" src="https://www.youtube.com/embed/G0m-137dGHc?rel=0" frameborder="0" allowfullscreen=""></iframe>	paper, ink, technical pen
686	229	ru	2015-02-01 17:35:12.516834	2015-02-01 17:35:12.516834	Без названия #33 		<iframe width="200" height="150" src="https://www.youtube.com/embed/G0m-137dGHc?rel=0" frameborder="0" allowfullscreen=""></iframe>	бумага, тушь, рапидограф
687	229	cz	2015-02-01 17:35:12.523047	2015-02-01 17:35:12.523047	Bez názvu #33		<iframe width="200" height="150" src="https://www.youtube.com/embed/G0m-137dGHc?rel=0" frameborder="0" allowfullscreen=""></iframe>	papír, tuš, technické pero
694	232	en	2015-03-05 07:18:49.516938	2015-03-05 07:18:49.516938	The Viscous Time #2	Coal	<iframe width="200" height="150" src="https://www.youtube.com/embed/o3QM12VI1lQ?rel=0" frameborder="0" allowfullscreen=""></iframe>	paper, ink, technical pen
695	232	ru	2015-03-05 07:18:49.537057	2015-03-05 07:18:49.537057	Вязкое Время #2	Ископаемый уголь	<iframe width="200" height="150" src="https://www.youtube.com/embed/o3QM12VI1lQ?rel=0" frameborder="0" allowfullscreen=""></iframe>	бумага, тушь, рапидограф
696	232	cz	2015-03-05 07:18:49.54255	2015-03-05 07:18:49.54255	The Viscous Time #2	Uhlí	<iframe width="200" height="150" src="https://www.youtube.com/embed/o3QM12VI1lQ?rel=0" frameborder="0" allowfullscreen=""></iframe>	papír, tuš, technické pero
703	235	en	2015-04-01 06:02:02.619433	2015-04-01 06:02:02.619433	Spring divers			paper, ink, technical pen
704	235	ru	2015-04-01 06:02:02.643669	2015-04-01 06:02:02.643669	Spring divers			бумага, тушь, рапидограф
705	235	cz	2015-04-01 06:02:02.653224	2015-04-01 06:02:02.653224	Spring divers			papír, tuš, technické pero
693	231	cz	2015-02-17 16:09:45.685314	2015-03-16 20:08:08.835216	The Viscous Time #1		<iframe width="100%" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/180138934&color=0066cc&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false"></iframe>	papír, tuš, technické pero
692	231	ru	2015-02-17 16:09:45.676109	2015-03-16 20:08:08.860911	Вязкое Время #1		<iframe width="100%" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/180138934&color=0066cc&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false"></iframe>	бумага, тушь, рапидограф
691	231	en	2015-02-17 16:09:45.650034	2015-03-16 20:08:08.868171	The Viscous Time #1		<iframe width="100%" height="166" scrolling="no" frameborder="no" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/180138934&color=0066cc&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false"></iframe>	paper, ink, technical pen
697	233	en	2015-03-16 20:16:10.655282	2015-03-16 20:16:10.655282	Only idiots running against the Sun		<iframe width="200" height="113" src="https://www.youtube.com/embed/mNz422lImt4?rel=0" frameborder="0" allowfullscreen=""></iframe>	paper, ink, technical pen
698	233	ru	2015-03-16 20:16:10.663278	2015-03-16 20:16:10.663278	Только идиоты бегут от солнца		<iframe width="200" height="113" src="https://www.youtube.com/embed/mNz422lImt4?rel=0" frameborder="0" allowfullscreen=""></iframe>	бумага, тушь, рапидограф
699	233	cz	2015-03-16 20:16:10.668326	2015-03-16 20:16:10.668326	Jen idioti běží od slunce		<iframe width="200" height="113" src="https://www.youtube.com/embed/mNz422lImt4?rel=0" frameborder="0" allowfullscreen=""></iframe>	papír, tuš, technické pero
700	234	en	2015-03-29 17:23:06.758744	2015-03-29 17:23:06.758744	Beware of darkness		<iframe width="200" height="113" src="https://www.youtube.com/embed/T3D68KWfZOo?rel=0" frameborder="0" allowfullscreen=""></iframe>	paper, ink, technical pen
701	234	ru	2015-03-29 17:23:06.773728	2015-03-29 17:23:06.773728	Опасайся темноты		<iframe width="200" height="113" src="https://www.youtube.com/embed/T3D68KWfZOo?rel=0" frameborder="0" allowfullscreen=""></iframe>	бумага, тушь, рапидограф
702	234	cz	2015-03-29 17:23:06.778456	2015-03-29 17:23:06.778456	Pozor na temnoty		<iframe width="200" height="113" src="https://www.youtube.com/embed/T3D68KWfZOo?rel=0" frameborder="0" allowfullscreen=""></iframe>	papír, tuš, technické pero
\.


--
-- Name: artwork_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: scarfacedeb
--

SELECT pg_catalog.setval('artwork_translations_id_seq', 705, true);


--
-- Data for Name: artworks; Type: TABLE DATA; Schema: public; Owner: scarfacedeb
--

COPY artworks (id, category_id, is_published, image, price_kopeks, year, dimensions, is_available, slug, inserted_at, updated_at, framed_dimensions, translations, image_ratio) FROM stdin;
57436	1	t	Image-0031.png?63700688989	200000	2012	13 х 16	t	0031	2014-03-27 10:26:22.160498	2018-08-05 11:49:49.635775	22 x 25	{"cz": {"title": "Bez názvu #11", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Untitled #11", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #11", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57440	1	t	Image-0020.png?63700688990	150000	2011	9 х 21	t	0020	2014-03-15 15:10:02.227349	2018-08-05 11:49:50.063999	18 x 30	{"cz": {"title": "Bez názvu #6", "subtitle": "...", "technique": "papír, tuš, technické pero", "description": "<object width=\\"200\\" height=\\"150\\"><param name=\\"movie\\" value=\\"//www.youtube.com/v/G0m-137dGHc?version=3&hl=ru_RU&rel=0\\"><param name=\\"allowFullScreen\\" value=\\"true\\"><param name=\\"allowscriptaccess\\" value=\\"always\\"><embed src=\\"//www.youtube.com/v/G0m-137dGHc?version=3&hl=ru_RU&rel=0\\" type=\\"application/x-shockwave-flash\\" width=\\"200\\" height=\\"150\\" allowscriptaccess=\\"always\\" allowfullscreen=\\"true\\"><p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p></object>"}, "en": {"title": "Untitled #6", "subtitle": "...", "technique": "paper, ink, technical pen", "description": "<object width=\\"200\\" height=\\"150\\"><param name=\\"movie\\" value=\\"//www.youtube.com/v/G0m-137dGHc?version=3&hl=ru_RU&rel=0\\"><param name=\\"allowFullScreen\\" value=\\"true\\"><param name=\\"allowscriptaccess\\" value=\\"always\\"><embed src=\\"//www.youtube.com/v/G0m-137dGHc?version=3&hl=ru_RU&rel=0\\" type=\\"application/x-shockwave-flash\\" width=\\"200\\" height=\\"150\\" allowscriptaccess=\\"always\\" allowfullscreen=\\"true\\"><p>Size of mat on each side - 7 cm</p></object><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #6", "subtitle": "...", "technique": "бумага, тушь, рапидограф", "description": "<object width=\\"200\\" height=\\"150\\"><param name=\\"movie\\" value=\\"//www.youtube.com/v/G0m-137dGHc?version=3&hl=ru_RU&rel=0\\"><param name=\\"allowFullScreen\\" value=\\"true\\"><param name=\\"allowscriptaccess\\" value=\\"always\\"><embed src=\\"//www.youtube.com/v/G0m-137dGHc?version=3&hl=ru_RU&rel=0\\" type=\\"application/x-shockwave-flash\\" width=\\"200\\" height=\\"150\\" allowscriptaccess=\\"always\\" allowfullscreen=\\"true\\"><p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p></object>"}}	\N
57441	1	t	Image-0048.png?63700688990	150000	2012	10 x 18	t	0048	2014-03-27 14:27:19.565849	2018-08-05 11:49:50.225529	19 x 27	{"cz": {"title": "Houpám se", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}, "en": {"title": "Houpám se", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Качаюсь", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
45317	2	t	paintings.jpg?63700688990	\N	2012	170 х 140	f	4	2014-05-03 15:40:12.72756	2018-08-05 11:49:50.902295	\N	{"cz": {"title": "This is for you and for you and for you and for you...", "subtitle": "", "technique": "dřevovláknitá deska, olejomalba, akryl spray", "description": ""}, "en": {"title": "This is for you and for you and for you and for you...", "subtitle": "", "technique": "fibreboard, oil, acrylic spray", "description": ""}, "ru": {"title": "Это тебе, и тебе, и тебе, и тебе...", "subtitle": "", "technique": "ДВП, масло, аэрозольный акрил", "description": ""}}	\N
45236	2	t	IMG_4595.jpg	\N	2010	122 х 110,5	f	3	2014-05-03 15:34:48.937832	2017-11-19 12:43:42.677238	\N	{"cz": {"title": "Hall of creation", "subtitle": "", "technique": "dřevovláknitá deska, olejomalba, akryl spray", "description": ""}, "en": {"title": "Hall of creation", "subtitle": "", "technique": "fibreboard, oil, acrylic spray", "description": ""}, "ru": {"title": "Зал создания", "subtitle": "", "technique": "ДВП, масло, аэрозольный акрил", "description": ""}}	\N
57435	1	t	Image-0061.png?63700688989	250000	2013	14,5 х 13,5	t	0061	2014-03-28 09:04:27.135182	2018-08-05 11:49:49.339309	23,5 x 22,5	{"cz": {"title": "V hlubokém lese", "subtitle": "Leto", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "In the deep forest", "subtitle": "Summer", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "В глубоком лесу", "subtitle": "Лето", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57386	1	t	Image-0045.png?63700688991	200000	2012	15,5 х 15,5	t	0045	2014-03-27 14:18:26.555241	2018-08-05 11:49:51.152914	24,5 x 24,5	{"cz": {"title": "Bez názvu #16", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Untitled #16", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #16", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57387	1	t	Image-0064.png?63700688991	200000	2013	12,5 х 14,5	t	0064	2014-03-28 09:14:54.903676	2018-08-05 11:49:51.401283	21,5 x 23,5	{"cz": {"title": "Inverze", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Inverse", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Инверсия", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57388	1	t	Image-0069.png?63700688991	200000	2013	14,5 х 13	t	0069	2014-03-28 11:26:35.387419	2018-08-05 11:49:51.676183	23,5 x 22	{"cz": {"title": "Bez názvu #17", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Untitled #17", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #17", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57442	1	t	Image-0016.png?63700688991	200000	2011	9,5 x 18	t	0016	2014-03-15 14:39:45.690834	2018-08-05 11:49:51.888608	18 x 27	{"cz": {"title": "Něco jako západ slunce", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Something like a sunset", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Что-то похожее на закат", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57389	1	t	Image-0039.png?63700688992	200000	2012	12,3 х 14,5	t	0039	2014-03-27 13:54:19.559636	2018-08-05 11:49:52.131741	21 x 23,5	{"cz": {"title": "Ἡράκλειτος", "subtitle": "Dřímající Hérakleitos a jeho vize o nás", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Ἡράκλειτος", "subtitle": "Slumbering Heraclitus and his vision about us", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Ἡράκλειτος", "subtitle": "Дремлющий Гераклит и его видения о нас", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57443	1	t	Image-0004.png?63700688992	200000	2011	12 х 13	t	0004	2014-03-15 12:08:52.022676	2018-08-05 11:49:52.392361	21 x 22	{"cz": {"title": "\\"Hej, chlapi!\\"", "subtitle": "Lano", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "\\"Hey, dudes!\\"", "subtitle": "Ropes", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "\\"Эй, ребята!\\"", "subtitle": "Канаты", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57444	1	t	Image-0029.png?63700688992	200000	2012	12 х 15	t	0029	2014-03-16 07:46:21.261524	2018-08-05 11:49:52.632779	21 x 24	{"cz": {"title": "Logika", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Logic", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Логика", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
46127	1	t	19.png	\N	2014	15 x 19,5 	f	0140	2014-12-27 16:46:27.038566	2017-11-19 12:43:43.939714	24 x 28,5	{"cz": {"title": "Forgotten Good Memories ", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p><a href=\\"http://nonpandoras.com/blog/5-forty-two-views\\">forty-two views of 57°10'14.2\\"n 65°29'54.0\\"e</a></p>"}, "en": {"title": "Forgotten Good Memories ", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p><a href=\\"http://nonpandoras.com/blog/5-forty-two-views\\">forty-two views of 57°10'14.2\\"n 65°29'54.0\\"e</a></p>"}, "ru": {"title": "Забытые хорошие воспоминания", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p><a href=\\"http://nonpandoras.com/blog/5-forty-two-views\\">сорок два вида 57°10'14.2\\"n 65°29'54.0\\"e</a></p>"}}	\N
57445	1	t	Image-0027.png?63700688992	200000	2012	11 x 13	t	0027	2014-03-15 17:05:35.055901	2018-08-05 11:49:52.860802	20 x 22 	{"cz": {"title": "Bez názvu #9", "subtitle": "...", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Untitled #9", "subtitle": "...", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #9", "subtitle": "...", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57446	1	t	Image-0074.png?63700688993	250000	2013	14,5 х 13	t	0074	2014-03-28 12:01:44.466156	2018-08-05 11:49:53.112997	23,5 x 22	{"cz": {"title": "The Crying side of the Earth", "subtitle": "", "technique": "papír, tuš, technické pero, pastelka", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "The Crying side of the Earth", "subtitle": "", "technique": "paper, ink, technical pen, color pencil", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "The Crying side of the Earth", "subtitle": "", "technique": "бумага, тушь, рапидограф, цветной карандаш", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57390	1	t	Image-0012.png?63700688993	400000	2011	16 х 16	t	0012	2014-03-15 13:39:11.356342	2018-08-05 11:49:53.336493	25 x 25	{"cz": {"title": "Bez názvu #2", "subtitle": "...", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Untitled #2", "subtitle": "...", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #2", "subtitle": "...", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57447	1	t	Image-0007.png?63700688993	200000	2011	12 х 14	t	0007	2014-03-15 12:49:24.831411	2018-08-05 11:49:53.579271	21 x 23	{"cz": {"title": "Kachny II", "subtitle": "Disk na obloze", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Ducks II", "subtitle": " Spinning disc in the sky", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Утки II", "subtitle": "Крутящийся диск в небе", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57448	1	t	Image-0056.png?63700688993	250000	2013	14,5 х 13,5	t	0056	2014-03-28 08:47:18.050482	2018-08-05 11:49:53.832289	23,5 x 22,5	{"cz": {"title": "Les myšlení", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Forest of thinking", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Лес размышлений", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57449	1	t	Image-0044.png?63700688994	200000	2012	12 х 15	t	0044	2014-03-27 14:16:39.281772	2018-08-05 11:49:54.074244	21 x 24	{"cz": {"title": "Bez názvu #15", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Untitled #15", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #15", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
46532	1	t	0112.png	200000	2014	15 x 13,5	t	0112	2014-06-04 06:49:23.779763	2017-11-19 12:43:43.50059	24 x 22,5	{"cz": {"title": "Králíci na střeše", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Rabbits on the roof", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Кролики на крыше", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
46613	2	t	IMG_2536.JPG	\N	2014	170 х 140	f	img_2536	2014-07-16 07:47:30.957834	2017-11-19 12:43:43.670862	\N	{"cz": {"title": "...", "subtitle": "", "technique": "dřevovláknitá deska, olejomalba, akryl spray", "description": "<p><a href=\\"http://nonpandoras.com/artworks/188-0100\\">http://nonpandoras.com/artworks/188-0100</a></p>"}, "en": {"title": "...", "subtitle": "", "technique": "fibreboard, oil, acrylic spray", "description": "<p><a href=\\"http://nonpandoras.com/artworks/188-0100\\">http://nonpandoras.com/artworks/188-0100</a></p>"}, "ru": {"title": "...", "subtitle": "", "technique": "ДВП, масло, аэрозольный акрил", "description": "<p><a href=\\"http://nonpandoras.com/artworks/188-0100\\">http://nonpandoras.com/artworks/188-0100</a></p>"}}	\N
57450	1	t	Image-0023.png?63700688994	200000	2012	15 х 17	t	0023	2014-03-15 15:44:14.508976	2018-08-05 11:49:54.292527	24 x 26	{"cz": {"title": "Hvizd", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Whistle", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Свист", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57391	1	t	Image-0046.png?63700688994	200000	2012	15,5 х 15,5	t	0046	2014-03-27 14:20:06.592831	2018-08-05 11:49:54.548413	24,5 x 24,5	{"cz": {"title": "Dům", "subtitle": "I", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Home", "subtitle": "I", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Дом", "subtitle": "I", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57452	1	t	Image-0025.png?63700688995	200000	2012	12 х 15	t	0025	2014-03-15 16:01:19.400399	2018-08-05 11:49:55.005846	21 x 24	{"cz": {"title": "Bez názvu #7", "subtitle": "...", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Untitled #7", "subtitle": "...", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #7", "subtitle": "...", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57453	1	t	Image-0053.png?63700688995	200000	2013	14,5 х 13,5	t	0053	2014-03-28 08:38:16.5136	2018-08-05 11:49:55.24989	23,5 x 22,5	{"cz": {"title": "Přístav", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "The pier", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Пристань", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
46856	2	t	IMG_4590_1.jpg	\N	2011	170 х 140	f	1	2014-05-03 15:26:19.428396	2017-11-19 12:43:42.713785	\N	{"cz": {"title": "Hey, please be quiet", "subtitle": "Quiet solar diurnal variation", "technique": "dřevovláknitá deska, olejomalba, akryl spray", "description": ""}, "en": {"title": "Hey, please be quiet", "subtitle": "Quiet solar diurnal variation", "technique": "fibreboard, oil, acrylic spray", "description": ""}, "ru": {"title": "Пожалуйста, будьте тише", "subtitle": "Солнечно-суточные вариации", "technique": "ДВП, масло, аэрозольный акрил", "description": ""}}	\N
46937	1	t	0148.png	200000	2015	13,5 x 13,5	t	0147	2015-04-01 06:02:02.605092	2017-11-19 12:43:43.989853	22,5 x 22,5	{"cz": {"title": "Spring divers", "subtitle": "", "technique": "papír, tuš, technické pero", "description": ""}, "en": {"title": "Spring divers", "subtitle": "", "technique": "paper, ink, technical pen", "description": ""}, "ru": {"title": "Spring divers", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": ""}}	\N
57456	1	t	Image-0033.png?63700688996	200000	2012	10 х 14	t	0033	2014-03-27 10:32:55.916359	2018-08-05 11:49:56.00963	19 x 23	{"cz": {"title": "Plnovous", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Beard", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Борода", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57457	1	t	Image-0054.png?63700688996	250000	2013	14,5 х 13,5	t	0054	2014-03-28 08:41:35.991356	2018-08-05 11:49:56.272294	23,5 x 22,5	{"cz": {"title": "Přistání", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "The Landing", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Приземление", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57458	1	t	Image-0072.png?63700688996	250000	2013	14,5 х 13	t	0072	2014-03-28 11:33:26.315677	2018-08-05 11:49:56.554319	23,5 x 22	{"cz": {"title": "Oheň znalostí", "subtitle": "Smutek a štěstí", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "The Bonfire of knowledge", "subtitle": "Sadness and happiness", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Костер знания", "subtitle": "Грусть и счастье", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57460	1	t	Image-0006.png?63700688996	200000	2011	12 х 12	t	0006	2014-03-15 12:17:49.072792	2018-08-05 11:49:56.993838	21 x 21	{"cz": {"title": "Kachny", "subtitle": "Disk na obloze", "technique": "papír, tuš, technické pero", "description": "<iframe width=\\"100%\\" height=\\"166\\" scrolling=\\"no\\" frameborder=\\"no\\" src=\\"https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/176203611&color=ff5500&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false\\"></iframe><p>\\r\\n\\tVelikost pasparti na každé straně - 7cm</p><p>\\r\\n\\tKaždý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Ducks", "subtitle": " Spinning disc in the sky", "technique": "paper, ink, technical pen", "description": "<iframe width=\\"100%\\" height=\\"166\\" scrolling=\\"no\\" frameborder=\\"no\\" src=\\"https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/176203611&color=ff5500&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false\\"></iframe><p>\\r\\n\\tSize of mat on each side - 7 cm</p><p>\\r\\n\\tEach decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Утки", "subtitle": "Крутящийся диск в небе", "technique": "бумага, тушь, рапидограф", "description": "<iframe width=\\"100%\\" height=\\"166\\" scrolling=\\"no\\" frameborder=\\"no\\" src=\\"https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/176203611&color=ff5500&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false\\"></iframe><p>\\r\\n\\tРазмер паспарту с каждой стороны - 7 см.</p><p>\\r\\n\\tКаждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57462	1	t	Image-0035.png?63700688997	300000	2012	12,5 х 17,5	t	0035	2014-03-27 13:28:55.020863	2018-08-05 11:49:57.400286	21,5 x 26,5	{"cz": {"title": "Zapomenutý zvuk", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Lost sound", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Потерянный звук", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57464	1	t	Image-0024.png?63700688997	200000	2012	12 х 16	t	0024	2014-03-15 15:58:14.27383	2018-08-05 17:02:40.45071	21 x 25	{"cz": {"title": "\\"Jsem velké Slunce...\\"", "subtitle": "by Charles Causley", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "\\"I am the great sun...\\"", "subtitle": "by Charles Causley", "technique": "paper, ink, technical pen", "description": "<p>S2ize of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "\\"Я великое Солнце...\\"", "subtitle": "by Charles Causley", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
47828	1	t	0125.png	200000	2014	15 x 13,5	t	0125	2014-07-21 08:13:51.7087	2017-11-19 12:43:43.770061	24 x 22,5	{"cz": {"title": "Černozem", "subtitle": "Recurring time", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Chernozem", "subtitle": "Recurring time", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Чернозём", "subtitle": "Повторяющееся время", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
47909	1	t	0145.png	200000	2015	13,5 x 13,5	f	0145	2015-03-05 07:18:49.508914	2017-11-19 12:43:43.977137	22,5 x 22,5	{"cz": {"title": "The Viscous Time #2", "subtitle": "Uhlí", "technique": "papír, tuš, technické pero", "description": "<iframe width=\\"200\\" height=\\"150\\" src=\\"https://www.youtube.com/embed/o3QM12VI1lQ?rel=0\\" frameborder=\\"0\\" allowfullscreen=\\"\\"></iframe>"}, "en": {"title": "The Viscous Time #2", "subtitle": "Coal", "technique": "paper, ink, technical pen", "description": "<iframe width=\\"200\\" height=\\"150\\" src=\\"https://www.youtube.com/embed/o3QM12VI1lQ?rel=0\\" frameborder=\\"0\\" allowfullscreen=\\"\\"></iframe>"}, "ru": {"title": "Вязкое Время #2", "subtitle": "Ископаемый уголь", "technique": "бумага, тушь, рапидограф", "description": "<iframe width=\\"200\\" height=\\"150\\" src=\\"https://www.youtube.com/embed/o3QM12VI1lQ?rel=0\\" frameborder=\\"0\\" allowfullscreen=\\"\\"></iframe>"}}	\N
47990	1	t	0138.png	400000	2014	13 х 16	f	0138	2014-12-09 20:40:39.423467	2017-11-19 12:43:43.907661	22 x 25	{"cz": {"title": "Nocturnal wind", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<iframe width=\\"200\\" height=\\"113\\" src=\\"//www.youtube.com/embed/1WyuZDhx3GE?rel=0\\" frameborder=\\"0\\" allowfullscreen=\\"\\"></iframe>"}, "en": {"title": "Nocturnal wind", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<iframe width=\\"200\\" height=\\"113\\" src=\\"//www.youtube.com/embed/1WyuZDhx3GE?rel=0\\" frameborder=\\"0\\" allowfullscreen=\\"\\"></iframe>"}, "ru": {"title": "Nocturnal wind", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<iframe width=\\"200\\" height=\\"113\\" src=\\"//www.youtube.com/embed/1WyuZDhx3GE?rel=0\\" frameborder=\\"0\\" allowfullscreen=\\"\\"></iframe>"}}	\N
48071	1	t	0099.png	300000	2013	15 x 13,5	t	0099	2014-06-04 05:07:19.478992	2017-11-19 12:43:43.306706	24 x 22,5	{"cz": {"title": "Voyageur", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Voyageur", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Voyageur", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57437	1	t	Image-0013.png?63700688989	500000	2011	13 х 13	t	0013	2014-03-15 13:42:18.179181	2018-08-05 11:49:49.928315	22 x 22	{"cz": {"title": "Bez názvu #3", "subtitle": "...", "technique": "papír, tuš, technické pero", "description": "<p><embed src=\\"//www.youtube.com/v/TY5vx7_704A?version=3&hl=ru_RU&rel=0\\" type=\\"application/x-shockwave-flash\\" width=\\"200\\" height=\\"150\\" allowscriptaccess=\\"always\\" allowfullscreen=\\"true\\" style=\\"background-color: rgb(246, 246, 246); font-size: 15px; line-height: 1.5rem;\\"></p><p>Pečujte o své dítě</p><p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Untitled #3", "subtitle": "...", "technique": "paper, ink, technical pen", "description": "<p><embed src=\\"//www.youtube.com/v/TY5vx7_704A?version=3&hl=ru_RU&rel=0\\" type=\\"application/x-shockwave-flash\\" width=\\"200\\" height=\\"150\\" allowscriptaccess=\\"always\\" allowfullscreen=\\"true\\" style=\\"background-color: rgb(246, 246, 246); font-size: 15px; line-height: 1.5rem;\\"></p><p>Save your child</p><p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #3", "subtitle": "...", "technique": "бумага, тушь, рапидограф", "description": "<p><embed src=\\"//www.youtube.com/v/TY5vx7_704A?version=3&hl=ru_RU&rel=0\\" type=\\"application/x-shockwave-flash\\" width=\\"200\\" height=\\"150\\" allowscriptaccess=\\"always\\" allowfullscreen=\\"true\\" style=\\"background-color: rgb(246, 246, 246); font-size: 15px; line-height: 1.5rem;\\"></p><p>Берегите своего ребёнка</p><p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57465	1	t	Image-0050.png?63700688998	300000	2013	14 х 13,5	t	0050	2014-03-28 08:17:20.701695	2018-08-05 11:49:58.125025	23 x 22,5	{"cz": {"title": "Land of pylons", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p><embed src=\\"//www.youtube.com/v/dQEmaj9C6ko?hl=ru_RU&version=3&rel=0\\" type=\\"application/x-shockwave-flash\\" width=\\"200\\" height=\\"150\\" allowscriptaccess=\\"always\\" allowfullscreen=\\"true\\" style=\\"background-color: rgb(246, 246, 246); font-size: 15px; line-height: 1.5rem;\\"></p><p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Land of pylons", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p><embed src=\\"//www.youtube.com/v/dQEmaj9C6ko?hl=ru_RU&version=3&rel=0\\" type=\\"application/x-shockwave-flash\\" width=\\"200\\" height=\\"150\\" allowscriptaccess=\\"always\\" allowfullscreen=\\"true\\" style=\\"background-color: rgb(246, 246, 246); font-size: 15px; line-height: 1.5rem;\\"></p><p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Земля пилонов", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p><embed src=\\"//www.youtube.com/v/dQEmaj9C6ko?hl=ru_RU&version=3&rel=0\\" type=\\"application/x-shockwave-flash\\" width=\\"200\\" height=\\"150\\" allowscriptaccess=\\"always\\" allowfullscreen=\\"true\\" style=\\"background-color: rgb(246, 246, 246); font-size: 15px; line-height: 1.5rem;\\"></p><p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57466	1	t	Image-0010.png?63700688998	200000	2011	14 x 12	t	0010	2014-03-15 13:27:40.114337	2018-08-05 11:49:58.363032	23 x 21	{"cz": {"title": "Nové dní", "subtitle": "Omnis accipiunt", "technique": "papír, tuš, technické pero", "description": "<p><embed src=\\"//www.youtube.com/v/MWh-2l0Hv0Y?version=3&hl=ru_RU&rel=0\\" type=\\"application/x-shockwave-flash\\" width=\\"200\\" height=\\"150\\" allowscriptaccess=\\"always\\" allowfullscreen=\\"true\\" style=\\"background-color: rgb(246, 246, 246); font-size: 15px; line-height: 1.5rem;\\"></p><p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "New days", "subtitle": "Omnis accipiunt", "technique": "paper, ink, technical pen", "description": "<p><embed src=\\"//www.youtube.com/v/MWh-2l0Hv0Y?version=3&hl=ru_RU&rel=0\\" type=\\"application/x-shockwave-flash\\" width=\\"200\\" height=\\"150\\" allowscriptaccess=\\"always\\" allowfullscreen=\\"true\\" style=\\"background-color: rgb(246, 246, 246); font-size: 15px; line-height: 1.5rem;\\"></p><p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Новые дни", "subtitle": "Omnis accipiunt", "technique": "бумага, тушь, рапидограф", "description": "<p><embed src=\\"//www.youtube.com/v/MWh-2l0Hv0Y?version=3&hl=ru_RU&rel=0\\" type=\\"application/x-shockwave-flash\\" width=\\"200\\" height=\\"150\\" allowscriptaccess=\\"always\\" allowfullscreen=\\"true\\" style=\\"background-color: rgb(246, 246, 246); font-size: 15px; line-height: 1.5rem;\\"></p><p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57451	1	t	Image-0022.png?63700688994	600000	2011	12 х 12	f	0022	2014-03-15 15:39:46.07042	2018-08-05 11:49:54.774082	\N	{"cz": {"title": "Stejně jako stíny Plata", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Like shadows of Plato", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Словно тени Платона", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57461	1	t	Image-0015.png?63700688997	200000	2011	11 x 19	t	0015	2014-03-15 14:34:47.870875	2018-08-05 11:49:57.146045	20 x 28	{"cz": {"title": "Bez názvu #4", "subtitle": "...", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Untitled #4", "subtitle": "...", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #4", "subtitle": "...", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57392	1	t	Image-0073.png?63700688998	200000	2013	14,5 х 13	t	0073	2014-03-28 11:51:36.03811	2018-08-05 11:49:58.614487	23,5 x 22	{"cz": {"title": "Vysílač", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Radio tower", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Радиовышка", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57454	1	t	Image-0042.png?63700688995	200000	2012	12 х 14	t	0042	2014-03-27 14:09:45.953218	2018-08-05 11:49:55.493373	21 x 23	{"cz": {"title": "Smysl života", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "The sense of life", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Смысл жизни", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57393	1	t	Image-0079.png?63700688998	500000	2013	13,5 х 16	t	0079	2014-03-28 12:17:15.686464	2018-08-05 11:49:58.848527	22,5 x 25	{"cz": {"title": "Pastorale ", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Pastorale ", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Пастораль", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
49124	2	t	IMG_2534.JPG	\N	2014	170 х 140	f	2534	2014-07-16 08:02:48.773121	2017-11-19 12:43:43.713573	\N	{"cz": {"title": "V hlubokém lese", "subtitle": "", "technique": "dřevovláknitá deska, olejomalba, akryl spray", "description": "<p><a href=\\"http://nonpandoras.com/artworks/143-0060\\">http://nonpandoras.com/artworks/143-0060</a></p>"}, "en": {"title": "In the deep forest", "subtitle": "", "technique": "fibreboard, oil, acrylic spray", "description": "<p><a href=\\"http://nonpandoras.com/artworks/143-0060\\">http://nonpandoras.com/artworks/143-0060</a></p>"}, "ru": {"title": "В глубоком лесу", "subtitle": "", "technique": "ДВП, масло, аэрозольный акрил", "description": "<p><a href=\\"http://nonpandoras.com/artworks/143-0060\\">http://nonpandoras.com/artworks/143-0060</a></p>"}}	\N
49205	1	t	0101.png	200000	2013	15 x 13,5	t	0101	2014-06-04 05:20:49.99059	2017-11-19 12:43:43.333749	24 x 22,5	{"cz": {"title": "Bez názvu #24", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Untitled #24", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #24", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57455	1	t	Image-0003.png?63700688995	200000	2011	12 х 13	t	0003	2014-03-15 12:04:37.360285	2018-08-05 11:49:55.768527	21 x 22	{"cz": {"title": "\\"Pomozte nám...\\"", "subtitle": "Lano", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "\\"Help us...\\"", "subtitle": "Ropes", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "\\"Помогите нам...\\"", "subtitle": "Канаты", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57394	1	t	Image-0065.png?63700688999	150000	2013	11,5 х 14	f	0065	2014-03-28 11:18:18.075781	2018-08-05 11:49:59.087414	20,5 x 23	{"cz": {"title": "Hlava", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Head", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Голова", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57395	1	t	Image-0063.png?63700688999	300000	2013	14,5 х 13	t	0063	2014-03-28 09:12:45.309842	2018-08-05 11:49:59.33827	23,5 x 22	{"cz": {"title": "Kouř", "subtitle": "Nový nápad", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Smoke", "subtitle": "New idea", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Дым", "subtitle": "Новая идея", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
49367	1	t	0088.png	200000	2013	15 x 13,5	t	0088	2014-06-03 13:06:12.34541	2017-11-19 12:43:43.113283	24 x 22,5	{"cz": {"title": "Bez názvu #19", "subtitle": "...", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Untitled #19", "subtitle": "...", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #19", "subtitle": "...", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
49529	2	t	IMG_4592_1.jpg	\N	2011	170 х 140	f	2	2014-05-03 15:30:37.277489	2017-11-19 12:43:42.709376	\N	{"cz": {"title": "Help yourself", "subtitle": "", "technique": "dřevovláknitá deska, olejomalba, akryl spray", "description": ""}, "en": {"title": "Help yourself", "subtitle": "", "technique": "fibreboard, oil, acrylic spray", "description": ""}, "ru": {"title": "Помоги себе сам", "subtitle": "", "technique": "ДВП, масло, аэрозольный акрил", "description": ""}}	\N
57459	1	t	Image-0002.png?63700688996	200000	2011	15 х 15	t	0002	2014-03-15 11:54:34.729577	2018-08-05 11:49:56.768047	24 x 24	{"cz": {"title": "\\"Chyťte ho!\\"", "subtitle": "Staré a nové nápady", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "\\"Catch him!\\"", "subtitle": "Old and new ideas", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "\\"Поймайте его!\\"", "subtitle": "Старые и новые идеи", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57396	1	t	Image-0075.png?63700688999	200000	2013	12,5 х 15	t	0075	2014-03-28 12:03:28.025741	2018-08-05 11:49:59.610382	21,5 x 24	{"cz": {"title": "Alej", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Alley", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Аллея", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
49772	1	t	0086.png	250000	2013	13,5 х 16	t	0086	2014-06-03 12:45:43.839359	2017-11-19 12:43:43.088375	22,5 x 25	{"cz": {"title": "Paralelní linie na poli", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Parallel lines on a field", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Параллельные линии на поле", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57463	1	t	Image-0077.png?63700688997	250000	2013	10,5 x 15	t	0077	2014-03-28 12:09:32.309688	2018-08-05 11:49:57.629943	19,5 x 24	{"cz": {"title": "Pták a parabolická anténa", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Bird and satellite dish", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Птица и спутниковая антенна", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57397	1	t	Image-0049.png?63700688999	250000	2012	14 х 13	t	0049	2014-03-28 07:50:47.041907	2018-08-05 11:49:59.871743	23 x 22	{"cz": {"title": "Kouř a střechy", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Smoke and roofs", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Дым и крыши", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57398	1	t	Image-0036.png?63700689000	200000	2012	11,3 х 15	t	0036	2014-03-27 13:32:11.801712	2018-08-05 11:50:00.130775	20 x 24	{"cz": {"title": "Bez názvu #13", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Untitled #13", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #13", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
50177	2	t	IMG_2538.JPG	\N	2014	170 х 135,5	f	5	2014-05-03 15:51:33.620356	2017-11-19 12:43:42.722623	\N	{"cz": {"title": "Light and sound of time", "subtitle": "", "technique": "dřevovláknitá deska, olejomalba, akryl spray", "description": "<p>From <a href=\\"http://nonpandoras.com/artworks/140-0057\\">http://nonpandoras.com/artworks/140-0057</a></p>"}, "en": {"title": "Light and sound of time", "subtitle": "", "technique": "fibreboard, oil, acrylic spray", "description": "<p>From&nbsp;<a href=\\"http://nonpandoras.com/artworks/140-0057\\">http://nonpandoras.com/artworks/140-0057</a></p>"}, "ru": {"title": "Свет и звук времени", "subtitle": "", "technique": "ДВП, масло, аэрозольный акрил", "description": "<p>From <a href=\\"http://nonpandoras.com/artworks/140-0057\\">http://nonpandoras.com/artworks/140-0057</a></p>"}}	\N
57399	1	t	Image-0017.png?63700689000	200000	2011	10 x 19	t	0017	2014-03-15 14:56:13.980526	2018-08-05 11:50:00.289463	19 x 28	{"cz": {"title": "Krajina", "subtitle": "Hvězdy a kopce", "technique": "papír, tuš, technické pero", "description": "<object width=\\"200\\" height=\\"150\\"><param name=\\"movie\\" value=\\"//www.youtube.com/v/hck89wOfil8?hl=ru_RU&version=3&rel=0\\"><param name=\\"allowFullScreen\\" value=\\"true\\"><param name=\\"allowscriptaccess\\" value=\\"always\\"><embed src=\\"//www.youtube.com/v/hck89wOfil8?hl=ru_RU&version=3&rel=0\\" type=\\"application/x-shockwave-flash\\" width=\\"200\\" height=\\"150\\" allowscriptaccess=\\"always\\" allowfullscreen=\\"true\\"><p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p></object>"}, "en": {"title": "Landscape", "subtitle": "Stars and hills", "technique": "paper, ink, technical pen", "description": "<object width=\\"200\\" height=\\"150\\"><param name=\\"movie\\" value=\\"//www.youtube.com/v/hck89wOfil8?hl=ru_RU&version=3&rel=0\\"><param name=\\"allowFullScreen\\" value=\\"true\\"><param name=\\"allowscriptaccess\\" value=\\"always\\"><embed src=\\"//www.youtube.com/v/hck89wOfil8?hl=ru_RU&version=3&rel=0\\" type=\\"application/x-shockwave-flash\\" width=\\"200\\" height=\\"150\\" allowscriptaccess=\\"always\\" allowfullscreen=\\"true\\"><p>Size of mat on each side - 7 cm</p></object><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Ландшафт", "subtitle": "Звезды и холмы", "technique": "бумага, тушь, рапидограф", "description": "<object width=\\"200\\" height=\\"150\\"><param name=\\"movie\\" value=\\"//www.youtube.com/v/hck89wOfil8?hl=ru_RU&version=3&rel=0\\"><param name=\\"allowFullScreen\\" value=\\"true\\"><param name=\\"allowscriptaccess\\" value=\\"always\\"><embed src=\\"//www.youtube.com/v/hck89wOfil8?hl=ru_RU&version=3&rel=0\\" type=\\"application/x-shockwave-flash\\" width=\\"200\\" height=\\"150\\" allowscriptaccess=\\"always\\" allowfullscreen=\\"true\\"><p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p></object>"}}	\N
50339	1	t	0119.png	150000	2014	13 х 16	t	0119	2014-06-04 07:32:29.687123	2017-11-19 12:43:43.614721	22 x 25	{"cz": {"title": "Empatie", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Empathy", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Эмпатия", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
50420	1	t	0097.png	200000	2013	15 x 13,5	t	0097	2014-06-04 04:49:29.624539	2017-11-19 12:43:43.26264	24 x 22,5	{"cz": {"title": "Bez názvu #23", "subtitle": "...", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Untitled #23", "subtitle": "...", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #23", "subtitle": "...", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
50582	1	t	0091.png	200000	2013	10 x 18	t	0091	2014-06-03 13:34:51.376672	2017-11-19 12:43:43.14612	19 x 27	{"cz": {"title": "Kupky sena", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Haystacks", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Стога", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
50663	1	t	0085.png	200000	2013	13,5 х 16	t	0085	2014-06-03 12:38:21.356031	2017-11-19 12:43:43.067903	22,5 x 25	{"cz": {"title": "Down-Up-Down", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Down-Up-Down", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Down-Up-Down", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
50744	1	t	0117.png	300000	2014	15 x 13,5	t	0117	2014-06-04 07:26:41.299161	2017-11-19 12:43:43.583733	24 x 22,5	{"cz": {"title": "In a landscape", "subtitle": "Když potřebujeme lásku", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "In a landscape", "subtitle": "When we need love", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "In a landscape", "subtitle": "Когда мы нуждаемся в любви", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57400	1	t	Image-0008.png?63700689000	200000	2011	13 х 14	t	0008	2014-03-15 12:59:01.247996	2018-08-05 11:50:00.529871	22 x 23	{"cz": {"title": "Tančící stíny", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Dancing shadows", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Танцующие тени", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
50825	1	t	0109.png	250000	2014	13 х 16	t	0109	2014-06-04 06:25:26.977108	2017-11-19 12:43:43.773255	22 x 25	{"cz": {"title": "Sklon rotační osy", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Axial tilt", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Наклон оси вращения", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
50906	1	t	0147.png	\N	2015	13,5 x 13,5	f	0147	2015-03-29 17:23:06.748413	2017-11-19 12:43:44.010904	22,5 x 22,5	{"cz": {"title": "Pozor na temnoty", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<iframe width=\\"200\\" height=\\"113\\" src=\\"https://www.youtube.com/embed/T3D68KWfZOo?rel=0\\" frameborder=\\"0\\" allowfullscreen=\\"\\"></iframe>"}, "en": {"title": "Beware of darkness", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<iframe width=\\"200\\" height=\\"113\\" src=\\"https://www.youtube.com/embed/T3D68KWfZOo?rel=0\\" frameborder=\\"0\\" allowfullscreen=\\"\\"></iframe>"}, "ru": {"title": "Опасайся темноты", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<iframe width=\\"200\\" height=\\"113\\" src=\\"https://www.youtube.com/embed/T3D68KWfZOo?rel=0\\" frameborder=\\"0\\" allowfullscreen=\\"\\"></iframe>"}}	\N
51068	1	t	0110.png	200000	2014	15 x 13,5	t	0110	2014-06-04 06:33:40.289796	2017-11-19 12:43:43.478789	24 x 22,5	{"cz": {"title": "Jasné obloze", "subtitle": "Minulost a budoucnost", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Clear sky", "subtitle": "Past and Future", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Чистое небо", "subtitle": "Прошлое и будущее", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57401	1	t	Image-0011.png?63700689000	500000	2011	13 х 17	t	0011	2014-03-15 13:35:18.626761	2018-08-05 11:50:00.824976	22 x 26	{"cz": {"title": "Separátor", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Separator", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Разделитель", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57402	1	t	Image-0005.png?63700689001	200000	2011	14 x 14	t	0005	2014-03-15 12:12:34.244458	2018-08-05 11:50:01.131821	23 x 23	{"cz": {"title": "Bez názvu #1", "subtitle": "...", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Untitled #1", "subtitle": "...", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #1 ", "subtitle": "...", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
51149	1	t	0082.png	150000	2013	13 х 16	t	0082	2014-06-03 11:50:22.075943	2017-11-19 12:43:41.686603	22 x 25	{"cz": {"title": "Jellyfishes", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Jellyfishes on Land", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Медузы", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57403	1	t	Image-0021.png?63700689001	200000	2011	13 х 14,5	t	0021	2014-03-15 15:18:47.236859	2018-08-05 11:50:01.792938	22 x 23,5	{"cz": {"title": "Grain elevator", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Grain elevator", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Зерновой элеватор", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57404	1	t	Image-0019.png?63700689002	200000	2011	11 x 19	t	0019	2014-03-15 15:08:25.766269	2018-08-05 11:50:02.052974	20 x 28	{"cz": {"title": "Bez názvu #5", "subtitle": "...", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Untitled #5", "subtitle": "...", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #5", "subtitle": "...", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
51554	1	t	0083.png	200000	2013	14,5 х 13,5	t	0083	2014-06-03 12:11:00.693221	2017-11-19 12:43:43.059534	23,5 x 22,5	{"cz": {"title": "Ptáci nad věží", "subtitle": "Stejně jako neurony v hlavě", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Birds over the tower", "subtitle": "Like neurons in the head", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Птицы над вышкой", "subtitle": "Словно нейроны в голове", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57405	1	t	Image-0009.png?63700689002	200000	2011	15 х 12	t	0009	2014-03-15 13:07:35.308188	2018-08-05 11:50:02.420299	24 x 21	{"cz": {"title": "Strom nápadů", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Tree of Ideas", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Дерево идей", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57406	1	t	Image-0030.png?63700689003	200000	2012	14 Х 14	t	0030	2014-03-16 07:50:17.053345	2018-08-05 11:50:03.177092	23 x 23	{"cz": {"title": "Bez názvu #10", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Untitled #10", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #10", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57407	1	t	Image-0070.png?63700689003	200000	2013	14,5 х 13	t	0070	2014-03-28 11:28:48.457576	2018-08-05 11:50:03.691367	23,5 x 22	{"cz": {"title": "Obdiv", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Admiration", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Восхищение", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57408	1	t	Image-0051.png?63700689004	250000	2013	14,5 х 13,5	t	0051	2014-03-28 08:30:21.702738	2018-08-05 11:50:04.164071	23,5 x 22,5	{"cz": {"title": "Sníh a slunce", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Snow and sun", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Снег и солнце", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57409	1	t	Image-0014.png?63700689004	200000	2011	13 х 12,5	t	0014	2014-03-15 14:33:05.435213	2018-08-05 11:50:04.578427	22 x 21	{"cz": {"title": "Pod měsícem", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Under the moon", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Под луной", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57410	1	t	Image-0040.png?63700689004	200000	2012	14,3 х 13	t	0040	2014-03-27 14:04:59.559855	2018-08-05 11:50:04.840728	23,3 x 22	{"cz": {"title": "Bez názvu #14", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Untitled #14", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #14", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
45722	1	t	0090.png	200000	2013	10 x 18	t	0090	2014-06-03 13:29:04.228303	2017-11-19 12:43:43.138995	19 x 27	{"cz": {"title": "Posloupnost", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Sequence", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Последовательность", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
52040	1	t	0146.png	200000	2015	13,5 x 13,5	t	0146	2015-03-16 20:16:10.648297	2017-11-19 12:43:44.003919	22,5 x 22,5	{"cz": {"title": "Jen idioti běží od slunce", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<iframe width=\\"200\\" height=\\"113\\" src=\\"https://www.youtube.com/embed/mNz422lImt4?rel=0\\" frameborder=\\"0\\" allowfullscreen=\\"\\"></iframe>"}, "en": {"title": "Only idiots running against the Sun", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<iframe width=\\"200\\" height=\\"113\\" src=\\"https://www.youtube.com/embed/mNz422lImt4?rel=0\\" frameborder=\\"0\\" allowfullscreen=\\"\\"></iframe>"}, "ru": {"title": "Только идиоты бегут от солнца", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<iframe width=\\"200\\" height=\\"113\\" src=\\"https://www.youtube.com/embed/mNz422lImt4?rel=0\\" frameborder=\\"0\\" allowfullscreen=\\"\\"></iframe>"}}	\N
57411	1	t	Image-0032.png?63700689005	150000	2012	11,5 х 13	t	0032	2014-03-27 10:31:00.805392	2018-08-05 11:50:05.124173	20 x 22	{"cz": {"title": "Klaním se ti", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Adore you", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Мы обожаем тебя", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57412	1	t	Image-0028.png?63700689005	200000	2012	12 х 13	t	0028	2014-03-16 04:12:20.047749	2018-08-05 11:50:05.403349	21 x 22	{"cz": {"title": "Doba", "subtitle": "Rozšíření prostoru", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Time", "subtitle": "Expansion of space", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Время", "subtitle": "Расширение пространства", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57413	1	t	Image-0067.png?63700689005	200000	2013	11,5 х 14	t	0067	2014-03-28 11:23:22.869367	2018-08-05 11:50:05.667106	20,5 x 23	{"cz": {"title": "Ptáci a sníh", "subtitle": "The Wind Coming", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Birds and Snow", "subtitle": "The Wind Coming", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Птицы и снег", "subtitle": "Ветер приходит", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57414	1	t	Image-0076.png?63700689005	100000	2013	10,5 x 15	t	0076	2014-03-28 12:06:16.298147	2018-08-05 11:50:05.917825	19,5 x 24	{"cz": {"title": "Vlny", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Waves", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Волны", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57415	1	t	Image-0059.png?63700689006	200000	2013	14,5 х 13,5	t	0059	2014-03-28 08:56:31.449641	2018-08-05 11:50:06.212571	23,5 x 22,5	{"cz": {"title": "New power", "subtitle": "", "technique": "papír, tuš, technické pero, pastelka", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "New power", "subtitle": "", "technique": "paper, ink, technical pen, color pencil", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Новая мощность", "subtitle": "", "technique": "бумага, тушь, рапидограф, цветной карандаш", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57416	1	t	Image-0057.png?63700689006	200000	2013	14,5 х 13,5	t	0057	2014-03-28 08:49:22.78706	2018-08-05 11:50:06.561912	23,5 x 22,5	{"cz": {"title": "Light and sound of time", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Light and sound of time", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Свет и звук времени", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57417	1	t	Image-0060.png?63700689006	200000	2013	14,5 х 13,5	t	0060	2014-03-28 09:02:43.033695	2018-08-05 11:50:06.998901	23,5 x 22,5	{"cz": {"title": "V hlubokém lese", "subtitle": "Zima", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "In the deep forest", "subtitle": "Winter", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "В глубоком лесу", "subtitle": "Зима", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57418	1	t	Image-0055.png?63700689007	150000	2013	14,5 х 13,5	t	0055	2014-03-28 08:44:00.614374	2018-08-05 11:50:07.271449	23,5 x 22,5	{"cz": {"title": "Topoly", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Poplars", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Тополя", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57419	1	t	Image-0066.png?63700689007	200000	2013	11,5 х 14	t	0066	2014-03-28 11:20:58.337009	2018-08-05 11:50:07.528734	20,5 x 23	{"cz": {"title": "Jednoho dne budu vidět kopce a sopky", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Someday I'll see the hills and volcanoes", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Когда-нибудь я увижу холмы и вулканы", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57420	1	t	Image-0062.png?63700689007	700000	2013	14,5 х 13,5	f	0062	2014-03-28 09:08:25.594094	2018-08-05 11:50:07.791117	23,5 x 22,5	{"cz": {"title": "Pohyb", "subtitle": "Stejně jako Dopplerův jev", "technique": "papír, tuš, technické pero, pastelka", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "The Motion ", "subtitle": "Like Doppler effect", "technique": "paper, ink, technical pen, color pencil", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Движение", "subtitle": "Словно Эффект Доплера", "technique": "бумага, тушь, рапидограф, цветной карандаш", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
53417	1	t	0137.png	200000	2014	15 x 13,5	f	0137	2014-12-06 19:10:46.696881	2017-11-19 12:43:43.900015	24 x 22,5	{"cz": {"title": "The Burning Hills", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<iframe width=\\"200\\" height=\\"113\\" src=\\"//www.youtube.com/embed/_WMP4jgXM3c?rel=0\\" frameborder=\\"0\\" allowfullscreen=\\"\\"></iframe>"}, "en": {"title": "The Burning Hills", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<iframe width=\\"200\\" height=\\"113\\" src=\\"//www.youtube.com/embed/_WMP4jgXM3c?rel=0\\" frameborder=\\"0\\" allowfullscreen=\\"\\"></iframe>"}, "ru": {"title": "Горящие холмы", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<iframe width=\\"200\\" height=\\"113\\" src=\\"//www.youtube.com/embed/_WMP4jgXM3c?rel=0\\" frameborder=\\"0\\" allowfullscreen=\\"\\"></iframe>"}}	\N
57421	1	t	Image-0043.png?63700689008	200000	2012	11 x 13	t	0043	2014-03-27 14:15:08.342234	2018-08-05 11:50:08.029423	20 x 22	{"cz": {"title": "Moment", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Moment", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Мгновение", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57422	1	t	Image-0047.png?63700689008	200000	2012	15,5 х 15,5	t	0047	2014-03-27 14:21:19.655625	2018-08-05 11:50:08.272016	24,5 x 24,5	{"cz": {"title": "Dům", "subtitle": "II", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Home", "subtitle": "II", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Дом", "subtitle": "II", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
53579	1	t	0103.png	350000	2013	15 x 13,5	t	0103	2014-06-04 05:36:48.705306	2017-11-19 12:43:43.383551	24 x 22,5	{"cz": {"title": "Bez názvu #25", "subtitle": "...", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Untitled #25", "subtitle": "...", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #25", "subtitle": "...", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57423	1	t	Image-0058.png?63700689008	250000	2013	14,5 х 13,5	t	0058	2014-03-28 08:52:40.420154	2018-08-05 11:50:08.53643	23,5 x 22,5	{"cz": {"title": "Noèsis", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Noèsis", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Ноэзис", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
53903	1	t	0093.png	200000	2013	10 x 18	t	0093	2014-06-03 17:02:28.07584	2017-11-19 12:43:43.22	19 x 27	{"cz": {"title": "Bez názvu #21", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Untitled #21", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #21", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
54308	1	t	0089.png	150000	2013	13 х 16	t	0089	2014-06-03 13:13:34.139469	2017-11-19 12:43:43.130379	22 x 25	{"cz": {"title": "Bez názvu #20", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Untitled #20", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #20", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
54713	1	t	0087.png	200000	2013	10 x 13	t	0087	2014-06-03 12:57:25.31963	2017-11-19 12:43:43.162768	19 x 22	{"cz": {"title": "The Moths", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "The Moths", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "The Moths", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
54794	1	t	0095.png	200000	2013	13 х 16	t	0095	2014-06-04 04:38:57.693196	2017-11-19 12:43:43.236014	22 x 25	{"cz": {"title": "Bez názvu #22", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Untitled #22", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #22", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
54875	1	t	0113.png	200000	2014	13 х 16	t	0113	2014-06-04 06:53:03.156671	2017-11-19 12:43:43.508913	22 x 25	{"cz": {"title": "Rádiové věže", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Radio towers", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Радиовышки", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57424	1	t	Image-0026.png?63700689008	200000	2012	14 х 13	t	0026	2014-03-15 16:15:53.731525	2018-08-05 11:50:08.793792	23 x 22	{"cz": {"title": "Bez názvu #8", "subtitle": "...", "technique": "papír, tuš, technické pero", "description": "<object width=\\"200\\" height=\\"150\\"><param name=\\"movie\\" value=\\"//www.youtube.com/v/ZI_iy09RFZg?version=3&hl=ru_RU&rel=0\\"><param name=\\"allowFullScreen\\" value=\\"true\\"><param name=\\"allowscriptaccess\\" value=\\"always\\"><embed src=\\"//www.youtube.com/v/ZI_iy09RFZg?version=3&hl=ru_RU&rel=0\\" type=\\"application/x-shockwave-flash\\" width=\\"200\\" height=\\"150\\" allowscriptaccess=\\"always\\" allowfullscreen=\\"true\\"><p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p></object>"}, "en": {"title": "Untitled #8", "subtitle": "...", "technique": "paper, ink, technical pen", "description": "<object width=\\"200\\" height=\\"150\\"><param name=\\"movie\\" value=\\"//www.youtube.com/v/ZI_iy09RFZg?version=3&hl=ru_RU&rel=0\\"><param name=\\"allowFullScreen\\" value=\\"true\\"><param name=\\"allowscriptaccess\\" value=\\"always\\"><embed src=\\"//www.youtube.com/v/ZI_iy09RFZg?version=3&hl=ru_RU&rel=0\\" type=\\"application/x-shockwave-flash\\" width=\\"200\\" height=\\"150\\" allowscriptaccess=\\"always\\" allowfullscreen=\\"true\\"><p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p></object>"}, "ru": {"title": "Без названия #8", "subtitle": "...", "technique": "бумага, тушь, рапидограф", "description": "<object width=\\"200\\" height=\\"150\\"><param name=\\"movie\\" value=\\"//www.youtube.com/v/ZI_iy09RFZg?version=3&hl=ru_RU&rel=0\\"><param name=\\"allowFullScreen\\" value=\\"true\\"><param name=\\"allowscriptaccess\\" value=\\"always\\"><embed src=\\"//www.youtube.com/v/ZI_iy09RFZg?version=3&hl=ru_RU&rel=0\\" type=\\"application/x-shockwave-flash\\" width=\\"200\\" height=\\"150\\" allowscriptaccess=\\"always\\" allowfullscreen=\\"true\\"><p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p></object>"}}	\N
54956	1	t	0100.png	200000	2013	15 x 13,5	t	0100	2014-06-04 05:10:19.354273	2017-11-19 12:43:43.314417	24 x 22,5	{"cz": {"title": "...", "subtitle": "", "technique": "papír, tuš, technické pero, pastelka", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "...", "subtitle": "", "technique": "paper, ink, technical pen, color pencil", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "...", "subtitle": "", "technique": "бумага, тушь, рапидограф, цветной карандаш", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57425	1	t	Image-0034.png?63700689009	200000	2012	12,3 х 14	t	0034	2014-03-27 10:34:24.610719	2018-08-05 11:50:09.122955	21 x 23	{"cz": {"title": "Bez názvu #12", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Untitled #12", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #12", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57426	1	t	Image-0071.png?63700689009	150000	2013	14,5 х 13	t	0071	2014-03-28 11:29:56.623839	2018-08-05 11:50:09.684976	23,5 x 22	{"cz": {"title": "Bez názvu #18", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Untitled #18", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #18", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57427	1	t	Image-0001.png?63700689009	300000	2011	15 х 19	t	untitled-1	2014-03-14 07:44:21.321178	2018-08-05 11:50:09.983974	24 x 28	{"cz": {"title": "Šťastný den", "subtitle": "Samotář", "technique": "papír, tuš, technické pero", "description": "<object width=\\"200\\" height=\\"150\\"><param name=\\"movie\\" value=\\"//www.youtube.com/v/jPnP3Sqi3kQ?hl=ru_RU&version=3&rel=0\\"><param name=\\"allowFullScreen\\" value=\\"true\\"><param name=\\"allowscriptaccess\\" value=\\"always\\"><embed src=\\"//www.youtube.com/v/jPnP3Sqi3kQ?hl=ru_RU&version=3&rel=0\\" type=\\"application/x-shockwave-flash\\" width=\\"200\\" height=\\"150\\" allowscriptaccess=\\"always\\" allowfullscreen=\\"true\\"><p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p></object>"}, "en": {"title": "Happy day", "subtitle": "Loner", "technique": "paper, ink, technical pen", "description": "<object width=\\"200\\" height=\\"150\\"><param name=\\"movie\\" value=\\"//www.youtube.com/v/jPnP3Sqi3kQ?hl=ru_RU&version=3&rel=0\\"><param name=\\"allowFullScreen\\" value=\\"true\\"><param name=\\"allowscriptaccess\\" value=\\"always\\"><embed src=\\"//www.youtube.com/v/jPnP3Sqi3kQ?hl=ru_RU&version=3&rel=0\\" type=\\"application/x-shockwave-flash\\" width=\\"200\\" height=\\"150\\" allowscriptaccess=\\"always\\" allowfullscreen=\\"true\\"><p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p></object>"}, "ru": {"title": "Счастливый день", "subtitle": "Одиночка", "technique": "бумага, тушь, рапидограф", "description": "<object width=\\"200\\" height=\\"150\\"><param name=\\"movie\\" value=\\"//www.youtube.com/v/jPnP3Sqi3kQ?hl=ru_RU&version=3&rel=0\\"><param name=\\"allowFullScreen\\" value=\\"true\\"><param name=\\"allowscriptaccess\\" value=\\"always\\"><embed src=\\"//www.youtube.com/v/jPnP3Sqi3kQ?hl=ru_RU&version=3&rel=0\\" type=\\"application/x-shockwave-flash\\" width=\\"200\\" height=\\"150\\" allowscriptaccess=\\"always\\" allowfullscreen=\\"true\\"><p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p></object>"}}	\N
57428	1	t	Image-0018.png?63700689010	200000	2011	10 x 19,5	t	0018	2014-03-15 15:04:06.300173	2018-08-05 11:50:10.132939	19 x 28,5	{"cz": {"title": "Rádiové věže", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Radio towers", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Радиовышки", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
55604	1	t	0096.png	200000	2013	15 x 13,5	t	0096	2014-06-04 04:43:38.215257	2017-11-19 12:43:43.248482	24 x 22,5	{"cz": {"title": "Částečně oblačno", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Partly Cloudy", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Переменная облачность", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
55685	1	t	0098.png	300000	2013	15 x 13,5	t	0098	2014-06-04 05:00:16.968612	2017-11-19 12:43:43.295541	24 x 22,5	{"cz": {"title": "In the hills", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "In the hills", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "In the hills", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
55847	2	t	IMG_2537.JPG	5000000	2014	170 х 140	t	2537	2014-07-16 07:52:00.477638	2017-11-19 12:43:43.67299		{"cz": {"title": "Les myšlení", "subtitle": "", "technique": "dřevovláknitá deska, olejomalba, akryl spray", "description": "<p><a href=\\"http://nonpandoras.com/artworks/139-0056\\">http://nonpandoras.com/artworks/139-0056</a></p>"}, "en": {"title": "Forest of thinking", "subtitle": "", "technique": "fibreboard, oil, acrylic spray", "description": "<p><a href=\\"http://nonpandoras.com/artworks/139-0056\\">http://nonpandoras.com/artworks/139-0056</a></p>"}, "ru": {"title": "Лес размышлений", "subtitle": "", "technique": "ДВП, масло, аэрозольный акрил", "description": "<p><a href=\\"http://nonpandoras.com/artworks/139-0056\\">http://nonpandoras.com/artworks/139-0056</a></p>"}}	\N
55928	1	t	0122.png	250000	2014	15 x 13,5	t	0122	2014-06-04 08:30:22.199042	2017-11-19 12:43:43.660034		{"cz": {"title": "Tisíc a jeden krát", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "A thousand and one times", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Тысяча и один раз", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
56009	1	t	0108.png	300000	2014	15 x 13,5	t	0108	2014-06-04 06:18:22.017993	2017-11-19 12:43:43.462701	24 x 22,5	{"cz": {"title": "Smíšený les", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Mixed forests", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Смешанный лес", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
56090	1	t	0128.png	200000	2014	14 x 15	t	0128	2014-07-24 18:40:41.439457	2017-11-19 12:43:43.801994	23 x 24	{"cz": {"title": "Cascade of shadows", "subtitle": "Composition II", "technique": "", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Cascade of shadows", "subtitle": "Composition II", "technique": "", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Cascade of shadows", "subtitle": "Composition II", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
56171	1	t	0121.png	200000	2014	15 x 13,5	t	0121	2014-06-04 08:29:08.003743	2017-11-19 12:43:43.645149	24 x 22,5	{"cz": {"title": "Sound of the Wind passing through branches and leaves of trees", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Sound of the Wind passing through branches and leaves of trees", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Звук ветра, проходящий сквозь ветви и листья деревьев", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
56252	1	t	0084.png	250000	2013	13,5 х 16	t	0084	2014-06-03 12:30:28.49557	2017-11-19 12:43:43.683647	22,5 x 25	{"cz": {"title": "Někde v poli", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Somewhere on the field", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Где-то в поле", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
56333	1	t	0124.png	200000	2014	15 x 17	t	0124	2014-07-20 18:19:07.65259	2017-11-19 12:43:43.726395	24 x 26	{"cz": {"title": "Bez názvu #29", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Untitled #29", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #29", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
56414	1	t	0131.png	200000	2014	14,5 х 13,5	t	0131	2014-11-06 09:17:35.888332	2017-11-19 12:43:43.857433	23,5 x 22,5	{"cz": {"title": "The Small. The Big. ", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "The Small. The Big. ", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Маленькое. Большое.", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
56495	1	t	0118.png	200000	2014	15 x 13,5	t	0118	2014-06-04 07:28:28.392992	2017-11-19 12:43:43.593438	24 x 22,5	{"cz": {"title": "Zaslepeni sluncem", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Blinded by the Sun", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Ослепленный солнцем", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57429	1	t	Image-0068.png?63700689010	700000	2013	14,5 х 13	f	0068	2014-03-28 11:25:16.482242	2018-08-05 11:50:10.430521	23,5 x 22	{"cz": {"title": "Kdo je další?", "subtitle": "", "technique": "papír, tuš, technické pero, pastelka", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Who's next?", "subtitle": "", "technique": "paper, ink, technical pen, color pencil", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Кто следующий? ", "subtitle": "", "technique": "бумага, тушь, рапидограф, цветной карандаш", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57430	1	t	Image-0078.png?63700689010	200000	2013	14 x 13	t	0078	2014-03-28 12:13:10.199759	2018-08-05 11:50:10.69158	23 x 22	{"cz": {"title": "The edge of the edge", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "The edge of the edge", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Край края", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
56576	1	t	0143.png	200000	2015	14,5 х 13,5	t	0143	2015-02-05 21:52:34.973865	2017-11-19 12:43:43.890193	23,5 x 22,5	{"cz": {"title": "Brzy ráno února", "subtitle": "Ospalost", "technique": "papír, tuš, technické pero", "description": "<iframe width=\\"200\\" height=\\"113\\" src=\\"https://www.youtube.com/embed/r9SnbhDEmgg?rel=0\\" frameborder=\\"0\\" allowfullscreen=\\"\\"></iframe>"}, "en": {"title": "Early February morning", "subtitle": "Drowsiness", "technique": "paper, ink, technical pen", "description": "<iframe width=\\"200\\" height=\\"113\\" src=\\"https://www.youtube.com/embed/r9SnbhDEmgg?rel=0\\" frameborder=\\"0\\" allowfullscreen=\\"\\"></iframe>"}, "ru": {"title": "Раннее февральское утро", "subtitle": "Дремота", "technique": "бумага, тушь, рапидограф", "description": "<iframe width=\\"200\\" height=\\"113\\" src=\\"https://www.youtube.com/embed/r9SnbhDEmgg?rel=0\\" frameborder=\\"0\\" allowfullscreen=\\"\\"></iframe>"}}	\N
56819	1	t	0127.png	200000	2014	15 x 11	t	0127	2014-07-21 12:05:56.041356	2017-11-19 12:43:43.759374	24 x 20	{"cz": {"title": "Cascade of shadow", "subtitle": "Composition I", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Cascade of shadow", "subtitle": "Composition I", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Cascade of shadow", "subtitle": "Composition I", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57431	1	t	Image-0081.png?63700689010	250000	2013	13,5 х 16	t	0081	2014-03-28 12:21:53.25468	2018-08-05 11:50:10.92733	22,5 x 25	{"cz": {"title": "Pylonový zvuk", "subtitle": "", "technique": "", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "The sound of pylons", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Звук пилонов", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57432	1	t	Image-0041.png?63700689011	200000	2012	13,3 х 10	t	0041	2014-03-27 14:07:02.435081	2018-08-05 11:50:11.224616	22,3 x 19	{"cz": {"title": "Čas na práci a čas k odpočinku", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Time to work and time to rest", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Время работать и время отдыхать", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57433	1	t	Image-0038.png?63700689011	200000	2012	12,3 х 14	t	0038	2014-03-27 13:45:15.47353	2018-08-05 11:50:11.475471	21 x 23	{"cz": {"title": "Umění myšlení", "subtitle": "Idea a realizace", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "The art of thought", "subtitle": "Idea and embodiment", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Искусство мысли", "subtitle": "Идея и воплощение", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57434	1	t	Image-0080.png?63700689011	300000	2013	13,5 х 16	t	0080	2014-03-28 12:19:42.847065	2018-08-05 11:50:11.7157	22,5 x 25	{"cz": {"title": "Hořící strom", "subtitle": "Přehrada", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "The burning tree", "subtitle": "Dam", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Горящее дерево", "subtitle": "Дамба", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
54227	1	t	0094.png	200000	2013	13,5 х 15	t	0094	2014-06-03 17:29:04.639693	2017-11-19 12:43:43.228126	22,5 x 24	{"cz": {"title": "Aníta KE-399", "subtitle": "In work", "technique": "papír, tuš, technické pero", "description": "<p><img src=\\"http://nonpandoras.com/uploads/redactor_assets/pictures/12/DeliverFile.jpg\\" alt=\\"\\" style=\\"width: 366px;\\"></p><p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Aníta KE-399", "subtitle": "In work", "technique": "paper, ink, technical pen", "description": "<p><img src=\\"/uploads/redactor_assets/pictures/12/DeliverFile.jpg\\" alt=\\"\\" style=\\"width: 366px;\\"></p><p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Aníta KE-399", "subtitle": "In work", "technique": "бумага, тушь, рапидограф", "description": "<p><img src=\\"http://nonpandoras.com/uploads/redactor_assets/pictures/12/DeliverFile.jpg\\" alt=\\"\\" style=\\"width: 366px;\\"></p><p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57438	1	t	Image-0037.png?63700689011	150000	2012	10,3 x 10	t	0037	2014-03-27 13:34:10.012457	2018-08-05 11:50:11.967015	19 x 19	{"cz": {"title": "Vítr", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Wind", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Ветер", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
45398	1	t	0142.png	\N	2015	14,5 х 13,5	f	0142	2015-02-01 17:35:12.483651	2017-11-19 12:43:43.963738		{"cz": {"title": "Bez názvu #33", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<iframe width=\\"200\\" height=\\"150\\" src=\\"https://www.youtube.com/embed/G0m-137dGHc?rel=0\\" frameborder=\\"0\\" allowfullscreen=\\"\\"></iframe>"}, "en": {"title": "Untitled #33", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<iframe width=\\"200\\" height=\\"150\\" src=\\"https://www.youtube.com/embed/G0m-137dGHc?rel=0\\" frameborder=\\"0\\" allowfullscreen=\\"\\"></iframe>"}, "ru": {"title": "Без названия #33 ", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<iframe width=\\"200\\" height=\\"150\\" src=\\"https://www.youtube.com/embed/G0m-137dGHc?rel=0\\" frameborder=\\"0\\" allowfullscreen=\\"\\"></iframe>"}}	\N
57439	1	t	Image-0052.png?63700689012	\N	2013	14,3 х 13,3	f	0052	2014-03-28 08:32:55.161885	2018-08-05 11:50:12.273254	\N	{"cz": {"title": "Moje dílna", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "In my workshop", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "В моей мастерской", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
45641	1	t	0123.png	200000	2014	15 x 17	t	0123	2014-07-20 17:26:33.563436	2017-11-19 12:43:43.734376	24 x 26	{"cz": {"title": "Outer", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Outer", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Outer", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57224	1	t	05.png	200000	2014	15 x 19,5 	t	220	2014-10-28 18:26:42.085027	2017-11-19 12:43:43.843017	24 x 28,5	{"cz": {"title": "Bez názvu #30", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p><p><a href=\\"http://nonpandoras.com/blog/5-forty-two-views\\">forty-two views of 57°10'14.2\\"n 65°29'54.0\\"e</a></p>"}, "en": {"title": "Untitled #30", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p><p><a href=\\"http://nonpandoras.com/blog/5-forty-two-views\\" target=\\"_blank\\">forty-two views of 57°10'14.2\\"n 65°29'54.0\\"e</a></p>"}, "ru": {"title": "Без названия #30", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p><p><a href=\\"http://nonpandoras.com/blog/5-forty-two-views\\">сорок два вида 57°10'14.2\\"n 65°29'54.0\\"e</a></p>"}}	\N
48314	1	t	0120.png	150000	2014	13 х 16	t	0120	2014-06-04 07:38:11.930199	2017-11-19 12:43:43.635339	22 x 25	{"cz": {"title": "Horké slunce a studený vzduch", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "The Hot Sunshine and Cold Air", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Горячий солнечный свет и холодный воздух", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
48476	1	t	0116.png	350000	2014	13 х 16	t	0116	2014-06-04 07:06:17.573001	2017-11-19 12:43:43.562192	22 x 25	{"cz": {"title": "Melancholic smell of distant rain", "subtitle": "2 May's evening", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Melancholic smell of distant rain", "subtitle": "2 May's evening", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Melancholic smell of distant rain", "subtitle": "2 May's evening", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
48557	1	t	0126.png	250000	2014	15 x 8	t	0126	2014-07-21 10:56:31.908867	2017-11-19 12:43:43.744875	24 x 17	{"cz": {"title": "Absorbers of photons", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Absorbers of photons", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Поглотители фотонов", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
48881	1	t	06.png	400000	2014	15 x 19,5 	t	0139	2014-12-22 10:55:05.312018	2017-11-19 12:43:43.931138	24 x 28,5	{"cz": {"title": "Dobré zprávy", "subtitle": "", "technique": "papír, tuš, technické pero, pastelka", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p><p><a href=\\"http://nonpandoras.com/blog/5-forty-two-views\\">forty-two views of 57°10'14.2\\"n 65°29'54.0\\"e</a></p>"}, "en": {"title": "Good news", "subtitle": "", "technique": "paper, ink, technical pen, color pencil", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p><p><a href=\\"http://nonpandoras.com/blog/5-forty-two-views\\">forty-two views of 57°10'14.2\\"n 65°29'54.0\\"e</a></p>"}, "ru": {"title": "Хорошие новости", "subtitle": "", "technique": "бумага, тушь, рапидограф, цветной карандаш", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p><p><a href=\\"http://nonpandoras.com/blog/5-forty-two-views\\">сорок два вида 57°10'14.2\\"n 65°29'54.0\\"e</a></p>"}}	\N
49043	1	t	32.png	250000	2014	19,5 x 15	t	221	2014-10-28 19:07:32.397986	2017-11-19 12:43:43.839979	28,5 x 24	{"cz": {"title": "Náš přítel je měsíční svit", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p><p><a href=\\"http://nonpandoras.com/blog/5-forty-two-views\\">forty-two views of 57°10'14.2\\"n 65°29'54.0\\"e</a></p>"}, "en": {"title": "Our friend is a moonlight", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p><p><a href=\\"http://nonpandoras.com/blog/5-forty-two-views\\">forty-two views of 57°10'14.2\\"n 65°29'54.0\\"e</a></p>"}, "ru": {"title": "Наш друг - лунный свет", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p><p><a href=\\"http://nonpandoras.com/blog/5-forty-two-views\\">сорок два вида 57°10'14.2\\"n 65°29'54.0\\"e</a></p>"}}	\N
52688	1	t	0104.png	350000	2013	15 x 13,5	t	0104	2014-06-04 05:39:28.700615	2017-11-19 12:43:43.396149	24 x 22,5	{"cz": {"title": "Když jdeme do práce", "subtitle": "Píseň myšlenek", "technique": "papír, tuš, technické pero", "description": "<p><embed src=\\"//www.youtube.com/v/3A786lOX8jc?version=3&hl=ru_RU&rel=0\\" type=\\"application/x-shockwave-flash\\" width=\\"200\\" height=\\"150\\" allowscriptaccess=\\"always\\" allowfullscreen=\\"true\\" style=\\"font-size: 15px; line-height: 1.5rem; background-color: rgb(246, 246, 246);\\"></p><p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "When we go to work ", "subtitle": "The Song of thoughts", "technique": "paper, ink, technical pen", "description": "<p><embed src=\\"//www.youtube.com/v/3A786lOX8jc?version=3&hl=ru_RU&rel=0\\" type=\\"application/x-shockwave-flash\\" width=\\"200\\" height=\\"150\\" allowscriptaccess=\\"always\\" allowfullscreen=\\"true\\" style=\\"font-size: 15px; line-height: 1.5rem; background-color: rgb(246, 246, 246);\\"></p><p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Когда мы идем на работу", "subtitle": "Песня мыслей", "technique": "бумага, тушь, рапидограф", "description": "<p><embed src=\\"//www.youtube.com/v/3A786lOX8jc?version=3&hl=ru_RU&rel=0\\" type=\\"application/x-shockwave-flash\\" width=\\"200\\" height=\\"150\\" allowscriptaccess=\\"always\\" allowfullscreen=\\"true\\" style=\\"font-size: 15px; line-height: 1.5rem; background-color: rgb(246, 246, 246);\\"></p><p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
52769	1	t	0114.png	200000	2014	15 x 13,5	t	0114	2014-06-04 06:55:44.034959	2017-11-19 12:43:43.530188	24 x 22,5	{"cz": {"title": "Bez názvu #28", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Untitled #28", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #28", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
53498	1	t	0106.png	350000	2013	15 x 13,5	t	0106	2014-06-04 06:05:39.249279	2017-11-19 12:43:43.437007	24 x 22,5	{"cz": {"title": "Když se vrátíme z práce", "subtitle": "Píseň myšlenek", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "When we come back from work", "subtitle": "The Song of thoughts", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Когда мы возвращаемся с работы", "subtitle": "Песня мыслей", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
54551	1	t	0092.png	200000	2013	10 x 18	t	0092	2014-06-03 16:52:43.631255	2017-11-19 12:43:43.17325	19 x 27	{"cz": {"title": "Ztraceni v stohů", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Lost in the stacks", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Потерявшийся в стогах", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
54632	1	t	0102.png	200000	2013	15 x 13,5	t	0102	2014-06-04 05:28:14.64046	2017-11-19 12:43:43.375435	24 x 22,5	{"cz": {"title": "Be careful!", "subtitle": "Bad mood!", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Be careful!", "subtitle": "Bad mood!", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Будь осторожнее! ", "subtitle": "Плохое настроение!", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
55118	1	t	07.png	400000	2014	15 x 19,5 	t	0132	2014-11-28 10:11:59.194763	2017-11-19 12:43:43.892763	24 x 28,5	{"cz": {"title": "Bez názvu #32", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p><p><a href=\\"http://nonpandoras.com/blog/5-forty-two-views\\">forty-two views of 57°10'14.2\\"n 65°29'54.0\\"e</a></p>"}, "en": {"title": "Untitled #32", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p><p><a href=\\"http://nonpandoras.com/blog/5-forty-two-views\\">forty-two views of 57°10'14.2\\"n 65°29'54.0\\"e</a></p>"}, "ru": {"title": "Без названия #32", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p><p><a href=\\"http://nonpandoras.com/blog/5-forty-two-views\\">сорок два вида 57°10'14.2\\"n 65°29'54.0\\"e</a></p>"}}	\N
55199	1	t	0107.png	200000	2013	15 x 13,5	t	0107	2014-06-04 06:11:33.982035	2017-11-19 12:43:43.455527	24 x 22,5	{"cz": {"title": "Klid", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Calm", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Спокойствие", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
55280	1	t	36.png	250000	2014	19,5 x 15	t	222	2014-10-29 10:09:37.816811	2017-11-19 12:43:43.834922	28,5 x 24	{"cz": {"title": "Bez názvu #31", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p><p><a href=\\"http://nonpandoras.com/blog/5-forty-two-views\\">forty-two views of 57°10'14.2\\"n 65°29'54.0\\"e</a></p>"}, "en": {"title": "Untitled #31", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p><p><a href=\\"http://nonpandoras.com/blog/5-forty-two-views\\">forty-two views of 57°10'14.2\\"n 65°29'54.0\\"e</a></p>"}, "ru": {"title": "Без названия #31", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p><p><a href=\\"http://nonpandoras.com/blog/5-forty-two-views\\">сорок два вида 57°10'14.2\\"n 65°29'54.0\\"e</a></p>"}}	\N
57143	1	t	0105.png	250000	2013	15 x 13,5	t	0105	2014-06-04 05:57:20.052454	2017-11-19 12:43:43.407357	24 x 22,5	{"cz": {"title": "Bez názvu #26", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<p>Velikost pasparti na každé straně - 7cm</p><p>Každý zdobí postava přichází s kompletní sklo a závěsným systémem.</p>"}, "en": {"title": "Untitled #26", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<p>Size of mat on each side - 7 cm</p><p>Each decorated drawing comes complete with glass and pendant system.</p>"}, "ru": {"title": "Без названия #26", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<p>Размер паспарту с каждой стороны - 7 см.</p><p>Каждый оформленный рисунок поставляется в комплекте со стеклом и подвесной системой.</p>"}}	\N
57305	1	t	0144.png	250000	2015	13,5 x 13,5	f	0144	2015-02-17 16:09:45.638774	2017-11-19 12:43:43.997086	22,5 x 22,5	{"cz": {"title": "The Viscous Time #1", "subtitle": "", "technique": "papír, tuš, technické pero", "description": "<iframe width=\\"100%\\" height=\\"166\\" scrolling=\\"no\\" frameborder=\\"no\\" src=\\"https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/180138934&color=0066cc&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false\\"></iframe>"}, "en": {"title": "The Viscous Time #1", "subtitle": "", "technique": "paper, ink, technical pen", "description": "<iframe width=\\"100%\\" height=\\"166\\" scrolling=\\"no\\" frameborder=\\"no\\" src=\\"https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/180138934&color=0066cc&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false\\"></iframe>"}, "ru": {"title": "Вязкое Время #1", "subtitle": "", "technique": "бумага, тушь, рапидограф", "description": "<iframe width=\\"100%\\" height=\\"166\\" scrolling=\\"no\\" frameborder=\\"no\\" src=\\"https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/180138934&color=0066cc&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false\\"></iframe>"}}	\N
\.


--
-- Name: artworks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: scarfacedeb
--

SELECT pg_catalog.setval('artworks_id_seq', 57466, true);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: scarfacedeb
--

COPY categories (id, slug, image, inserted_at, updated_at, "position", translations) FROM stdin;
2	paintings	paintings.jpg	2014-02-18 11:06:45.7647	2017-11-19 12:45:20.188942	2	{"cz": {"title": "Malířství", "description": "<p>V této sekci si můžete prohlédnout některé z mých maleb. Sekce je pravidelně aktualizována.</p>"}, "en": {"title": "Paintings", "description": "<p>In this section you can see some of my paintings. Section is updated periodically.</p>"}, "ru": {"title": "Живопись", "description": "<p>В этом разделе вы сможете увидеть часть моей живописи. Раздел переодически обновляется.</p>"}}
1	drawings	drawings.jpg	2014-02-18 11:06:42.349456	2017-11-19 12:45:20.19349	1	{"cz": {"title": "Kresby", "description": "<p>V této sekci si můžete prohlédnout některé z mých kreseb. Sekce je pravidelně aktualizována.</p>"}, "en": {"title": "Drawings", "description": "<p>In this section you can see some of my drawings. Section is updated periodically.</p>"}, "ru": {"title": "Графика", "description": "<p>В этом разделе вы сможете увидеть часть моих рисунков. Раздел периодически обновляется.&nbsp;</p>"}}
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: scarfacedeb
--

SELECT pg_catalog.setval('categories_id_seq', 3, true);


--
-- Data for Name: category_translations; Type: TABLE DATA; Schema: public; Owner: scarfacedeb
--

COPY category_translations (id, category_id, locale, created_at, updated_at, title, "desc") FROM stdin;
2	1	ru	2014-02-18 11:06:42.380017	2014-03-27 13:11:02.227492	Графика	<p>В этом разделе вы сможете увидеть часть моих рисунков. Раздел периодически обновляется.&nbsp;</p>
1	1	en	2014-02-18 11:06:42.374259	2014-03-27 13:12:50.633378	Drawings	<p>In this section you can see some of my drawings. Section is updated periodically.</p>
5	2	ru	2014-02-18 11:06:45.769483	2014-03-27 13:16:45.682013	Живопись	<p>В этом разделе вы сможете увидеть часть моей живописи. Раздел переодически обновляется.</p>
4	2	en	2014-02-18 11:06:45.767672	2014-03-27 13:16:45.683296	Paintings	<p>In this section you can see some of my paintings. Section is updated periodically.</p>
6	2	cz	2014-02-18 11:06:45.771086	2014-10-28 12:19:55.313878	Malířství	<p>V této sekci si můžete prohlédnout některé z mých maleb. Sekce je pravidelně aktualizována.</p>
3	1	cz	2014-02-18 11:06:42.382749	2014-10-28 12:20:05.994952	Kresby	<p>V této sekci si můžete prohlédnout některé z mých kreseb. Sekce je pravidelně aktualizována.</p>
\.


--
-- Name: category_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: scarfacedeb
--

SELECT pg_catalog.setval('category_translations_id_seq', 9, true);


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: scarfacedeb
--

COPY order_items (id, artwork_id, order_id, quantity, mat_bg_id, frame_bg_id, frame_id, no_decoration, price_cents, price_currency, created_at, updated_at) FROM stdin;
140	140	247	1	4	7	9	f	0	RUB	2014-11-09 11:41:02.760867	2014-11-09 11:41:02.760867
141	223	255	1	4	7	9	f	0	RUB	2014-11-10 15:08:16.97479	2014-11-10 15:08:16.97479
142	140	256	1	5	7	9	f	0	RUB	2014-11-10 17:09:20.772701	2014-11-10 17:09:20.772701
143	140	277	1	4	7	9	f	0	RUB	2014-11-16 11:50:14.830382	2014-11-16 11:50:14.830382
144	212	299	1	0	0	0	t	0	RUB	2014-11-26 08:38:52.452525	2014-11-26 08:38:52.452525
147	183	352	1	4	7	9	f	0	RUB	2014-12-22 16:26:13.397441	2014-12-22 16:26:13.397441
148	233	489	1	4	7	9	f	0	RUB	2015-03-20 11:48:03.367815	2015-03-20 11:48:03.367815
149	235	595	2	4	7	9	f	0	RUB	2015-05-06 18:08:35.956219	2015-05-06 18:08:51.145181
\.


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: scarfacedeb
--

SELECT pg_catalog.setval('order_items_id_seq', 149, true);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: scarfacedeb
--

COPY orders (id, status, completed_at, created_at, updated_at, first_name, last_name, email, phone, message, country, zip, state, city, address, shipping, payment) FROM stdin;
238	0	\N	2014-11-06 15:03:57.177769	2014-11-06 15:03:57.177769	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
239	0	\N	2014-11-06 15:29:57.958536	2014-11-06 15:29:57.958536	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
240	0	\N	2014-11-06 15:58:50.995599	2014-11-06 15:58:50.995599	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
241	0	\N	2014-11-06 16:11:12.339588	2014-11-06 16:11:12.339588	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
242	0	\N	2014-11-06 16:40:53.40932	2014-11-06 16:40:53.40932	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
243	0	\N	2014-11-06 20:50:50.734336	2014-11-06 20:50:50.734336	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
244	0	\N	2014-11-07 05:42:40.454846	2014-11-07 05:42:40.454846	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
245	0	\N	2014-11-08 03:31:28.941518	2014-11-08 03:31:28.941518	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
246	0	\N	2014-11-08 18:24:57.459106	2014-11-08 18:24:57.459106	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
247	0	\N	2014-11-09 11:39:46.253149	2014-11-09 11:39:46.253149	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
248	0	\N	2014-11-09 12:10:14.415342	2014-11-09 12:10:14.415342	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
249	0	\N	2014-11-09 12:54:36.878995	2014-11-09 12:54:36.878995	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
250	0	\N	2014-11-09 15:06:01.671447	2014-11-09 15:06:01.671447	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
251	0	\N	2014-11-09 15:07:21.068424	2014-11-09 15:07:21.068424	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
252	0	\N	2014-11-09 18:33:15.739225	2014-11-09 18:33:15.739225	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
253	0	\N	2014-11-10 04:02:51.526892	2014-11-10 04:02:51.526892	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
254	0	\N	2014-11-10 12:03:57.850371	2014-11-10 12:03:57.850371	\N	\N	\N	\N	\N	FR	\N	\N	\N	\N	\N	\N
255	0	\N	2014-11-10 15:08:16.945921	2014-11-10 15:08:16.945921	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
256	0	\N	2014-11-10 17:09:20.747502	2014-11-10 17:09:20.747502	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
257	0	\N	2014-11-10 17:28:04.981014	2014-11-10 17:28:04.981014	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
258	0	\N	2014-11-10 17:39:05.281653	2014-11-10 17:39:05.281653	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
259	0	\N	2014-11-11 18:56:41.327594	2014-11-11 18:56:41.327594	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
260	0	\N	2014-11-12 18:29:09.754111	2014-11-12 18:29:09.754111	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
261	0	\N	2014-11-12 19:03:42.520631	2014-11-12 19:03:42.520631	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
262	0	\N	2014-11-13 16:21:18.424532	2014-11-13 16:21:18.424532	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
263	0	\N	2014-11-14 13:37:35.526706	2014-11-14 13:37:35.526706	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
264	0	\N	2014-11-14 13:37:36.156021	2014-11-14 13:37:36.156021	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
265	0	\N	2014-11-14 13:38:11.142251	2014-11-14 13:38:11.142251	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
266	0	\N	2014-11-14 13:38:40.593053	2014-11-14 13:38:40.593053	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
267	0	\N	2014-11-14 13:38:42.843729	2014-11-14 13:38:42.843729	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
268	0	\N	2014-11-14 13:38:53.681089	2014-11-14 13:38:53.681089	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
269	0	\N	2014-11-14 13:39:37.937064	2014-11-14 13:39:37.937064	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
270	0	\N	2014-11-14 13:40:19.706489	2014-11-14 13:40:19.706489	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
271	0	\N	2014-11-14 17:52:07.272492	2014-11-14 17:52:07.272492	\N	\N	\N	\N	\N	CN	\N	\N	\N	\N	\N	\N
272	0	\N	2014-11-15 00:39:09.945138	2014-11-15 00:39:09.945138	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
273	0	\N	2014-11-15 03:19:38.632457	2014-11-15 03:19:38.632457	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
274	0	\N	2014-11-15 03:19:41.981329	2014-11-15 03:19:41.981329	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
275	0	\N	2014-11-15 03:19:51.337485	2014-11-15 03:19:51.337485	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
276	0	\N	2014-11-15 12:01:12.318895	2014-11-15 12:01:12.318895	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
277	0	\N	2014-11-16 11:50:14.811659	2014-11-16 11:50:14.811659	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
278	0	\N	2014-11-17 05:16:50.363173	2014-11-17 05:16:50.363173	\N	\N	\N	\N	\N	CN	\N	\N	\N	\N	\N	\N
279	0	\N	2014-11-17 05:17:03.099949	2014-11-17 05:17:03.099949	\N	\N	\N	\N	\N	CN	\N	\N	\N	\N	\N	\N
280	0	\N	2014-11-18 09:17:49.405334	2014-11-18 09:17:49.405334	\N	\N	\N	\N	\N	CN	\N	\N	\N	\N	\N	\N
281	0	\N	2014-11-18 15:44:00.623489	2014-11-18 15:44:00.623489	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
282	0	\N	2014-11-18 18:39:00.039237	2014-11-18 18:39:00.039237	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
283	0	\N	2014-11-18 23:05:08.336453	2014-11-18 23:05:08.336453	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
284	0	\N	2014-11-20 06:43:45.280986	2014-11-20 06:43:45.280986	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
285	0	\N	2014-11-20 14:21:32.9524	2014-11-20 14:21:32.9524	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
286	0	\N	2014-11-20 16:00:27.428411	2014-11-20 16:00:27.428411	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
287	0	\N	2014-11-21 00:20:56.879644	2014-11-21 00:20:56.879644	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
288	0	\N	2014-11-21 13:18:14.071359	2014-11-21 13:18:14.071359	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
289	0	\N	2014-11-21 20:10:49.40349	2014-11-21 20:10:49.40349	\N	\N	\N	\N	\N	CN	\N	\N	\N	\N	\N	\N
290	0	\N	2014-11-22 01:10:57.575451	2014-11-22 01:10:57.575451	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
291	0	\N	2014-11-22 21:53:37.826633	2014-11-22 21:53:37.826633	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
292	0	\N	2014-11-23 18:11:48.163097	2014-11-23 18:11:48.163097	\N	\N	\N	\N	\N	FR	\N	\N	\N	\N	\N	\N
293	0	\N	2014-11-24 08:53:00.226168	2014-11-24 08:53:00.226168	\N	\N	\N	\N	\N	FR	\N	\N	\N	\N	\N	\N
294	0	\N	2014-11-24 09:21:11.788297	2014-11-24 09:21:11.788297	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
295	0	\N	2014-11-25 06:37:57.452541	2014-11-25 06:37:57.452541	\N	\N	\N	\N	\N	CN	\N	\N	\N	\N	\N	\N
296	0	\N	2014-11-25 13:22:34.649434	2014-11-25 13:22:34.649434	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
297	0	\N	2014-11-25 16:33:55.094565	2014-11-25 16:33:55.094565	\N	\N	\N	\N	\N	CN	\N	\N	\N	\N	\N	\N
298	0	\N	2014-11-26 03:37:32.75897	2014-11-26 03:37:32.75897	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
299	0	\N	2014-11-26 08:38:52.425165	2014-11-26 08:38:52.425165	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
300	0	\N	2014-11-26 08:50:12.085263	2014-11-26 08:50:12.085263	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
301	0	\N	2014-11-26 09:48:58.722796	2014-11-26 09:48:58.722796	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
302	0	\N	2014-11-26 09:50:57.110321	2014-11-26 09:50:57.110321	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
303	0	\N	2014-11-26 09:50:58.670186	2014-11-26 09:50:58.670186	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
304	0	\N	2014-11-26 20:20:51.776741	2014-11-26 20:20:51.776741	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
305	0	\N	2014-11-26 23:13:59.278352	2014-11-26 23:13:59.278352	\N	\N	\N	\N	\N	NL	\N	\N	\N	\N	\N	\N
306	0	\N	2014-11-27 02:22:04.943785	2014-11-27 02:22:04.943785	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
307	0	\N	2014-11-27 02:33:10.770715	2014-11-27 02:33:10.770715	\N	\N	\N	\N	\N	AZ	\N	\N	\N	\N	\N	\N
308	0	\N	2014-11-27 10:17:19.587482	2014-11-27 10:17:19.587482	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
309	0	\N	2014-11-28 01:06:13.393506	2014-11-28 01:06:13.393506	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
310	0	\N	2014-11-28 09:28:48.291532	2014-11-28 09:28:48.291532	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
311	0	\N	2014-11-28 16:24:22.718919	2014-11-28 16:24:22.718919	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
312	0	\N	2014-11-30 18:10:25.916626	2014-11-30 18:10:25.916626	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
313	0	\N	2014-11-30 18:10:28.99899	2014-11-30 18:10:28.99899	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
314	0	\N	2014-12-01 11:03:26.174004	2014-12-01 11:03:26.174004	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
315	0	\N	2014-12-02 00:16:52.03209	2014-12-02 00:16:52.03209	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
316	0	\N	2014-12-03 01:22:43.84336	2014-12-03 01:22:43.84336	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
317	0	\N	2014-12-03 01:22:54.605881	2014-12-03 01:22:54.605881	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
318	0	\N	2014-12-03 01:23:14.065735	2014-12-03 01:23:14.065735	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
319	0	\N	2014-12-03 06:56:36.11026	2014-12-03 06:56:36.11026	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
320	0	\N	2014-12-03 13:59:58.721639	2014-12-03 13:59:58.721639	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
321	0	\N	2014-12-04 17:59:44.960392	2014-12-04 17:59:44.960392	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
322	0	\N	2014-12-05 17:21:47.118605	2014-12-05 17:21:47.118605	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
323	0	\N	2014-12-06 08:16:58.47644	2014-12-06 08:16:58.47644	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
325	0	\N	2014-12-06 21:26:10.686012	2014-12-06 21:26:10.686012	\N	\N	\N	\N	\N	NL	\N	\N	\N	\N	\N	\N
326	0	\N	2014-12-06 21:28:39.808038	2014-12-06 21:28:39.808038	\N	\N	\N	\N	\N	NL	\N	\N	\N	\N	\N	\N
328	0	\N	2014-12-07 22:06:48.362757	2014-12-07 22:06:48.362757	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
329	0	\N	2014-12-08 12:17:04.878845	2014-12-08 12:17:04.878845	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
330	0	\N	2014-12-08 23:26:50.753768	2014-12-08 23:26:50.753768	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
331	0	\N	2014-12-09 05:34:26.080248	2014-12-09 05:34:26.080248	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
332	0	\N	2014-12-09 08:17:00.309738	2014-12-09 08:17:00.309738	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
333	0	\N	2014-12-10 03:26:08.846304	2014-12-10 03:26:08.846304	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
334	0	\N	2014-12-12 06:55:56.368143	2014-12-12 06:55:56.368143	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
335	0	\N	2014-12-12 20:09:02.597809	2014-12-12 20:09:02.597809	\N	\N	\N	\N	\N	FR	\N	\N	\N	\N	\N	\N
336	0	\N	2014-12-13 01:42:43.540997	2014-12-13 01:42:43.540997	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
337	0	\N	2014-12-13 03:49:42.162208	2014-12-13 03:49:42.162208	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
338	0	\N	2014-12-13 05:27:59.380338	2014-12-13 05:27:59.380338	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
339	0	\N	2014-12-13 05:39:11.203372	2014-12-13 05:39:11.203372	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
340	0	\N	2014-12-13 12:09:20.233024	2014-12-13 12:09:20.233024	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
341	0	\N	2014-12-14 04:52:57.807384	2014-12-14 04:52:57.807384	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
342	0	\N	2014-12-14 09:54:49.766393	2014-12-14 09:54:49.766393	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
343	0	\N	2014-12-15 18:49:35.458398	2014-12-15 18:49:35.458398	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
344	0	\N	2014-12-15 22:27:32.55981	2014-12-15 22:27:32.55981	\N	\N	\N	\N	\N	FR	\N	\N	\N	\N	\N	\N
345	0	\N	2014-12-16 23:58:12.087491	2014-12-16 23:58:12.087491	\N	\N	\N	\N	\N	MD	\N	\N	\N	\N	\N	\N
346	0	\N	2014-12-18 15:43:07.801079	2014-12-18 15:43:07.801079	\N	\N	\N	\N	\N	CN	\N	\N	\N	\N	\N	\N
347	0	\N	2014-12-19 05:11:25.103399	2014-12-19 05:11:25.103399	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
348	0	\N	2014-12-19 17:15:17.883116	2014-12-19 17:15:17.883116	\N	\N	\N	\N	\N	FR	\N	\N	\N	\N	\N	\N
349	0	\N	2014-12-19 17:34:35.495111	2014-12-19 17:34:35.495111	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
350	0	\N	2014-12-20 06:46:44.479416	2014-12-20 06:46:44.479416	\N	\N	\N	\N	\N	FR	\N	\N	\N	\N	\N	\N
351	0	\N	2014-12-20 21:24:32.695182	2014-12-20 21:24:32.695182	\N	\N	\N	\N	\N	FR	\N	\N	\N	\N	\N	\N
352	0	\N	2014-12-22 16:26:13.374488	2014-12-22 16:26:13.374488	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
353	0	\N	2014-12-23 19:48:45.83471	2014-12-23 19:48:45.83471	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
354	0	\N	2014-12-26 18:17:01.962899	2014-12-26 18:17:01.962899	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
355	0	\N	2014-12-27 20:04:44.799654	2014-12-27 20:04:44.799654	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
356	0	\N	2014-12-28 13:13:58.073979	2014-12-28 13:13:58.073979	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
357	0	\N	2014-12-29 01:59:47.323761	2014-12-29 01:59:47.323761	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
358	0	\N	2014-12-29 14:59:29.396529	2014-12-29 14:59:29.396529	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
359	0	\N	2014-12-31 09:24:59.264282	2014-12-31 09:24:59.264282	\N	\N	\N	\N	\N	CN	\N	\N	\N	\N	\N	\N
360	0	\N	2014-12-31 09:37:02.548166	2014-12-31 09:37:02.548166	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
361	0	\N	2015-01-01 01:49:37.795282	2015-01-01 01:49:37.795282	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
362	0	\N	2015-01-01 06:44:52.780533	2015-01-01 06:44:52.780533	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
363	0	\N	2015-01-01 06:44:57.377276	2015-01-01 06:44:57.377276	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
364	0	\N	2015-01-01 06:45:17.594658	2015-01-01 06:45:17.594658	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
365	0	\N	2015-01-01 16:10:47.174282	2015-01-01 16:10:47.174282	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
366	0	\N	2015-01-02 12:09:02.817896	2015-01-02 12:09:02.817896	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
367	0	\N	2015-01-02 12:09:14.810931	2015-01-02 12:09:14.810931	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
368	0	\N	2015-01-02 12:09:17.291747	2015-01-02 12:09:17.291747	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
369	0	\N	2015-01-04 00:59:29.576315	2015-01-04 00:59:29.576315	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
370	0	\N	2015-01-04 07:26:34.934743	2015-01-04 07:26:34.934743	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
371	0	\N	2015-01-04 18:56:08.642524	2015-01-04 18:56:08.642524	\N	\N	\N	\N	\N	FR	\N	\N	\N	\N	\N	\N
372	0	\N	2015-01-06 04:54:39.892946	2015-01-06 04:54:39.892946	\N	\N	\N	\N	\N	CN	\N	\N	\N	\N	\N	\N
373	0	\N	2015-01-07 11:35:38.882956	2015-01-07 11:35:38.882956	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
374	0	\N	2015-01-07 18:48:47.255321	2015-01-07 18:48:47.255321	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
375	0	\N	2015-01-07 21:03:14.932864	2015-01-07 21:03:14.932864	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
376	0	\N	2015-01-08 14:16:41.954409	2015-01-08 14:16:41.954409	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
377	0	\N	2015-01-08 14:16:42.923703	2015-01-08 14:16:42.923703	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
378	0	\N	2015-01-09 12:20:15.991922	2015-01-09 12:20:15.991922	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
379	0	\N	2015-01-09 13:15:38.789305	2015-01-09 13:15:38.789305	\N	\N	\N	\N	\N	CN	\N	\N	\N	\N	\N	\N
380	0	\N	2015-01-10 19:45:39.414957	2015-01-10 19:45:39.414957	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
381	0	\N	2015-01-11 13:53:58.642241	2015-01-11 13:53:58.642241	\N	\N	\N	\N	\N	FR	\N	\N	\N	\N	\N	\N
382	0	\N	2015-01-14 05:57:43.936869	2015-01-14 05:57:43.936869	\N	\N	\N	\N	\N	FR	\N	\N	\N	\N	\N	\N
383	0	\N	2015-01-14 11:49:04.379901	2015-01-14 11:49:04.379901	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
384	0	\N	2015-01-15 03:49:00.1978	2015-01-15 03:49:00.1978	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
385	0	\N	2015-01-15 10:47:25.185412	2015-01-15 10:47:25.185412	\N	\N	\N	\N	\N	CH	\N	\N	\N	\N	\N	\N
386	0	\N	2015-01-15 13:18:39.930946	2015-01-15 13:18:39.930946	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
387	0	\N	2015-01-15 13:19:55.940725	2015-01-15 13:19:55.940725	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
388	0	\N	2015-01-15 13:21:17.754576	2015-01-15 13:21:17.754576	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
389	0	\N	2015-01-16 00:10:34.314302	2015-01-16 00:10:34.314302	\N	\N	\N	\N	\N	FR	\N	\N	\N	\N	\N	\N
390	0	\N	2015-01-16 05:55:08.005853	2015-01-16 05:55:08.005853	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
391	0	\N	2015-01-16 05:55:17.596793	2015-01-16 05:55:17.596793	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
392	0	\N	2015-01-16 05:55:32.587851	2015-01-16 05:55:32.587851	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
393	0	\N	2015-01-16 17:56:42.806439	2015-01-16 17:56:42.806439	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
394	0	\N	2015-01-18 13:22:12.051666	2015-01-18 13:22:12.051666	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
395	0	\N	2015-01-19 16:48:29.962083	2015-01-19 16:48:29.962083	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
396	0	\N	2015-01-20 09:26:40.260563	2015-01-20 09:26:40.260563	\N	\N	\N	\N	\N	FR	\N	\N	\N	\N	\N	\N
397	0	\N	2015-01-20 13:37:45.256929	2015-01-20 13:37:45.256929	\N	\N	\N	\N	\N	PL	\N	\N	\N	\N	\N	\N
398	0	\N	2015-01-21 13:14:21.140458	2015-01-21 13:14:21.140458	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
399	0	\N	2015-01-22 12:55:09.883378	2015-01-22 12:55:09.883378	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
400	0	\N	2015-01-22 12:55:10.656097	2015-01-22 12:55:10.656097	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
401	0	\N	2015-01-22 13:19:27.91082	2015-01-22 13:19:27.91082	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
402	0	\N	2015-01-23 04:57:51.946291	2015-01-23 04:57:51.946291	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
403	0	\N	2015-01-23 11:26:53.05296	2015-01-23 11:26:53.05296	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
404	0	\N	2015-01-23 12:28:22.017292	2015-01-23 12:28:22.017292	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
405	0	\N	2015-01-23 13:21:01.938435	2015-01-23 13:21:01.938435	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
406	0	\N	2015-01-23 18:10:47.287198	2015-01-23 18:10:47.287198	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
407	0	\N	2015-01-23 19:38:35.572064	2015-01-23 19:38:35.572064	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
408	0	\N	2015-01-26 05:40:48.469985	2015-01-26 05:40:48.469985	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
409	0	\N	2015-01-28 18:48:34.947731	2015-01-28 18:48:34.947731	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
410	0	\N	2015-01-28 18:49:22.321967	2015-01-28 18:49:22.321967	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
411	0	\N	2015-01-29 08:57:32.37112	2015-01-29 08:57:32.37112	\N	\N	\N	\N	\N	FR	\N	\N	\N	\N	\N	\N
412	0	\N	2015-01-30 05:25:02.969651	2015-01-30 05:25:02.969651	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
413	0	\N	2015-01-30 10:18:08.171069	2015-01-30 10:18:08.171069	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
414	0	\N	2015-01-30 10:48:01.731912	2015-01-30 10:48:01.731912	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
415	0	\N	2015-02-02 17:03:16.297547	2015-02-02 17:03:16.297547	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
416	0	\N	2015-02-02 17:03:28.761763	2015-02-02 17:03:28.761763	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
417	0	\N	2015-02-02 17:03:45.310675	2015-02-02 17:03:45.310675	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
418	0	\N	2015-02-03 02:29:46.070789	2015-02-03 02:29:46.070789	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
419	0	\N	2015-02-03 23:13:52.413313	2015-02-03 23:13:52.413313	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
420	0	\N	2015-02-05 23:26:48.575046	2015-02-05 23:26:48.575046	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
421	0	\N	2015-02-05 23:50:35.282474	2015-02-05 23:50:35.282474	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
422	0	\N	2015-02-06 01:12:31.533099	2015-02-06 01:12:31.533099	\N	\N	\N	\N	\N	GB	\N	\N	\N	\N	\N	\N
423	0	\N	2015-02-07 20:15:29.04458	2015-02-07 20:15:29.04458	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
424	0	\N	2015-02-07 20:18:41.741075	2015-02-07 20:18:41.741075	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
425	0	\N	2015-02-09 09:25:09.565463	2015-02-09 09:25:09.565463	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
426	0	\N	2015-02-10 06:54:31.442989	2015-02-10 06:54:31.442989	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
427	0	\N	2015-02-11 06:15:32.091921	2015-02-11 06:15:32.091921	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
428	0	\N	2015-02-12 00:48:45.523741	2015-02-12 00:48:45.523741	\N	\N	\N	\N	\N	CN	\N	\N	\N	\N	\N	\N
429	0	\N	2015-02-12 09:47:05.228369	2015-02-12 09:47:05.228369	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
430	0	\N	2015-02-12 12:41:31.952923	2015-02-12 12:41:31.952923	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
431	0	\N	2015-02-13 12:59:12.252497	2015-02-13 12:59:12.252497	\N	\N	\N	\N	\N	FR	\N	\N	\N	\N	\N	\N
432	0	\N	2015-02-14 14:29:58.92868	2015-02-14 14:29:58.92868	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
433	0	\N	2015-02-15 04:36:45.381452	2015-02-15 04:36:45.381452	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
434	0	\N	2015-02-16 09:42:24.201869	2015-02-16 09:42:24.201869	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
435	0	\N	2015-02-16 10:45:27.180831	2015-02-16 10:45:27.180831	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
436	0	\N	2015-02-16 10:46:20.212152	2015-02-16 10:46:20.212152	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
437	0	\N	2015-02-17 04:02:17.823972	2015-02-17 04:02:17.823972	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
438	0	\N	2015-02-17 04:13:36.533854	2015-02-17 04:13:36.533854	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
439	0	\N	2015-02-17 04:59:08.169281	2015-02-17 04:59:08.169281	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
440	0	\N	2015-02-18 12:03:54.500375	2015-02-18 12:03:54.500375	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
441	0	\N	2015-02-18 17:59:49.933912	2015-02-18 17:59:49.933912	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
442	0	\N	2015-02-18 21:16:13.273045	2015-02-18 21:16:13.273045	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
443	0	\N	2015-02-19 00:35:18.277674	2015-02-19 00:35:18.277674	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
444	0	\N	2015-02-19 00:36:25.012219	2015-02-19 00:36:25.012219	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
445	0	\N	2015-02-19 00:37:36.201067	2015-02-19 00:37:36.201067	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
446	0	\N	2015-02-19 23:02:48.355406	2015-02-19 23:02:48.355406	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
447	0	\N	2015-02-19 23:03:08.81603	2015-02-19 23:03:08.81603	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
448	0	\N	2015-02-19 23:03:18.527982	2015-02-19 23:03:18.527982	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
449	0	\N	2015-02-21 04:55:57.72958	2015-02-21 04:55:57.72958	\N	\N	\N	\N	\N	CN	\N	\N	\N	\N	\N	\N
450	0	\N	2015-02-23 16:18:31.279298	2015-02-23 16:18:31.279298	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
451	0	\N	2015-02-25 23:50:57.221246	2015-02-25 23:50:57.221246	\N	\N	\N	\N	\N	CN	\N	\N	\N	\N	\N	\N
452	0	\N	2015-02-27 00:24:43.619148	2015-02-27 00:24:43.619148	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
453	0	\N	2015-03-02 20:57:20.243132	2015-03-02 20:57:20.243132	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
454	0	\N	2015-03-03 18:09:21.246325	2015-03-03 18:09:21.246325	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
455	0	\N	2015-03-03 18:09:56.500121	2015-03-03 18:09:56.500121	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
456	0	\N	2015-03-04 06:54:42.01361	2015-03-04 06:54:42.01361	\N	\N	\N	\N	\N	FR	\N	\N	\N	\N	\N	\N
457	0	\N	2015-03-05 07:08:44.276889	2015-03-05 07:08:44.276889	\N	\N	\N	\N	\N	CN	\N	\N	\N	\N	\N	\N
458	0	\N	2015-03-05 08:26:07.903714	2015-03-05 08:26:07.903714	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
459	0	\N	2015-03-05 21:07:49.911623	2015-03-05 21:07:49.911623	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
460	0	\N	2015-03-06 03:45:26.261273	2015-03-06 03:45:26.261273	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
461	0	\N	2015-03-06 03:50:33.284082	2015-03-06 03:50:33.284082	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
462	0	\N	2015-03-06 03:51:33.365543	2015-03-06 03:51:33.365543	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
463	0	\N	2015-03-06 10:07:59.996701	2015-03-06 10:07:59.996701	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
464	0	\N	2015-03-06 10:08:25.251976	2015-03-06 10:08:25.251976	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
465	0	\N	2015-03-06 10:08:35.173287	2015-03-06 10:08:35.173287	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
466	0	\N	2015-03-06 10:39:07.736613	2015-03-06 10:39:07.736613	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
467	0	\N	2015-03-06 21:31:26.887349	2015-03-06 21:31:26.887349	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
468	0	\N	2015-03-07 01:54:25.179654	2015-03-07 01:54:25.179654	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
469	0	\N	2015-03-07 08:49:58.532176	2015-03-07 08:49:58.532176	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
470	0	\N	2015-03-07 20:28:43.873825	2015-03-07 20:28:43.873825	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
471	0	\N	2015-03-08 12:02:28.568918	2015-03-08 12:02:28.568918	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
472	0	\N	2015-03-08 12:02:50.829283	2015-03-08 12:02:50.829283	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
473	0	\N	2015-03-08 12:02:51.323255	2015-03-08 12:02:51.323255	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
474	0	\N	2015-03-08 20:38:28.195717	2015-03-08 20:38:28.195717	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
475	0	\N	2015-03-09 08:35:07.65267	2015-03-09 08:35:07.65267	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
476	0	\N	2015-03-10 05:30:15.702126	2015-03-10 05:30:15.702126	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
477	0	\N	2015-03-10 19:27:57.926981	2015-03-10 19:27:57.926981	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
478	0	\N	2015-03-11 03:10:29.783534	2015-03-11 03:10:29.783534	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
479	0	\N	2015-03-12 03:39:14.024584	2015-03-12 03:39:14.024584	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
480	0	\N	2015-03-15 07:07:13.649571	2015-03-15 07:07:13.649571	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
481	0	\N	2015-03-15 09:05:08.216325	2015-03-15 09:05:08.216325	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
482	0	\N	2015-03-17 06:04:29.032974	2015-03-17 06:04:29.032974	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
483	0	\N	2015-03-17 10:21:05.021792	2015-03-17 10:21:05.021792	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
484	0	\N	2015-03-17 21:23:03.543549	2015-03-17 21:23:03.543549	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
485	0	\N	2015-03-18 08:50:32.738604	2015-03-18 08:50:32.738604	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
486	0	\N	2015-03-18 11:09:09.524909	2015-03-18 11:09:09.524909	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
487	0	\N	2015-03-19 06:50:00.12123	2015-03-19 06:50:00.12123	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
488	0	\N	2015-03-19 12:19:39.577919	2015-03-19 12:19:39.577919	\N	\N	\N	\N	\N	CN	\N	\N	\N	\N	\N	\N
489	0	\N	2015-03-20 11:48:03.334632	2015-03-20 11:48:03.334632	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
490	0	\N	2015-03-20 21:54:53.308004	2015-03-20 21:54:53.308004	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
491	0	\N	2015-03-20 21:55:11.792524	2015-03-20 21:55:11.792524	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
492	0	\N	2015-03-20 21:55:22.112496	2015-03-20 21:55:22.112496	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
493	0	\N	2015-03-20 23:00:59.69383	2015-03-20 23:00:59.69383	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
494	0	\N	2015-03-22 12:45:56.515439	2015-03-22 12:45:56.515439	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
495	0	\N	2015-03-22 16:51:08.995165	2015-03-22 16:51:08.995165	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
496	0	\N	2015-03-23 08:15:09.486566	2015-03-23 08:15:09.486566	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
497	0	\N	2015-03-24 09:00:45.934676	2015-03-24 09:00:45.934676	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
498	0	\N	2015-03-24 09:01:35.504635	2015-03-24 09:01:35.504635	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
499	0	\N	2015-03-24 09:01:36.545049	2015-03-24 09:01:36.545049	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
500	0	\N	2015-03-24 10:19:11.529642	2015-03-24 10:19:11.529642	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
501	0	\N	2015-03-24 21:15:06.535234	2015-03-24 21:15:06.535234	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
502	0	\N	2015-03-26 17:48:35.070966	2015-03-26 17:48:35.070966	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
503	0	\N	2015-03-27 19:17:58.297524	2015-03-27 19:17:58.297524	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
504	0	\N	2015-03-27 19:18:24.127437	2015-03-27 19:18:24.127437	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
505	0	\N	2015-03-27 19:18:24.454843	2015-03-27 19:18:24.454843	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
506	0	\N	2015-03-28 05:33:17.331852	2015-03-28 05:33:17.331852	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
507	0	\N	2015-03-30 02:50:57.263779	2015-03-30 02:50:57.263779	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
508	0	\N	2015-03-30 21:03:56.634949	2015-03-30 21:03:56.634949	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
509	0	\N	2015-03-30 21:04:12.022219	2015-03-30 21:04:12.022219	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
510	0	\N	2015-03-31 15:18:18.170664	2015-03-31 15:18:18.170664	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
511	0	\N	2015-03-31 15:18:57.21557	2015-03-31 15:18:57.21557	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
512	0	\N	2015-03-31 15:18:57.52669	2015-03-31 15:18:57.52669	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
513	0	\N	2015-04-02 09:37:46.835233	2015-04-02 09:37:46.835233	\N	\N	\N	\N	\N	TW	\N	\N	\N	\N	\N	\N
514	0	\N	2015-04-02 18:55:09.23999	2015-04-02 18:55:09.23999	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
515	0	\N	2015-04-03 02:24:03.586134	2015-04-03 02:24:03.586134	\N	\N	\N	\N	\N	FR	\N	\N	\N	\N	\N	\N
516	0	\N	2015-04-03 11:25:29.616576	2015-04-03 11:25:29.616576	\N	\N	\N	\N	\N	CN	\N	\N	\N	\N	\N	\N
517	0	\N	2015-04-03 12:17:24.75632	2015-04-03 12:17:24.75632	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
518	0	\N	2015-04-03 12:17:57.20459	2015-04-03 12:17:57.20459	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
519	0	\N	2015-04-03 12:17:57.452037	2015-04-03 12:17:57.452037	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
520	0	\N	2015-04-03 20:35:33.195454	2015-04-03 20:35:33.195454	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
521	0	\N	2015-04-03 20:35:52.917596	2015-04-03 20:35:52.917596	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
522	0	\N	2015-04-03 20:36:03.078616	2015-04-03 20:36:03.078616	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
523	0	\N	2015-04-05 06:17:23.159005	2015-04-05 06:17:23.159005	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
524	0	\N	2015-04-06 11:25:42.252344	2015-04-06 11:25:42.252344	\N	\N	\N	\N	\N	CN	\N	\N	\N	\N	\N	\N
525	0	\N	2015-04-06 12:29:39.496985	2015-04-06 12:29:39.496985	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
526	0	\N	2015-04-06 12:30:32.891195	2015-04-06 12:30:32.891195	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
527	0	\N	2015-04-06 12:30:33.259813	2015-04-06 12:30:33.259813	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
528	0	\N	2015-04-06 23:46:04.101853	2015-04-06 23:46:04.101853	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
529	0	\N	2015-04-07 00:26:17.554179	2015-04-07 00:26:17.554179	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
530	0	\N	2015-04-07 06:34:01.367893	2015-04-07 06:34:01.367893	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
531	0	\N	2015-04-07 06:34:12.751671	2015-04-07 06:34:12.751671	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
532	0	\N	2015-04-08 04:57:46.438368	2015-04-08 04:57:46.438368	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
533	0	\N	2015-04-09 19:22:32.474095	2015-04-09 19:22:32.474095	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
534	0	\N	2015-04-09 19:23:19.353221	2015-04-09 19:23:19.353221	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
535	0	\N	2015-04-09 19:23:20.331171	2015-04-09 19:23:20.331171	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
536	0	\N	2015-04-10 23:52:03.342922	2015-04-10 23:52:03.342922	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
537	0	\N	2015-04-11 23:12:17.52654	2015-04-11 23:12:17.52654	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
538	0	\N	2015-04-11 23:13:23.801947	2015-04-11 23:13:23.801947	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
539	0	\N	2015-04-11 23:13:25.077178	2015-04-11 23:13:25.077178	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
540	0	\N	2015-04-12 22:00:56.932405	2015-04-12 22:00:56.932405	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
541	0	\N	2015-04-14 04:10:26.907226	2015-04-14 04:10:26.907226	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
542	0	\N	2015-04-14 04:10:58.962275	2015-04-14 04:10:58.962275	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
543	0	\N	2015-04-14 04:10:59.316909	2015-04-14 04:10:59.316909	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
544	0	\N	2015-04-14 10:03:36.554661	2015-04-14 10:03:36.554661	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
545	0	\N	2015-04-15 11:54:12.354642	2015-04-15 11:54:12.354642	\N	\N	\N	\N	\N	FR	\N	\N	\N	\N	\N	\N
546	0	\N	2015-04-15 21:06:47.942743	2015-04-15 21:06:47.942743	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
547	0	\N	2015-04-15 22:01:45.479008	2015-04-15 22:01:45.479008	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
548	0	\N	2015-04-15 22:04:35.000824	2015-04-15 22:04:35.000824	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
549	0	\N	2015-04-15 22:54:38.114683	2015-04-15 22:54:38.114683	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
550	0	\N	2015-04-16 00:17:38.519314	2015-04-16 00:17:38.519314	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
551	0	\N	2015-04-16 01:15:19.779763	2015-04-16 01:15:19.779763	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
552	0	\N	2015-04-16 02:57:21.248897	2015-04-16 02:57:21.248897	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
553	0	\N	2015-04-16 04:04:15.540565	2015-04-16 04:04:15.540565	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
554	0	\N	2015-04-16 05:04:20.843194	2015-04-16 05:04:20.843194	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
555	0	\N	2015-04-16 07:00:29.895383	2015-04-16 07:00:29.895383	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
556	0	\N	2015-04-16 07:51:01.067755	2015-04-16 07:51:01.067755	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
557	0	\N	2015-04-16 14:16:41.251658	2015-04-16 14:16:41.251658	\N	\N	\N	\N	\N	FR	\N	\N	\N	\N	\N	\N
558	0	\N	2015-04-18 05:09:39.629753	2015-04-18 05:09:39.629753	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
559	0	\N	2015-04-18 05:12:12.880355	2015-04-18 05:12:12.880355	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
560	0	\N	2015-04-18 05:12:17.744832	2015-04-18 05:12:17.744832	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
561	0	\N	2015-04-18 06:09:33.336381	2015-04-18 06:09:33.336381	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
562	0	\N	2015-04-18 06:10:31.207887	2015-04-18 06:10:31.207887	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
563	0	\N	2015-04-18 06:12:48.571791	2015-04-18 06:12:48.571791	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
564	0	\N	2015-04-19 01:45:52.212323	2015-04-19 01:45:52.212323	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
565	0	\N	2015-04-19 20:27:48.956671	2015-04-19 20:27:48.956671	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
566	0	\N	2015-04-20 06:01:11.801849	2015-04-20 06:01:11.801849	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
567	0	\N	2015-04-20 06:44:15.95566	2015-04-20 06:44:15.95566	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
568	0	\N	2015-04-20 10:42:14.814489	2015-04-20 10:42:14.814489	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
569	0	\N	2015-04-20 10:42:30.021251	2015-04-20 10:42:30.021251	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
570	0	\N	2015-04-20 10:42:39.607069	2015-04-20 10:42:39.607069	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
571	0	\N	2015-04-24 04:49:50.950286	2015-04-24 04:49:50.950286	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
572	0	\N	2015-04-24 13:34:16.305344	2015-04-24 13:34:16.305344	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
573	0	\N	2015-04-24 16:03:56.038164	2015-04-24 16:03:56.038164	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
574	0	\N	2015-04-24 21:23:25.349895	2015-04-24 21:23:25.349895	\N	\N	\N	\N	\N	GB	\N	\N	\N	\N	\N	\N
575	0	\N	2015-04-24 21:34:14.343108	2015-04-24 21:34:14.343108	\N	\N	\N	\N	\N	GB	\N	\N	\N	\N	\N	\N
576	0	\N	2015-04-24 21:34:21.8841	2015-04-24 21:34:21.8841	\N	\N	\N	\N	\N	GB	\N	\N	\N	\N	\N	\N
577	0	\N	2015-04-25 13:07:32.550415	2015-04-25 13:07:32.550415	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
578	0	\N	2015-04-25 14:06:29.905859	2015-04-25 14:06:29.905859	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
579	0	\N	2015-04-25 23:40:18.047476	2015-04-25 23:40:18.047476	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
580	0	\N	2015-04-26 13:49:08.139533	2015-04-26 13:49:08.139533	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
581	0	\N	2015-04-27 14:43:49.404008	2015-04-27 14:43:49.404008	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
582	0	\N	2015-04-27 14:46:23.770189	2015-04-27 14:46:23.770189	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
583	0	\N	2015-04-27 14:46:25.945508	2015-04-27 14:46:25.945508	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
584	0	\N	2015-04-28 09:09:27.174796	2015-04-28 09:09:27.174796	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
585	0	\N	2015-04-29 05:46:44.90533	2015-04-29 05:46:44.90533	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
586	0	\N	2015-04-29 19:55:04.910672	2015-04-29 19:55:04.910672	\N	\N	\N	\N	\N	CZ	\N	\N	\N	\N	\N	\N
587	0	\N	2015-04-30 05:56:38.779625	2015-04-30 05:56:38.779625	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
588	0	\N	2015-04-30 18:28:19.184757	2015-04-30 18:28:19.184757	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
589	0	\N	2015-05-04 23:22:50.843392	2015-05-04 23:22:50.843392	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
590	0	\N	2015-05-05 16:36:41.694554	2015-05-05 16:36:41.694554	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
591	0	\N	2015-05-05 16:36:41.907502	2015-05-05 16:36:41.907502	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
592	0	\N	2015-05-06 02:29:49.330743	2015-05-06 02:29:49.330743	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
593	0	\N	2015-05-06 02:30:06.681409	2015-05-06 02:30:06.681409	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
594	0	\N	2015-05-06 02:30:13.966984	2015-05-06 02:30:13.966984	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
595	0	\N	2015-05-06 18:08:35.919899	2015-05-06 18:08:35.919899	\N	\N	\N	\N	\N	RU	\N	\N	\N	\N	\N	\N
596	0	\N	2015-05-06 21:38:48.084568	2015-05-06 21:38:48.084568	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
597	0	\N	2015-05-07 08:51:44.457634	2015-05-07 08:51:44.457634	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
598	0	\N	2015-05-08 06:24:29.33368	2015-05-08 06:24:29.33368	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
599	0	\N	2015-05-08 20:50:42.009989	2015-05-08 20:50:42.009989	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
600	0	\N	2015-05-09 00:01:08.485282	2015-05-09 00:01:08.485282	\N	\N	\N	\N	\N	CN	\N	\N	\N	\N	\N	\N
601	0	\N	2015-05-09 21:49:57.890192	2015-05-09 21:49:57.890192	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
602	0	\N	2015-05-10 01:06:14.038238	2015-05-10 01:06:14.038238	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
603	0	\N	2015-05-11 06:48:26.573134	2015-05-11 06:48:26.573134	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
604	0	\N	2015-05-11 07:35:46.235008	2015-05-11 07:35:46.235008	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
605	0	\N	2015-05-11 07:35:55.98749	2015-05-11 07:35:55.98749	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
606	0	\N	2015-05-12 05:23:46.05115	2015-05-12 05:23:46.05115	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
607	0	\N	2015-05-12 07:40:27.726144	2015-05-12 07:40:27.726144	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
608	0	\N	2015-05-12 11:40:09.867284	2015-05-12 11:40:09.867284	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
609	0	\N	2015-05-12 15:52:25.321281	2015-05-12 15:52:25.321281	\N	\N	\N	\N	\N	DE	\N	\N	\N	\N	\N	\N
610	0	\N	2015-05-12 20:50:47.653646	2015-05-12 20:50:47.653646	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
611	0	\N	2015-05-13 17:29:18.864566	2015-05-13 17:29:18.864566	\N	\N	\N	\N	\N	NL	\N	\N	\N	\N	\N	\N
612	0	\N	2015-05-13 20:59:28.152441	2015-05-13 20:59:28.152441	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
613	0	\N	2015-05-15 00:19:20.350614	2015-05-15 00:19:20.350614	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
614	0	\N	2015-05-16 10:24:01.400984	2015-05-16 10:24:01.400984	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
615	0	\N	2015-05-16 18:11:50.377824	2015-05-16 18:11:50.377824	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
616	0	\N	2015-05-16 21:27:19.793512	2015-05-16 21:27:19.793512	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
617	0	\N	2015-05-17 23:55:55.497269	2015-05-17 23:55:55.497269	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
618	0	\N	2015-05-18 02:44:18.046514	2015-05-18 02:44:18.046514	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
619	0	\N	2015-05-18 05:03:42.292515	2015-05-18 05:03:42.292515	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
620	0	\N	2015-05-18 06:02:11.043649	2015-05-18 06:02:11.043649	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
621	0	\N	2015-05-18 07:05:59.96958	2015-05-18 07:05:59.96958	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
622	0	\N	2015-05-18 08:05:22.974652	2015-05-18 08:05:22.974652	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
623	0	\N	2015-05-18 09:12:25.259179	2015-05-18 09:12:25.259179	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
624	0	\N	2015-05-18 10:05:53.663967	2015-05-18 10:05:53.663967	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
625	0	\N	2015-05-18 11:01:32.023186	2015-05-18 11:01:32.023186	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
626	0	\N	2015-05-18 12:00:32.412693	2015-05-18 12:00:32.412693	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
627	0	\N	2015-05-18 12:56:32.0948	2015-05-18 12:56:32.0948	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
628	0	\N	2015-05-18 16:37:55.120509	2015-05-18 16:37:55.120509	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
629	0	\N	2015-05-18 21:24:50.28986	2015-05-18 21:24:50.28986	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
630	0	\N	2015-05-19 14:17:59.018901	2015-05-19 14:17:59.018901	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
631	0	\N	2015-05-20 08:12:19.439034	2015-05-20 08:12:19.439034	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
632	0	\N	2015-05-21 16:11:13.99299	2015-05-21 16:11:13.99299	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
633	0	\N	2015-05-21 16:11:32.295195	2015-05-21 16:11:32.295195	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
634	0	\N	2015-05-21 16:11:48.063675	2015-05-21 16:11:48.063675	\N	\N	\N	\N	\N	US	\N	\N	\N	\N	\N	\N
\.


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: scarfacedeb
--

SELECT pg_catalog.setval('orders_id_seq', 634, true);


--
-- Data for Name: page_translations; Type: TABLE DATA; Schema: public; Owner: scarfacedeb
--

COPY page_translations (id, page_id, locale, created_at, updated_at, title, body, "desc") FROM stdin;
4	2	ru	2014-03-11 12:11:33.47187	2014-10-27 15:31:36.787568	Контакты	<h3>\r\n<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d2163.0483499871593!2d65.509232!3d57.170421999999995!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x43bbe3c5ff4a419b%3A0x3b4bb55b69115028!2z0YPQuy4g0KHQsNC00L7QstCw0Y8sIDMsINCi0Y7QvNC10L3RjCwg0KLRjtC80LXQvdGB0LrQsNGPINC-0LHQu9Cw0YHRgtGM!5e0!3m2!1sru!2sru!4v1399210338747" width="600" height="450" frameborder="0" style="border-width: 0px;">\r\n</iframe></h3><h3>Часы работы</h3><p>\r\n\tПонедельник - Пятница 10.00 – 20.00<br>\r\n\tСуббота - Воскресенье 12.00 – 19.00</p><h3>Адрес</h3><p>\r\n\tХудожественный салон "Шедевр"&nbsp;<br>\r\n\tул. Садовая 3<br>\r\n\tТюмень<br>\r\n\tРоссия</p><h3>Контакты</h3><p>\r\n\tstore@nonpandoras.com <br>\r\n\t+ 7 922 073 58 19 <br>\r\n\t<a href="https://plus.google.com/+RoslyakovKonstantin">Google Plus</a></p>	store@nonpandoras.com  + 7 922 073 58 19  Художественный салон "Шедевр", ул. Садовая дом 3, город Тюмень
7	3	en	2014-05-04 13:00:16.542273	2014-10-28 18:21:01.88945	Making an enquiry	<p>\r\n\tEach and every piece of art is an original replica (copy) and as a result may contain slight variations from the examples displayed online.</p><p>\r\n\tUpon completion and submission of an order form you will get a mail with a description and cost<strong>*</strong> of the order.</p><p>\r\n\tBank details for money transfer, an estimated time and cost of delivery will be sent to you later by other mail.</p><p>\r\n\tProduction of the order begins after full payment.</p><p>\r\n\t<strong>Production time**:</strong></p><p>\r\n\t● Without decoration – 1-3 days;<br>\r\n\t● With decoration – 3-7 days;</p><p>\r\n\t<strong>*</strong>prices are here without cost of delivery<br>\r\n\t<strong>**</strong>without time of delivery</p><p><a href="http://nonpandoras.com/pages/shipping">Shipping and payment</a></p>	
9	3	cz	2014-05-25 14:09:42.895936	2014-10-28 18:21:01.896905	Making an enquiry	<p>Each and every piece of art is an original replica (copy) and as a result may contain slight variations from the examples displayed online.</p><p>Upon completion and submission of an order form you will get a mail with a description and cost<strong>*</strong> of the order.</p><p>Bank details for money transfer, an estimated time and cost of delivery will be sent to you later by other mail.</p><p>Production of the order begins after full payment.</p><p><strong>Production time**:</strong></p><p>● Without decoration – 1-3 days;<br>● With decoration – 3-7 days;</p><p><strong>*</strong>prices are here without cost of delivery<br><strong>**</strong>without time of delivery</p><p><a href="http://nonpandoras.com/cz/pages/shipping">Doprava a platda</a></p>	
3	1	ru	2014-03-11 11:56:33.78772	2015-05-13 20:59:19.38416	Обо мне	<p>\r\n\t<img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/81/81720034.JPG"><span style="font-size: 70%;">фото -&nbsp;</span><a href="https://vk.com/club43856521"><span style="font-size: 70%;">Анна Васькова</span></a></p><p>\r\n\tМеня зовут&nbsp;Константин Росляков. Я родился 4 апреля 1990 года в Тюмени (Россия), где живу по сей день. С одного года я начал рисовать и проявлять интерес к искусству. С шести лет — заниматься музыкой, что впоследствии обогатило и расширило мои интересы в творчестве. В 2013 году получил диплом по «Искусствознанию».</p><p>\r\n\tМоё сознание формировалось на окраине моего родного города, прилегающей к историческому и промышленному районам, в доме, где я живу и где располагается моя мастерская, из окна которой открывается вид на горизонт, насыщенный кустарниками и деревьями, пилонами и проводами, крышами домов и холмами. Именно эта атмосфера научила меня быть предельно внимательным к деталям и к незначительным с первого взгляда мелочам, и что не нужно ничего бояться в изображении, так как всё сложное состоит из простого, нужно только время, трудолюбие и упорство, хорошее настроение и предельное сосредоточение, чтобы изобразить то, что ты хочешь.</p><p>\r\n\t<img src="/uploads/redactor_assets/pictures/4/Fotografie0110.jpg" alt=""></p><p>\r\n\tОгромное впечатление на меня произвела радиостанция с вышками, которая находится недалеко от моего дома. Маленьким мальчиком я бегал туда, представлял себе, что с этого места, с помощью радиоволн, со всей планеты транслируются человеческие мысли, знания, идеи, чувства и человеческая память. Отсюда у меня и зародилась идея изображать персонажей, которые бы олицетворяли это всё, окруженные невидимыми волнами.</p><p>\r\n\t<img src="/uploads/redactor_assets/pictures/5/Fotografie0177.jpg" alt=""></p><p>\r\n\tМне нравится гулять по лесам и полям, проводить время у рек и озёр, ездить за город в сельскую местность, где я настраиваюсь на работу и где получаю истинное умиротворение.</p><p>\r\n\t<img src="/uploads/redactor_assets/pictures/6/Fotografie0286.jpg" alt=""></p><h3>Люди, которые меня вдохновляют:</h3><ul>\r\n\t\r\n<li>Гленн Гульд — <em>пианист</em></li>\t\r\n<li>Богуслав Мартину — <em>композитор</em></li>\t\r\n<li>Исаак ван Остаде — <em>живописец</em></li>\t\r\n<li>Александр Агрикола — <em>композитор</em></li>\t\r\n<li>Жорди Саваль — <em>музыкант</em></li>\t\r\n<li>Бела Тарр — <em>режиссёр</em></li>\t\r\n<li>Майкл Сэндисон и Маркус Эойн (Boards of Canada) — <em>музыканты</em></li>\t\r\n<li>Богумил Грабал — <em>писатель</em></li>\t\r\n<li>Симеон тен Хольт — <em>композитор</em></li>\t\r\n<li>Эмиль Золя&nbsp;— <em>писатель</em></li>\t\r\n<li>Ясудзиро Одзу — <em>режиссёр</em></li>\t\r\n<li>Скотт Морган (loscil) — <em>музыкант</em></li>\t\r\n<li>Жак Брель&nbsp;— <em>музыкант, актёр, режиссёр</em></li>\t\r\n<li>Гейр Йенссен (Biosphere)&nbsp;— <em>музыкант</em></li></ul>	Краткая информация об авторе с описанием концепции его произведений. Люди, которые меня вдохновляют. Nulla dies sine linea.\r\n
1	1	en	2014-03-10 16:30:25.925635	2015-05-13 20:59:19.38819	About	<p>\r\n\t<img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/82/81720034.JPG"><span style="font-size: 70%;">photo by&nbsp;</span><a href="https://vk.com/club43856521"><span style="font-size: 70%;">Anna Vaskova</span></a></p><p>\r\n\tMy name is&nbsp;Roslyakov Konstantin. I was born on April 4, 1990 in Tyumen, Russia where I still live to this day. From the age of one I began to draw pictures and show an interest in art. At six I started studying the balalaika (a traditional Russian string instrument) which helped me to broaden and enrich my creative interests. I graduated from university in 2013 with Bachelor's in Visual Art Studies.</p><p>\r\n\tMy artistic awareness developed in the house where I live and work, which sits on the outskirts of my hometown adjacent to the historic and industrial areas. The window of my studio overlooks a horizon rich with trees and bushes, pylons and cables, rooftops and hills. It was this atmosphere which helped me to become extremely attentive to seemingly trivial details in my surroundings even at first glance. I learned that there is nothing to fear in the image, since all that is complex consists of simpler parts. You know, even a sprawling beach is made of tiny grains of sand. With time and perseverance, hard work and diligence, a positive mood and extreme focus you can capture and portray whatever it is that you want to.</p><p>\r\n\t<img src="/uploads/redactor_assets/pictures/4/Fotografie0110.jpg" alt=""></p><p>\r\n\tOne element of my neighborhood which made a particularly lasting impression on me was THE PRESENCE of radio towers. As a boy I spent of lot of time there, imagining that from this place all human thought, knowledge, ideas, feelings and memories could be broadcasted across the planet with the help of radio waves. It was there that I first conceived the idea of portraying characters who personify all this surrounded by the invisible waves.</p><p>\r\n\t<img src="/uploads/redactor_assets/pictures/5/Fotografie0177.jpg" alt=""></p><p>\r\n\tI’m fond of walking in the woods and fields, and spending time at rivers and lakes. Anything to get outside of the town where I can set my heart to drawing and be totally tranquil with my thoughts.</p><p>\r\n\t<img src="/uploads/redactor_assets/pictures/6/Fotografie0286.jpg" alt=""></p><h3>People who inspired me:&nbsp;</h3><ul>\r\n\t\r\n<li>Glenn Gould - <em>pianist</em></li>\t\r\n<li>Bohuslav Martinu - <em>composer</em></li>\t\r\n<li>Isaac van Ostade - <em>painter</em></li>\t\r\n<li>Alexander Agricola - <em>composer</em></li>\t\r\n<li>Jordi Savall - <em>musician</em></li>\t\r\n<li>Bela Tarr - <em>director</em></li>\t\r\n<li>Michael Sandison and Marcus Eoin (Boards of Canada) - <em>musicians</em></li>\t\r\n<li>Bohumil Hrabal - <em>writer</em></li>\t\r\n<li>Simeon ten Holt - <em>composer</em></li>\t\r\n<li>Emile Zola -&nbsp;<em>writer</em></li>\t\r\n<li>Jacques Brel&nbsp;- <em>musician</em></li>\t\r\n<li>Skott Morgan (loscil)<em>&nbsp;</em>- <em style="font-size: 12px; -webkit-text-size-adjust: 100%;">musician</em></li>\t\r\n<li>Yasujiro Ozu - <em>director</em></li>\t\r\n<li>Geir Jenssen (Biosphere) -&nbsp;<em>musician</em></li></ul>	Short information about the author and the concept of his works. People who inspired me. Nulla dies sine linea.\r\n
11	4	ru	2014-10-25 20:48:34.747643	2014-11-13 15:00:23.929674	Оплата и доставка	<h3>Способы доставки</h3><h4>1. Доставка курьером</h4><ul>\r\n\t<li>Доставка осуществляется по всему миру через курьерскую службу Mail Boxes Etc;</li>\t<li>Стоимость и срок доставки расчитывается индивидуально и оплачивается курьеру при получении товара;</li>\t<li>После прибытия Вашего заказа в местное отделение связи, курьер свяжется с Вами,чтобы уточнить удобное для вас время получения заказа;</li>\t<li>Отследить статус отправления вы можете на сайте <a href="http://embe.mberussia.ru/invoice/track/">www.mailboxesetc.ru</a>.</li></ul><h4>2. Самовывоз</h4><p>\r\n\tСамостоятельно забрать свой заказ вы можете в художественном салон «Шедевр», по адресу: г.Тюмень, ул.Садовая, 3.</p><h3>Способы оплаты</h3><ul>\r\n\t<li>Электронным платежем PayPal;</li>\t<li>Банковским переводом;</li>\t<li>Наличными при самовывозе.</li></ul><h3>Условия возврата</h3><ul>\r\n\t<li>Вы вправе отменить заказ в любое время до его отправки либо вернуть его в течение 14 календарных дней после получения;</li>\t<li>Если Вы отказываетесь от товара, то мы возмещаем Вам сумму, эквивалентную полной стоимости товара за вычетом оплаты услуг курьера, в течение десяти календарных дней с момента получения нами письменного заявления от Вас;</li>\t<li>Денежные средства подлежат возврату тем же способом, который был использован Вами при оплате заказа;</li>\t<li>Отправка "возврата" осуществляется через службу доставки Mail Boxes Etc.</li></ul><h3>Прочие условия</h3><p>\r\n\tВ случае возникновения вопросов Вы можете обратиться к нам, позвонив по телефону или написав электронное письмо. Вы также можете посетить нас по указанному адресу. Всю контактную информацию смотрите в разделе&nbsp;<a href="http://nonpandoras.com/ru/pages/contact">Контакты</a>.</p>	Способы доставки и оплаты. Условия возврата. Прочие условия. 
8	3	ru	2014-05-12 05:32:45.559115	2014-10-29 12:01:18.88942	Информация о предзаказе	<p>Каждое произведение является оригинальным авторским повторением (копией), поэтому возможны незначительные отличия от представленных на сайте изображений.</p><p>После оформления заявки Вам будет выслано письмо с описанием и стоимостью<strong>*</strong> вашего заказа.</p><p>Отдельным письмом будут высланы реквизиты для оплаты и данные о сроках и стоимости доставки.</p><p>Изготовление заказа производится после полной предоплаты товара. </p><p><strong>Срок изготовления**:</strong></p><ul>\r\n<li>Без оформления - 1-3 дня;</li><li>С оформлением - 3-7 дней;</li></ul><p><strong><br></strong></p><p><strong>*</strong>цены указаны без учета стоимости доставки<br><strong>**</strong>без учета доставки</p><p><a href="http://nonpandoras.com/ru/pages/shipping">Оплата и доставка</a></p>	
5	1	cz	2014-03-11 16:30:05.800878	2015-05-13 20:59:19.392574	O mně	<p>\r\n\t<img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/82/81720034.JPG" alt=""><span style="font-size: 70%;">fotografie -&nbsp;</span><a href="https://vk.com/club43856521"><span style="font-size: 70%;">Anna Vaskova</span></a></p><p>\r\n\tJmenuji se Konstantin Roslyakov. Narodil jsem se 4. 4. 1990 v Ťumeňe (Rusko), kde žiji dodnes. Začal jsem kreslit a zájem o umění se u mne projevoval od raného dětství. V šesti letech jsem se rozhodl studovat hru na balalajku (tradiční ruský strunný nástroj), která mi pomohla rozšířit a obohatit své tvůrčí zájmy. V roce 2013 jsem získal titul v oboru dějiny umění.</p><p>\r\n\tMé vědomí bylo utvářeno na okraji mého rodného města, vedle historických a průmyslových center, v domě, kde žiji a kde se nachází i můj ateliér, s výhledem z okna na horizont bohatý stromy a keři, stožáry a kabely, střechy budov i kopce. Tato atmosféra mě naučila být velmi pozorným k detailu, a zkušenosti, že není třeba se bát ničeho v obraze, protože každý komplex se skládá z jednotlivostí, a je zapotřebí jen času, tvrdé práce a vytrvalosti, dobré nálady a koncentrace, aby člověk ztvárnil všechno, co chce.</p><p>\r\n\t<img src="/uploads/redactor_assets/pictures/4/Fotografie0110.jpg" alt=""></p><p>\r\n\tNa mě udělal obrovský dojem rádiový vysílač, který není daleko od mého domu. Když jsem byl malý kluk, představoval jsem si, že z tohoto místa se do celé planety vysílají lidské myšlenky, znalosti, nápady, pocity a lidská paměť za pomoci rádiových vln. Proto jsem dostal nápad zobrazovat postavy, které to všechno jakoby ztělesňují a jsou obklopené neviditelnými vlnami.</p><p>\r\n\t<img src="/uploads/redactor_assets/pictures/5/Fotografie0177.jpg" alt=""></p><p>\r\n\tMám rád procházky v lese a na poli, trávím svůj čas i na řekách a jezerech, kde jsem mohu otevřít své srdce kreslení a a mohu být v klidu sám se svými myšlenkami.</p><p>\r\n\t<img src="/uploads/redactor_assets/pictures/6/Fotografie0286.jpg" alt=""></p><h3>Lidé, kteří mě inspirují:</h3><ul>\r\n\t<li>Glenn Gould - <em>klavírista</em></li>\t<li>Bohuslav Martinů -&nbsp;<em>hudební skladatel</em></li>\t<li>Isaac van Ostade - <em>malíř</em></li>\t<li>Alexander Agricola -&nbsp;<em>hudební skladatel</em></li>\t<li>Jordi Savall - <em>hudebník</em></li>\t<li>Bela Tarr - <em>režisér</em></li>\t<li>Michael Sandison and Marcus Eoin (Boards of Canada) -&nbsp;<em>hudebníci</em></li>\t<li>Bohumil Hrabal - <em>spisovatel</em></li>\t<li>Simeon ten Holt -&nbsp;<em>hudební skladatel</em></li>\t<li>Emile Zola -&nbsp;<em>spisovatel</em></li>\t<li>Yasujiro Ozu - <em>režisér</em></li>\t<li>Jacques Brel -&nbsp;<em>hudebník</em></li>\t<li>Skott Morgan (loscil)&nbsp;- <em>hudebník</em></li>\t<li>Geir Jenssen (Biosphere) -&nbsp;<em>hudebník</em></li>\t<li><em><em>Émile Zol</em></em>a&nbsp;- <em>spisovatel</em></li></ul>	Krátká informace o autorovi a koncepce jeho umění. Lidé, kteří mě inspirujíi. Nulla umírá sine linea.
2	2	en	2014-03-10 16:31:04.301193	2014-10-27 15:31:36.789281	Contact	<h3><iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d2163.0483499871593!2d65.509232!3d57.170421999999995!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x43bbe3c5ff4a419b%3A0x3b4bb55b69115028!2z0YPQuy4g0KHQsNC00L7QstCw0Y8sIDMsINCi0Y7QvNC10L3RjCwg0KLRjtC80LXQvdGB0LrQsNGPINC-0LHQu9Cw0YHRgtGM!5e0!3m2!1sru!2sru!4v1399210338747" width="600" height="450" frameborder="0" style="border:0">\r\n</iframe></h3><h3>Opening hours</h3><p>\r\n\tMonday - Friday 10.00am – 8.00pm\r\n\t<br>\r\n\tSaturday - Sunday 12.00pm – 7.00pm</p><h3>Address</h3><p>\r\n\tArt Gallery "Masterpiece"&nbsp;\r\n\t<br>\r\n\t3 Sadovaya\r\n\t<br>\r\n\tTyumen\r\n\t<br>\r\n\tRussia</p><h3>Contact</h3><p>\r\n\tstore@nonpandoras.com\r\n\t<br>\r\n\t+ 7 922 073 58 19\r\n\t<br>\r\n\t<a href="https://plus.google.com/+RoslyakovKonstantin">Google Plus</a></p>	store@nonpandoras.com  + 7 922 073 58 19  Art Gallery "Masterpiece",  3 Sadovaya, Tyumen, Russia
6	2	cz	2014-03-11 16:32:20.222104	2014-10-27 15:31:36.790587	Kontakt	<h3>\r\n<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d2163.0483499871593!2d65.509232!3d57.170421999999995!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x43bbe3c5ff4a419b%3A0x3b4bb55b69115028!2z0YPQuy4g0KHQsNC00L7QstCw0Y8sIDMsINCi0Y7QvNC10L3RjCwg0KLRjtC80LXQvdGB0LrQsNGPINC-0LHQu9Cw0YHRgtGM!5e0!3m2!1sru!2sru!4v1399210338747" width="600" height="450" frameborder="0" style="border-width: 0px;">\r\n</iframe></h3><h3>Otevírací doba</h3><p>\r\n\tPondělí - Pátek 10.00 – 20.00<br>\r\n\tSobota - Neděle 12.00 – 19.00</p><h3>Adresa</h3><p>\r\n\tGalerie výtvarného umění "Masterpiece"&nbsp;<br>\r\n\tSadovaya 3<br>\r\n\tTyumen <br>\r\n\tRusko</p><h3>Kontact</h3><p>\r\n\tstore@nonpandoras.com <br>\r\n\t+ 7 922 073 58 19 <br>\r\n\t<a href="https://plus.google.com/+RoslyakovKonstantin">Google Plus</a></p>	store@nonpandoras.com  + 7 922 073 58 19  Galerie výtvarného umění "Masterpiece", Sadovaya 3, Tyumen, Rusko
12	4	cz	2014-10-25 20:48:34.750134	2014-11-13 15:00:23.95469	Doprava a platda	<h3>Shipping methods</h3>\r\n<h4>1. International delivery service Mail Boxes Etc.</h4>\r\n<ul>\r\n  <li>Cost and delivery time are calculated individually and a courier should take money as an order received;</li>\r\n  <li>A courier will contact you after your order arrived in a local office and confirm the most convenient time for delivery;</li>\r\n  <li>You can check your order status at <a href="http://www.mailboxesetc.ru">www.mailboxesetc.ru</a></li>\r\n</ul>\r\n\r\n<h4>2. Self-pickup</h4>\r\n\r\n<p>\r\n  You can pick up an order in art gallery “Masterpiece (Шедевр)”, located in 3 Sadovaya St., Tyumen, Russian Federation.\r\n</p>\r\n\r\n<h3>Payment methods</h3>\r\n<ul>\r\n  <li>PayPal;</li>\r\n  <li>bank transfer;</li>\r\n  <li>cash (available only if you chose self-pickup shipping method)</li>\r\n</ul>\r\n\r\n<h3>Return conditions</h3>\r\n<ul>\r\n  <li>You have a right to cancel an order  or return it in 14 days after receiving;</li>\r\n  <li>If you cancel your order, we will return you the full payment of the order, except cost of the courier in ten days after receiving a written application from you;</li>\r\n  <li>Money will be repayable by the method you’ve paid before;</li>\r\n  <li>Sending back "an order" should be done by delivery service Mail Boxes Etc.</li>\r\n</ul>\r\n\r\n<h3>Other conditions</h3>\r\n<p>\r\n  If you have any questions you can contact us by phone or mail. Also you can visit us at the address, noted before. All information how to contact with us look for in&nbsp;\r\n  <a href="http://nonpandoras.com/pages/contact">Contacts</a>.\r\n</p>	Shipping methods. Payment methods. Return conditions. Other conditions.
10	4	en	2014-10-25 20:48:34.740231	2014-11-13 15:00:23.945194	Shipping and payment	<h3>Shipping methods</h3><h4>1. International delivery service Mail Boxes Etc.</h4><ul>\r\n  \r\n<li>Cost and delivery time are calculated individually and a courier should take money as an order received;</li>  \r\n<li>A courier will contact you after your order arrived in a local office and confirm the most convenient time for delivery;</li>  \r\n<li>You can check your order status at <a href="http://www.mailboxesetc.ru">www.mailboxesetc.ru</a></li></ul><h4>2. Self-pickup</h4><p>\r\n  You can pick up an order in art gallery “Masterpiece (Шедевр)”, located in 3 Sadovaya St., Tyumen, Russian Federation.</p><h3>Payment methods</h3><ul>\r\n  \r\n<li>PayPal;</li>  \r\n<li>bank transfer;</li>  \r\n<li>cash (available only if you chose self-pickup shipping method)</li></ul><h3>Return conditions</h3><ul>\r\n  \r\n<li>You have a right to cancel an order  or return it in 14 days after receiving;</li>  \r\n<li>If you cancel your order, we will return you the full payment of the order, except cost of the courier in ten days after receiving a written application from you;</li>  \r\n<li>Money will be repayable by the method you’ve paid before;</li>  \r\n<li>Sending back "an order" should be done by delivery service Mail Boxes Etc.</li></ul><h3>Other conditions</h3><p>\r\n  If you have any questions you can contact us by phone or mail. Also you can visit us at the address, noted before. All information how to contact with us look for in&nbsp;\r\n  <a href="http://nonpandoras.com/pages/contact">Contacts</a>.</p>	Shipping methods. Payment methods. Return conditions. Other conditions.
\.


--
-- Name: page_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: scarfacedeb
--

SELECT pg_catalog.setval('page_translations_id_seq', 12, true);


--
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: scarfacedeb
--

COPY pages (id, slug, is_published, created_at, updated_at) FROM stdin;
2	contact	t	2014-03-10 16:31:04.298158	2014-03-10 16:31:04.298158
3	cart	t	2014-05-04 13:00:16.539102	2014-10-29 12:01:18.899944
1	about	t	2014-03-10 16:30:25.919571	2015-05-13 20:59:19.395897
4	shipping	t	2014-10-25 20:48:34.734528	2014-11-13 15:00:23.959183
\.


--
-- Name: pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: scarfacedeb
--

SELECT pg_catalog.setval('pages_id_seq', 4, true);


--
-- Data for Name: post_translations; Type: TABLE DATA; Schema: public; Owner: scarfacedeb
--

COPY post_translations (id, post_id, locale, created_at, updated_at, title, summary, body) FROM stdin;
39	16	en	2015-01-08 18:08:22.301829	2015-01-08 18:08:22.301829	Swells and Valleys #2		<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/79/0141.png"></p>
40	16	ru	2015-01-08 18:08:22.309853	2015-01-08 18:08:22.309853	Холмы и Долины #2		<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/79/0141.png"></p>
8	5	cz	2014-10-28 17:56:17.582568	2014-10-30 18:14:50.016346	Forty-two Views of 57°10'14.2"N 65°29'54.0"E		<h4>№1 Standard view </h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/21/01.png"></p><hr><h4>№2 Series</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/22/02.png"></p><hr><h4>№3 Clouds over tree</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/23/03.png"></p><hr><h4>№4 Inserted and fixed</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/24/04.png"></p><hr><h4>№5 Lightning rods</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/25/05.png"></p><hr><h4>№6 Good News</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/26/06.png"></p><hr><h4>№7</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/27/07.png"></p><hr><h4>№8 View from the home</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/28/08.png"></p><hr><h4>№9 Friendly sky</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/29/09.png" alt=""></p><hr><h4>№10 View from the East</h4><h4><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/30/10.png" style="font-size: 12px; color: rgb(51, 51, 51);">\r\n</h4><h4>№11 Motion</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/31/11.png"></p><hr><h4>№12 Rhombuses</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/32/12.png"></p><hr><h4>№13 View of the elevator</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/33/13.png"></p><hr><h4>№14</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/34/14.png"></p><hr><h4>№15 Pulling clouds</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/35/15.png"></p><hr><h4>№16 Kissel</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/36/16.png"></p><hr><h4>№17 The lost track of time</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/37/17.png" alt=""></p><hr><h4>№18 Voices are  everywhere</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/38/18.png" alt=""></p><hr><h4>№19 Forgotten memories</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/39/19.png"></p><hr><h4>№20 Different shadows</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/40/20.png"></p><hr><h4>№21 View of the sunset</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/41/21.png"></p><hr><h4>№22 Clouds of August </h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/42/22.png"></p><hr><h4>№23 View from the west side</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/43/23.png"></p><hr><h4>№24 View from inside</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/44/24.png"></p><hr><h4>№25 Couple</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/45/25.png"></p><hr><h4>№26 Pillar</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/46/26.png"></p><hr><h4>№27 View of the main building</h4><h4><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/47/27.png" style="font-size: 12px;"></h4><hr><h4>№28 View of the elevator from inside</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/48/28.png"></p><hr><h4>№29 Sounds</h4><h4><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/49/29.png" style="font-size: 12px;"></h4><hr><h4>№30 View of the floodplain</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/50/30.png"></p><hr><h4>№31 Forgotten idea</h4><h4><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/51/31.png" alt="" style="font-size: 12px; color: rgb(51, 51, 51);"></h4><hr><h4>№32 Our friend is a moonlight</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/52/32.png" style="color: rgb(0, 0, 0); font-weight: bold;"></p><hr><h4>№33 First snow</h4><h4><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/53/33.png" style="font-size: 12px;"></h4><hr><h4>№34 Visions</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/54/34.png" style="color: rgb(0, 0, 0); font-weight: bold;"></p><hr><h4>№35 Evening snow</h4><h4><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/55/35.png" style="font-size: 12px;"></h4><hr><h4>№36</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/56/36.png"></p><hr><h4>№37 We will not find the way home</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/57/37.png" style="color: rgb(0, 0, 0); font-weight: bold;"></p><hr><h4>№38 Under the hill</h4><h4><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/58/38.png" style="font-size: 12px;"></h4><hr><h4>№39 The sterile sky</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/59/39.png" style="color: rgb(0, 0, 0); font-weight: bold;"></p><hr><h4>№40</h4><h4><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/60/40.png" style="font-size: 12px; color: rgb(51, 51, 51);">\r\n</h4><h4>№41</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/61/41.png"></p><hr><h4>№42 Spring</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/62/42.png"></p>
13	7	ru	2014-11-01 15:03:44.616291	2014-11-01 15:03:44.616291	rtrs 		<iframe width="560" height="315" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://maps.google.com/maps?layer=c&amp;panoid=EugbPAJZTyUAAAQfCaDy2w&amp;ie=UTF8&amp;source=embed&amp;output=svembed&amp;cbp=13%2C13.652315557062309%2C%2C0%2C-23.361029361960547"></iframe><div><small><a href="https://www.google.com/maps/views/u/0/" style="color:#0000FF; text-align:left">Фототуры</a>: <a href="https://www.google.com/maps/views/u/0/view/109729790512329646949/gphoto/6076709021913029666" style="color:#0000FF; text-align:left">Тюмень, Тюменская область, Россия</a>, <a href="https://www.google.com/maps/views/u/0/profile/109729790512329646949" style="color:#0000FF; text-align:left">Roslyakov Konstantin</a></small></div>
14	7	cz	2014-11-01 15:03:44.622201	2014-11-01 15:03:44.622201	rtrs 		<iframe width="560" height="315" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://maps.google.com/maps?layer=c&amp;panoid=EugbPAJZTyUAAAQfCaDy2w&amp;ie=UTF8&amp;source=embed&amp;output=svembed&amp;cbp=13%2C13.652315557062309%2C%2C0%2C-23.361029361960547"></iframe><div><small><a href="https://www.google.com/maps/views/u/0/" style="color:#0000FF; text-align:left">Фототуры</a>: <a href="https://www.google.com/maps/views/u/0/view/109729790512329646949/gphoto/6076709021913029666" style="color:#0000FF; text-align:left">Тюмень, Тюменская область, Россия</a>, <a href="https://www.google.com/maps/views/u/0/profile/109729790512329646949" style="color:#0000FF; text-align:left">Roslyakov Konstantin</a></small></div>
33	14	en	2014-12-11 18:52:41.620609	2014-12-11 18:52:41.620609	Slice of life		<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/77/0139.png"></p>
34	14	ru	2014-12-11 18:52:41.641387	2014-12-11 18:52:41.641387	Ломтик жизни		<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/77/0139.png"></p>
35	14	cz	2014-12-11 18:52:41.647433	2014-12-11 18:52:41.647433	Slice of life		<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/77/0139.png"></p>
36	15	en	2014-12-22 18:55:03.564216	2014-12-22 18:55:03.564216	Untitled #33		<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/78/0140.png"></p>
37	15	ru	2014-12-22 18:55:03.57955	2014-12-22 18:55:03.57955	Без названия #33		<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/78/0140.png"></p>
38	15	cz	2014-12-22 18:55:03.584603	2014-12-22 18:55:03.584603	Bez názvu #33		<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/78/0140.png"></p>
30	13	en	2014-11-30 17:47:26.132955	2015-01-08 18:07:13.906882	Swells and Valleys #1		<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/76/0136.png"></p>
31	13	ru	2014-11-30 17:47:26.147136	2015-01-08 18:07:13.921753	Холмы и Долины #1		<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/76/0136.png"></p>
32	13	cz	2014-11-30 17:47:26.152012	2015-01-08 18:07:13.925758	Vrchy a údolí #1		<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/76/0136.png"></p>
41	16	cz	2015-01-08 18:08:22.316501	2015-01-08 18:08:22.316501	Vrchy a údolí #2		<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/79/0141.png"></p>
43	17	ru	2015-01-13 08:58:22.930901	2015-01-13 08:58:22.930901	Археологические рисунки	Мои старые археологические рисунки. Инвентарь городища Пламя Сибири 6. Тюмень. (2012)	<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/80/____2_________________________________6.jpg"></p>
44	17	cz	2015-01-13 08:58:22.935984	2015-01-13 08:58:22.935984	Archaeological Drawing	My old archaeological drawings. Settlement of Siberia Flame 6. Tyumen. (2012)	<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/80/____2_________________________________6.jpg"></p>
46	18	ru	2015-04-21 04:24:02.745688	2015-04-21 04:24:02.745688	Спокойствие и тревога		<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/83/0149.png" alt=""></p>
47	18	cz	2015-04-21 04:24:02.754514	2015-04-21 04:24:02.754514	Klid a úzkost		<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/83/0149.png" alt=""></p>
48	19	ru	2015-05-12 07:36:34.043331	2015-05-12 08:21:50.664887	Керамические шахматы "Эклога №1"		<p>Совместная работа с Анной Васьковой.&nbsp;<br><br>Работы Анны можно увидеть по ссылкам:<br><a href="https://vk.com/beadsanna">https://vk.com/beadsanna<br></a><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard">https://www.facebook.com/profile.php?id=1000046303...<br><br></a>Материал: глина, ангоб, глазурь, дерево, фетр, лен&nbsp;<br>Техника: ручная лепка, двойной обжиг, выжигание по дереву<br><br>По вопросам покупки свяжитесь с нами по электронной почте -&nbsp;<a href="http://nonpandoras@gmail.com/">nonpandoras@gmail.com</a></p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/96/12.jpg" alt=""></p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/84/1.jpg"></p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/85/2.jpg"></p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/86/3.jpg"></p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/87/4.jpg"></p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/88/5.jpg"></p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/89/6.jpg"></p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/90/7.jpg"></p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/92/8.jpg"></p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/93/9.jpg"></p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/94/10.jpg"></p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/95/11.jpg"></p><h3>Немного рабочего процесса</h3><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/97/20150417_131256_061.jpg"></p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/98/20150417_132057_133.jpg"></p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/99/20150417_132114_300.jpg"></p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/100/20150417_132153_948.jpg"></p>
10	6	ru	2014-10-29 09:26:58.732124	2014-10-29 09:26:58.732124	Спутник-1. Земля и Луна	Эксперименты с циркулем. ​	<p>Эксперименты с циркулем. </p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/63/1.png"></p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/64/2.png"></p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/65/3.png"></p>
11	6	cz	2014-10-29 09:26:58.736533	2014-10-29 09:26:58.736533	Sputnik-1. Země a Měsíc	​Experimenty s kružítkem.	<p>Experimenty s kružítkem.</p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/63/1.png"></p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/64/2.png"></p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/65/3.png"></p>
6	5	ru	2014-10-28 17:56:17.549783	2014-10-30 18:14:50.008695	Сорок два вида 57°10'14.2"N 65°29'54.0"E		<p>№1 Стандартный вид</p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/21/01.png"></p><hr><h4>№2 Ряд</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/22/02.png"></p><hr><h4>№3 Тучи над деревом</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/23/03.png"></p><hr><h4>№4 Поставлены и закреплены &nbsp;</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/24/04.png"></p><hr><h4>№5 Громоотводы&nbsp;</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/25/05.png"></p><hr><p>№6 Хорошие новости</p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/26/06.png"></p><hr>\r\n<h4>№7&nbsp;</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/27/07.png"></p><hr>\r\n<h4>№8 Вид со стороны дома</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/28/08.png"></p><hr>\r\n<h4>№9 Дружелюбное небо</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/29/09.png" alt=""></p><hr>\r\n<h4>№10 Вид с восточной стороны</h4><h4><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/30/10.png" style="font-size: 12px; color: rgb(51, 51, 51);"></h4><hr>\r\n<h4>№11 Движение</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/31/11.png"></p><hr>\r\n<h4>№12 Потерянная перспектива. Ромбы</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/32/12.png"></p><hr>\r\n<h4>№13 Вид на элеватор&nbsp;</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/33/13.png"></p><hr>\r\n<h4>№14</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/34/14.png"></p><hr>\r\n<h4>№15 Притягивая облака&nbsp;</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/35/15.png"></p><hr>\r\n<h4>№16 Кисель</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/36/16.png"></p><hr>\r\n<h4>№17 Потерянный счет времени&nbsp;</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/37/17.png" alt=""></p><hr>\r\n<h4>№18 Голоса повсюду</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/38/18.png" alt=""></p><hr>\r\n<h4>№19 Забытые хорошие воспоминания</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/39/19.png"></p><hr>\r\n<h4>№20 Разные тени</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/40/20.png"></p><hr>\r\n<h4>№21 Вид на закат</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/41/21.png"></p><hr>\r\n<h4>№22 Облака в середине августа&nbsp;</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/42/22.png"></p><hr><h4>№23 Вид с западной стороны</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/43/23.png"></p><hr><h4>№24 Вид изнутри</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/44/24.png"></p><hr><h4>№25 Пара</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/45/25.png"></p><hr><h4>№26 Опоры</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/46/26.png"></p><hr><h4>№27 Вид на главное строение</h4><h4><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/47/27.png" style="font-size: 12px;"></h4><hr><p>№28 Вид на элеватор изнутри</p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/48/28.png"></p><hr><h4>№29 Звуки</h4><h4><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/49/29.png" style="font-size: 12px;"></h4><hr><p>№30 Вид на пойму</p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/50/30.png"></p><hr><h4>№31 Забытая идея</h4><h4><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/51/31.png" alt="" style="font-size: 12px; color: rgb(51, 51, 51);"></h4><hr><p>№32 Наш друг - лунный свет</p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/52/32.png" style="color: rgb(0, 0, 0); font-weight: bold;"></p><hr><h4>№33 Первый снег</h4><h4><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/53/33.png" style="font-size: 12px;"></h4><hr><p>№34 Видения</p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/54/34.png" style="color: rgb(0, 0, 0); font-weight: bold;"></p><hr><h4>№35 Вечерний снег</h4><h4><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/55/35.png" style="font-size: 12px;"></h4><hr><p>№36&nbsp;</p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/56/36.png"></p><hr><p>№37 Мы никогда не найдём дорогу домой</p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/57/37.png" style="color: rgb(0, 0, 0); font-weight: bold;"></p><hr><h4>№38 Под холмом</h4><h4><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/58/38.png" style="font-size: 12px;"></h4><hr><p>№39 Стерильное небо</p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/59/39.png" style="color: rgb(0, 0, 0); font-weight: bold;"></p><hr><h4>№40</h4><h4><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/60/40.png" style="font-size: 12px; color: rgb(51, 51, 51);"></h4><hr><p>№41</p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/61/41.png"></p><hr><h4>№42 Весеннее небо</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/62/42.png"></p>
7	5	en	2014-10-28 17:56:17.576787	2014-10-30 18:14:50.020594	Forty-two Views of 57°10'14.2"N 65°29'54.0"E		<h4>№1 Standard view&nbsp;</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/21/01.png"></p><hr>\r\n<h4>№2 Series</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/22/02.png"></p><hr>\r\n<h4>№3 Clouds over tree</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/23/03.png"></p><hr>\r\n<h4>№4 Inserted and fixed</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/24/04.png"></p><hr>\r\n<h4>№5 Lightning rods</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/25/05.png"></p><hr>\r\n<h4>№6 Good News</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/26/06.png"></p><hr>\r\n<h4>№7</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/27/07.png"></p><hr>\r\n<h4>№8 View from the home</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/28/08.png"></p><hr>\r\n<h4>№9 Friendly sky</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/29/09.png" alt=""></p><hr>\r\n<h4>№10 View from the East</h4><h4><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/30/10.png" style="font-size: 12px; color: rgb(51, 51, 51);">\r\n<hr>\r\n</h4><h4>№11 Motion</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/31/11.png"></p><hr>\r\n<h4>№12 Rhombuses</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/32/12.png"></p><hr>\r\n<h4>№13 View of the elevator</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/33/13.png"></p><hr>\r\n<h4>№14</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/34/14.png"></p><hr>\r\n<h4>№15 Pulling clouds</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/35/15.png"></p><hr>\r\n<h4>№16 Kissel</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/36/16.png"></p><hr>\r\n<h4>№17 The lost track of time</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/37/17.png" alt=""></p><hr>\r\n<h4>№18 Voices are &nbsp;everywhere</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/38/18.png" alt=""></p><hr>\r\n<h4>№19 Forgotten memories</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/39/19.png"></p><hr>\r\n<h4>№20 Different shadows</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/40/20.png"></p><hr>\r\n<h4>№21 View of the sunset</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/41/21.png"></p><hr>\r\n<h4>№22 Clouds of August&nbsp;</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/42/22.png"></p><hr>\r\n<h4>№23 View from the west side</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/43/23.png"></p><hr>\r\n<h4>№24 View from inside</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/44/24.png"></p><hr>\r\n<h4>№25 Couple</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/45/25.png"></p><hr>\r\n<h4>№26 Pillar</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/46/26.png"></p><hr>\r\n<h4>№27 View of the main building</h4><h4><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/47/27.png" style="font-size: 12px;"></h4><hr>\r\n<h4>№28 View of the elevator from inside</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/48/28.png"></p><hr>\r\n<h4>№29 Sounds</h4><h4><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/49/29.png" style="font-size: 12px;"></h4><hr>\r\n<h4>№30 View of the floodplain</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/50/30.png"></p><hr>\r\n<h4>№31 Forgotten idea</h4><h4><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/51/31.png" alt="" style="font-size: 12px; color: rgb(51, 51, 51);"></h4><hr>\r\n<h4>№32 Our friend is a moonlight</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/52/32.png" style="color: rgb(0, 0, 0); font-weight: bold;"></p><hr>\r\n<h4>№33 First snow</h4><h4><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/53/33.png" style="font-size: 12px;"></h4><hr>\r\n<h4>№34 Visions</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/54/34.png" style="color: rgb(0, 0, 0); font-weight: bold;"></p><hr>\r\n<h4>№35 Evening snow</h4><h4><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/55/35.png" style="font-size: 12px;"></h4><hr>\r\n<h4>№36</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/56/36.png"></p><hr>\r\n<h4>№37 We will not find the way home</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/57/37.png" style="color: rgb(0, 0, 0); font-weight: bold;"></p><hr>\r\n<h4>№38 Under the hill</h4><h4><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/58/38.png" style="font-size: 12px;"></h4><hr>\r\n<h4>№39 The sterile sky</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/59/39.png" style="color: rgb(0, 0, 0); font-weight: bold;"></p><hr>\r\n<h4>№40</h4><h4><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/60/40.png" style="font-size: 12px; color: rgb(51, 51, 51);">\r\n<hr>\r\n</h4><h4>№41</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/61/41.png"></p><hr>\r\n<h4>№42 Spring</h4><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/62/42.png"></p>
9	6	en	2014-10-29 09:26:58.721179	2014-10-29 09:50:59.480888	Sputnik-1. Earth and Moon. 	Experiments with a drawing-compass.	<p>Experiments with a drawing-compass.</p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/63/1.png"></p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/64/2.png"></p><p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/65/3.png"></p>
12	7	en	2014-11-01 15:03:44.600425	2014-11-01 15:03:44.600425	rtrs 		<iframe width="560" height="315" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://maps.google.com/maps?layer=c&amp;panoid=EugbPAJZTyUAAAQfCaDy2w&amp;ie=UTF8&amp;source=embed&amp;output=svembed&amp;cbp=13%2C13.652315557062309%2C%2C0%2C-23.361029361960547"></iframe><div><small><a href="https://www.google.com/maps/views/u/0/" style="color:#0000FF; text-align:left">Фототуры</a>: <a href="https://www.google.com/maps/views/u/0/view/109729790512329646949/gphoto/6076709021913029666" style="color:#0000FF; text-align:left">Тюмень, Тюменская область, Россия</a>, <a href="https://www.google.com/maps/views/u/0/profile/109729790512329646949" style="color:#0000FF; text-align:left">Roslyakov Konstantin</a></small></div>
18	9	en	2014-11-09 16:08:18.151749	2014-11-09 16:08:18.151749	The Lost Starlight		<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/69/0132.png"></p>
19	9	cz	2014-11-09 16:08:18.166513	2014-11-09 16:08:18.166513	The Lost Starlight		<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/69/0132.png"></p>
21	10	en	2014-11-12 17:31:37.553826	2014-11-12 17:31:37.553826	We and the History (Сomet landing. Philae lander)	Very captivating moment! 	<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/70/0133.png"></p>
22	10	ru	2014-11-12 17:31:37.576871	2014-11-12 17:31:37.576871	Мы и История (Сomet landing. Philae lander​)	Очень завораживающий момент! 	<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/70/0133.png"></p>
23	10	cz	2014-11-12 17:31:37.583696	2014-11-12 17:31:37.583696	We and the History (Сomet landing. Philae lander)	Very captivating moment! 	<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/70/0133.png"></p>
20	9	ru	2014-11-09 16:08:18.17449	2014-11-12 19:04:11.381525	Потерянный звёздный свет		<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/69/0132.png" alt=""></p>
24	11	en	2014-11-17 21:08:58.430211	2014-11-17 21:08:58.430211	\\ / / / \\ / /		<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/74/0134.png"></p>
25	11	ru	2014-11-17 21:08:58.442316	2014-11-17 21:08:58.442316	\\ / / / \\ / /		<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/74/0134.png"></p>
26	11	cz	2014-11-17 21:08:58.446786	2014-11-17 21:08:58.446786	\\ / / / \\ / /		<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/74/0134.png"></p>
27	12	en	2014-11-27 09:01:08.754682	2014-11-27 09:01:08.754682	The Homesitter (Instead of a self-portrait)		<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/75/0135.png"></p>
28	12	ru	2014-11-27 09:01:08.773173	2014-11-27 09:01:08.773173	Домосед (Вместо автопортрета)		<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/75/0135.png"></p>
29	12	cz	2014-11-27 09:01:08.779868	2014-11-27 09:01:08.779868	The Homesitter (Instead of a self-portrait)		<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/75/0135.png"></p>
42	17	en	2015-01-13 08:58:22.902315	2015-01-13 08:58:22.902315	Archaeological Drawing	My old archaeological drawings. Settlement of Siberia Flame 6. Tyumen. (2012)	<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/80/____2_________________________________6.jpg"></p>
45	18	en	2015-04-21 04:24:02.729113	2015-04-21 04:24:02.729113	Serenity and anxiety		<p><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/83/0149.png"></p>
49	19	en	2015-05-12 07:59:14.122019	2015-05-12 17:56:15.892783	Ceramic chess "Eclogue #1"		<p>Collaboration with Anna Vaskova.</p><p>Anna's works:<br><a href="https://vk.com/beadsanna">https://vk.com/beadsanna<br></a><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard">https://www.facebook.com/profile.php?id=1000046303...<br><br></a>Material: clay, engobes, glaze, wood, felt, linen<br>Technique: hand modeling, double firing, pyrography<br><br>For purchases, please, contact us by e-mail -&nbsp;<a href="http://nonpandoras@gmail.com">nonpandoras@gmail.com</a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/96/12.jpg" alt=""></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/84/1.jpg"></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/85/2.jpg"></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/86/3.jpg"></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/87/4.jpg"></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/88/5.jpg"></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/89/6.jpg"></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/90/7.jpg"></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/92/8.jpg"></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/93/9.jpg"></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/94/10.jpg"></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/95/11.jpg"></a></p><h3>Working process</h3><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/97/20150417_131256_061.jpg"></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/98/20150417_132057_133.jpg"></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/99/20150417_132114_300.jpg"></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/100/20150417_132153_948.jpg"></a></p>
50	19	cz	2015-05-12 07:59:14.133712	2015-05-12 17:56:15.934303	Keramické šachy "Eclogue #1"		<p>Spolupráce s Annou Volkovou.</p><p>Anna's works:<br><a href="https://vk.com/beadsanna">https://vk.com/beadsanna<br></a><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard">https://www.facebook.com/profile.php?id=1000046303...<br><br></a></p><p>Materiál: hlína, engoby, glazury, dřevo, plst, prádlo<br>Technika: ruční modelování, dvojité spalování, pyrography<br><br>Prosím, pro nákupy kontaktujte nás e-mailem -&nbsp;<a href="http://nonpandoras@gmail.com/">nonpandoras@gmail.com</a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/96/12.jpg" alt=""></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/84/1.jpg"></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/85/2.jpg"></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/86/3.jpg"></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/87/4.jpg"></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/88/5.jpg"></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/89/6.jpg"></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/90/7.jpg"></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/92/8.jpg"></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/93/9.jpg"></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/94/10.jpg"></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/95/11.jpg"></a></p><h3>Working process</h3><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/97/20150417_131256_061.jpg"></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/98/20150417_132057_133.jpg"></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/99/20150417_132114_300.jpg"></a></p><p><a href="https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard"><img src="http://assets.nonpandoras.com/uploads/redactor_assets/pictures/100/20150417_132153_948.jpg"></a></p>
\.


--
-- Name: post_translations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: scarfacedeb
--

SELECT pg_catalog.setval('post_translations_id_seq', 50, true);


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: scarfacedeb
--

COPY posts (id, slug, image, published_at, is_published, is_homepage, inserted_at, updated_at, is_bordered, translations) FROM stdin;
16	mood-6	0141.png	2015-01-08	t	t	2015-01-08 18:08:22.297729	2015-01-08 18:08:22.320289	f	{"cz": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/79/0141.png\\"></p>", "title": "Vrchy a údolí #2", "summary": ""}, "en": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/79/0141.png\\"></p>", "title": "Swells and Valleys #2", "summary": ""}, "ru": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/79/0141.png\\"></p>", "title": "Холмы и Долины #2", "summary": ""}}
7	rtrs	IMG_3046.JPG	2014-11-01	t	t	2014-11-01 15:03:44.595209	2014-11-01 15:03:44.628365	t	{"cz": {"body": "<iframe width=\\"560\\" height=\\"315\\" frameborder=\\"0\\" scrolling=\\"no\\" marginheight=\\"0\\" marginwidth=\\"0\\" src=\\"https://maps.google.com/maps?layer=c&amp;panoid=EugbPAJZTyUAAAQfCaDy2w&amp;ie=UTF8&amp;source=embed&amp;output=svembed&amp;cbp=13%2C13.652315557062309%2C%2C0%2C-23.361029361960547\\"></iframe><div><small><a href=\\"https://www.google.com/maps/views/u/0/\\" style=\\"color:#0000FF; text-align:left\\">Фототуры</a>: <a href=\\"https://www.google.com/maps/views/u/0/view/109729790512329646949/gphoto/6076709021913029666\\" style=\\"color:#0000FF; text-align:left\\">Тюмень, Тюменская область, Россия</a>, <a href=\\"https://www.google.com/maps/views/u/0/profile/109729790512329646949\\" style=\\"color:#0000FF; text-align:left\\">Roslyakov Konstantin</a></small></div>", "title": "rtrs ", "summary": ""}, "en": {"body": "<iframe width=\\"560\\" height=\\"315\\" frameborder=\\"0\\" scrolling=\\"no\\" marginheight=\\"0\\" marginwidth=\\"0\\" src=\\"https://maps.google.com/maps?layer=c&amp;panoid=EugbPAJZTyUAAAQfCaDy2w&amp;ie=UTF8&amp;source=embed&amp;output=svembed&amp;cbp=13%2C13.652315557062309%2C%2C0%2C-23.361029361960547\\"></iframe><div><small><a href=\\"https://www.google.com/maps/views/u/0/\\" style=\\"color:#0000FF; text-align:left\\">Фототуры</a>: <a href=\\"https://www.google.com/maps/views/u/0/view/109729790512329646949/gphoto/6076709021913029666\\" style=\\"color:#0000FF; text-align:left\\">Тюмень, Тюменская область, Россия</a>, <a href=\\"https://www.google.com/maps/views/u/0/profile/109729790512329646949\\" style=\\"color:#0000FF; text-align:left\\">Roslyakov Konstantin</a></small></div>", "title": "rtrs ", "summary": ""}, "ru": {"body": "<iframe width=\\"560\\" height=\\"315\\" frameborder=\\"0\\" scrolling=\\"no\\" marginheight=\\"0\\" marginwidth=\\"0\\" src=\\"https://maps.google.com/maps?layer=c&amp;panoid=EugbPAJZTyUAAAQfCaDy2w&amp;ie=UTF8&amp;source=embed&amp;output=svembed&amp;cbp=13%2C13.652315557062309%2C%2C0%2C-23.361029361960547\\"></iframe><div><small><a href=\\"https://www.google.com/maps/views/u/0/\\" style=\\"color:#0000FF; text-align:left\\">Фототуры</a>: <a href=\\"https://www.google.com/maps/views/u/0/view/109729790512329646949/gphoto/6076709021913029666\\" style=\\"color:#0000FF; text-align:left\\">Тюмень, Тюменская область, Россия</a>, <a href=\\"https://www.google.com/maps/views/u/0/profile/109729790512329646949\\" style=\\"color:#0000FF; text-align:left\\">Roslyakov Konstantin</a></small></div>", "title": "rtrs ", "summary": ""}}
10	comet-landing	0133.png	2014-11-12	t	t	2014-11-12 17:31:37.546201	2014-11-13 14:36:00.256346	f	{"cz": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/70/0133.png\\"></p>", "title": "We and the History (Сomet landing. Philae lander)", "summary": "Very captivating moment! "}, "en": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/70/0133.png\\"></p>", "title": "We and the History (Сomet landing. Philae lander)", "summary": "Very captivating moment! "}, "ru": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/70/0133.png\\"></p>", "title": "Мы и История (Сomet landing. Philae lander​)", "summary": "Очень завораживающий момент! "}}
11	mood-2	0134.png	2014-11-17	t	t	2014-11-17 21:08:58.424992	2014-11-17 21:08:58.449552	f	{"cz": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/74/0134.png\\"></p>", "title": "\\\\ / / / \\\\ / /", "summary": ""}, "en": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/74/0134.png\\"></p>", "title": "\\\\ / / / \\\\ / /", "summary": ""}, "ru": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/74/0134.png\\"></p>", "title": "\\\\ / / / \\\\ / /", "summary": ""}}
14	mood-4	0139.png	2014-12-11	t	t	2014-12-11 18:52:41.615372	2014-12-11 18:52:41.651339	f	{"cz": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/77/0139.png\\"></p>", "title": "Slice of life", "summary": ""}, "en": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/77/0139.png\\"></p>", "title": "Slice of life", "summary": ""}, "ru": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/77/0139.png\\"></p>", "title": "Ломтик жизни", "summary": ""}}
15	mood-5	0140.png	2014-12-22	t	t	2014-12-22 18:55:03.559299	2014-12-22 18:55:53.472658	f	{"cz": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/78/0140.png\\"></p>", "title": "Bez názvu #33", "summary": ""}, "en": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/78/0140.png\\"></p>", "title": "Untitled #33", "summary": ""}, "ru": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/78/0140.png\\"></p>", "title": "Без названия #33", "summary": ""}}
13	swells-and-valleys-1	0136.png	2014-11-30	t	t	2014-11-30 17:47:26.129046	2015-01-08 18:07:13.928328	f	{"cz": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/76/0136.png\\"></p>", "title": "Vrchy a údolí #1", "summary": ""}, "en": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/76/0136.png\\"></p>", "title": "Swells and Valleys #1", "summary": ""}, "ru": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/76/0136.png\\"></p>", "title": "Холмы и Долины #1", "summary": ""}}
17	arh-drwng-1	____2_________________________________6.jpg	2015-01-13	t	t	2015-01-13 08:58:22.898541	2015-02-04 17:51:37.86013	t	{"cz": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/80/____2_________________________________6.jpg\\"></p>", "title": "Archaeological Drawing", "summary": "My old archaeological drawings. Settlement of Siberia Flame 6. Tyumen. (2012)"}, "en": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/80/____2_________________________________6.jpg\\"></p>", "title": "Archaeological Drawing", "summary": "My old archaeological drawings. Settlement of Siberia Flame 6. Tyumen. (2012)"}, "ru": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/80/____2_________________________________6.jpg\\"></p>", "title": "Археологические рисунки", "summary": "Мои старые археологические рисунки. Инвентарь городища Пламя Сибири 6. Тюмень. (2012)"}}
6	exp-1	3.png	2014-10-29	t	t	2014-10-29 09:26:58.716626	2014-10-29 09:50:59.486234	t	{"cz": {"body": "<p>Experimenty s kružítkem.</p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/63/1.png\\"></p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/64/2.png\\"></p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/65/3.png\\"></p>", "title": "Sputnik-1. Země a Měsíc", "summary": "​Experimenty s kružítkem."}, "en": {"body": "<p>Experiments with a drawing-compass.</p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/63/1.png\\"></p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/64/2.png\\"></p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/65/3.png\\"></p>", "title": "Sputnik-1. Earth and Moon. ", "summary": "Experiments with a drawing-compass."}, "ru": {"body": "<p>Эксперименты с циркулем. </p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/63/1.png\\"></p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/64/2.png\\"></p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/65/3.png\\"></p>", "title": "Спутник-1. Земля и Луна", "summary": "Эксперименты с циркулем. ​"}}
12	mood-3	0135.png	2014-11-27	t	t	2014-11-27 09:01:08.749584	2014-11-27 09:01:08.783756	f	{"cz": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/75/0135.png\\"></p>", "title": "The Homesitter (Instead of a self-portrait)", "summary": ""}, "en": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/75/0135.png\\"></p>", "title": "The Homesitter (Instead of a self-portrait)", "summary": ""}, "ru": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/75/0135.png\\"></p>", "title": "Домосед (Вместо автопортрета)", "summary": ""}}
5	forty-two-views	Forty-two_Views-of_coming_soon.gif	2014-10-28	t	t	2014-10-28 17:56:17.542797	2014-10-30 18:14:50.024313	t	{"cz": {"body": "<h4>№1 Standard view </h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/21/01.png\\"></p><hr><h4>№2 Series</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/22/02.png\\"></p><hr><h4>№3 Clouds over tree</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/23/03.png\\"></p><hr><h4>№4 Inserted and fixed</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/24/04.png\\"></p><hr><h4>№5 Lightning rods</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/25/05.png\\"></p><hr><h4>№6 Good News</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/26/06.png\\"></p><hr><h4>№7</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/27/07.png\\"></p><hr><h4>№8 View from the home</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/28/08.png\\"></p><hr><h4>№9 Friendly sky</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/29/09.png\\" alt=\\"\\"></p><hr><h4>№10 View from the East</h4><h4><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/30/10.png\\" style=\\"font-size: 12px; color: rgb(51, 51, 51);\\">\\r\\n</h4><h4>№11 Motion</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/31/11.png\\"></p><hr><h4>№12 Rhombuses</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/32/12.png\\"></p><hr><h4>№13 View of the elevator</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/33/13.png\\"></p><hr><h4>№14</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/34/14.png\\"></p><hr><h4>№15 Pulling clouds</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/35/15.png\\"></p><hr><h4>№16 Kissel</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/36/16.png\\"></p><hr><h4>№17 The lost track of time</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/37/17.png\\" alt=\\"\\"></p><hr><h4>№18 Voices are  everywhere</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/38/18.png\\" alt=\\"\\"></p><hr><h4>№19 Forgotten memories</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/39/19.png\\"></p><hr><h4>№20 Different shadows</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/40/20.png\\"></p><hr><h4>№21 View of the sunset</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/41/21.png\\"></p><hr><h4>№22 Clouds of August </h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/42/22.png\\"></p><hr><h4>№23 View from the west side</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/43/23.png\\"></p><hr><h4>№24 View from inside</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/44/24.png\\"></p><hr><h4>№25 Couple</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/45/25.png\\"></p><hr><h4>№26 Pillar</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/46/26.png\\"></p><hr><h4>№27 View of the main building</h4><h4><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/47/27.png\\" style=\\"font-size: 12px;\\"></h4><hr><h4>№28 View of the elevator from inside</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/48/28.png\\"></p><hr><h4>№29 Sounds</h4><h4><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/49/29.png\\" style=\\"font-size: 12px;\\"></h4><hr><h4>№30 View of the floodplain</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/50/30.png\\"></p><hr><h4>№31 Forgotten idea</h4><h4><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/51/31.png\\" alt=\\"\\" style=\\"font-size: 12px; color: rgb(51, 51, 51);\\"></h4><hr><h4>№32 Our friend is a moonlight</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/52/32.png\\" style=\\"color: rgb(0, 0, 0); font-weight: bold;\\"></p><hr><h4>№33 First snow</h4><h4><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/53/33.png\\" style=\\"font-size: 12px;\\"></h4><hr><h4>№34 Visions</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/54/34.png\\" style=\\"color: rgb(0, 0, 0); font-weight: bold;\\"></p><hr><h4>№35 Evening snow</h4><h4><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/55/35.png\\" style=\\"font-size: 12px;\\"></h4><hr><h4>№36</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/56/36.png\\"></p><hr><h4>№37 We will not find the way home</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/57/37.png\\" style=\\"color: rgb(0, 0, 0); font-weight: bold;\\"></p><hr><h4>№38 Under the hill</h4><h4><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/58/38.png\\" style=\\"font-size: 12px;\\"></h4><hr><h4>№39 The sterile sky</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/59/39.png\\" style=\\"color: rgb(0, 0, 0); font-weight: bold;\\"></p><hr><h4>№40</h4><h4><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/60/40.png\\" style=\\"font-size: 12px; color: rgb(51, 51, 51);\\">\\r\\n</h4><h4>№41</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/61/41.png\\"></p><hr><h4>№42 Spring</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/62/42.png\\"></p>", "title": "Forty-two Views of 57°10'14.2\\"N 65°29'54.0\\"E", "summary": ""}, "en": {"body": "<h4>№1 Standard view&nbsp;</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/21/01.png\\"></p><hr>\\r\\n<h4>№2 Series</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/22/02.png\\"></p><hr>\\r\\n<h4>№3 Clouds over tree</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/23/03.png\\"></p><hr>\\r\\n<h4>№4 Inserted and fixed</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/24/04.png\\"></p><hr>\\r\\n<h4>№5 Lightning rods</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/25/05.png\\"></p><hr>\\r\\n<h4>№6 Good News</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/26/06.png\\"></p><hr>\\r\\n<h4>№7</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/27/07.png\\"></p><hr>\\r\\n<h4>№8 View from the home</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/28/08.png\\"></p><hr>\\r\\n<h4>№9 Friendly sky</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/29/09.png\\" alt=\\"\\"></p><hr>\\r\\n<h4>№10 View from the East</h4><h4><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/30/10.png\\" style=\\"font-size: 12px; color: rgb(51, 51, 51);\\">\\r\\n<hr>\\r\\n</h4><h4>№11 Motion</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/31/11.png\\"></p><hr>\\r\\n<h4>№12 Rhombuses</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/32/12.png\\"></p><hr>\\r\\n<h4>№13 View of the elevator</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/33/13.png\\"></p><hr>\\r\\n<h4>№14</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/34/14.png\\"></p><hr>\\r\\n<h4>№15 Pulling clouds</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/35/15.png\\"></p><hr>\\r\\n<h4>№16 Kissel</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/36/16.png\\"></p><hr>\\r\\n<h4>№17 The lost track of time</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/37/17.png\\" alt=\\"\\"></p><hr>\\r\\n<h4>№18 Voices are &nbsp;everywhere</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/38/18.png\\" alt=\\"\\"></p><hr>\\r\\n<h4>№19 Forgotten memories</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/39/19.png\\"></p><hr>\\r\\n<h4>№20 Different shadows</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/40/20.png\\"></p><hr>\\r\\n<h4>№21 View of the sunset</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/41/21.png\\"></p><hr>\\r\\n<h4>№22 Clouds of August&nbsp;</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/42/22.png\\"></p><hr>\\r\\n<h4>№23 View from the west side</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/43/23.png\\"></p><hr>\\r\\n<h4>№24 View from inside</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/44/24.png\\"></p><hr>\\r\\n<h4>№25 Couple</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/45/25.png\\"></p><hr>\\r\\n<h4>№26 Pillar</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/46/26.png\\"></p><hr>\\r\\n<h4>№27 View of the main building</h4><h4><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/47/27.png\\" style=\\"font-size: 12px;\\"></h4><hr>\\r\\n<h4>№28 View of the elevator from inside</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/48/28.png\\"></p><hr>\\r\\n<h4>№29 Sounds</h4><h4><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/49/29.png\\" style=\\"font-size: 12px;\\"></h4><hr>\\r\\n<h4>№30 View of the floodplain</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/50/30.png\\"></p><hr>\\r\\n<h4>№31 Forgotten idea</h4><h4><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/51/31.png\\" alt=\\"\\" style=\\"font-size: 12px; color: rgb(51, 51, 51);\\"></h4><hr>\\r\\n<h4>№32 Our friend is a moonlight</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/52/32.png\\" style=\\"color: rgb(0, 0, 0); font-weight: bold;\\"></p><hr>\\r\\n<h4>№33 First snow</h4><h4><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/53/33.png\\" style=\\"font-size: 12px;\\"></h4><hr>\\r\\n<h4>№34 Visions</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/54/34.png\\" style=\\"color: rgb(0, 0, 0); font-weight: bold;\\"></p><hr>\\r\\n<h4>№35 Evening snow</h4><h4><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/55/35.png\\" style=\\"font-size: 12px;\\"></h4><hr>\\r\\n<h4>№36</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/56/36.png\\"></p><hr>\\r\\n<h4>№37 We will not find the way home</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/57/37.png\\" style=\\"color: rgb(0, 0, 0); font-weight: bold;\\"></p><hr>\\r\\n<h4>№38 Under the hill</h4><h4><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/58/38.png\\" style=\\"font-size: 12px;\\"></h4><hr>\\r\\n<h4>№39 The sterile sky</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/59/39.png\\" style=\\"color: rgb(0, 0, 0); font-weight: bold;\\"></p><hr>\\r\\n<h4>№40</h4><h4><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/60/40.png\\" style=\\"font-size: 12px; color: rgb(51, 51, 51);\\">\\r\\n<hr>\\r\\n</h4><h4>№41</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/61/41.png\\"></p><hr>\\r\\n<h4>№42 Spring</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/62/42.png\\"></p>", "title": "Forty-two Views of 57°10'14.2\\"N 65°29'54.0\\"E", "summary": ""}, "ru": {"body": "<p>№1 Стандартный вид</p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/21/01.png\\"></p><hr><h4>№2 Ряд</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/22/02.png\\"></p><hr><h4>№3 Тучи над деревом</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/23/03.png\\"></p><hr><h4>№4 Поставлены и закреплены &nbsp;</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/24/04.png\\"></p><hr><h4>№5 Громоотводы&nbsp;</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/25/05.png\\"></p><hr><p>№6 Хорошие новости</p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/26/06.png\\"></p><hr>\\r\\n<h4>№7&nbsp;</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/27/07.png\\"></p><hr>\\r\\n<h4>№8 Вид со стороны дома</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/28/08.png\\"></p><hr>\\r\\n<h4>№9 Дружелюбное небо</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/29/09.png\\" alt=\\"\\"></p><hr>\\r\\n<h4>№10 Вид с восточной стороны</h4><h4><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/30/10.png\\" style=\\"font-size: 12px; color: rgb(51, 51, 51);\\"></h4><hr>\\r\\n<h4>№11 Движение</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/31/11.png\\"></p><hr>\\r\\n<h4>№12 Потерянная перспектива. Ромбы</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/32/12.png\\"></p><hr>\\r\\n<h4>№13 Вид на элеватор&nbsp;</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/33/13.png\\"></p><hr>\\r\\n<h4>№14</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/34/14.png\\"></p><hr>\\r\\n<h4>№15 Притягивая облака&nbsp;</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/35/15.png\\"></p><hr>\\r\\n<h4>№16 Кисель</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/36/16.png\\"></p><hr>\\r\\n<h4>№17 Потерянный счет времени&nbsp;</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/37/17.png\\" alt=\\"\\"></p><hr>\\r\\n<h4>№18 Голоса повсюду</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/38/18.png\\" alt=\\"\\"></p><hr>\\r\\n<h4>№19 Забытые хорошие воспоминания</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/39/19.png\\"></p><hr>\\r\\n<h4>№20 Разные тени</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/40/20.png\\"></p><hr>\\r\\n<h4>№21 Вид на закат</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/41/21.png\\"></p><hr>\\r\\n<h4>№22 Облака в середине августа&nbsp;</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/42/22.png\\"></p><hr><h4>№23 Вид с западной стороны</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/43/23.png\\"></p><hr><h4>№24 Вид изнутри</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/44/24.png\\"></p><hr><h4>№25 Пара</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/45/25.png\\"></p><hr><h4>№26 Опоры</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/46/26.png\\"></p><hr><h4>№27 Вид на главное строение</h4><h4><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/47/27.png\\" style=\\"font-size: 12px;\\"></h4><hr><p>№28 Вид на элеватор изнутри</p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/48/28.png\\"></p><hr><h4>№29 Звуки</h4><h4><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/49/29.png\\" style=\\"font-size: 12px;\\"></h4><hr><p>№30 Вид на пойму</p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/50/30.png\\"></p><hr><h4>№31 Забытая идея</h4><h4><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/51/31.png\\" alt=\\"\\" style=\\"font-size: 12px; color: rgb(51, 51, 51);\\"></h4><hr><p>№32 Наш друг - лунный свет</p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/52/32.png\\" style=\\"color: rgb(0, 0, 0); font-weight: bold;\\"></p><hr><h4>№33 Первый снег</h4><h4><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/53/33.png\\" style=\\"font-size: 12px;\\"></h4><hr><p>№34 Видения</p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/54/34.png\\" style=\\"color: rgb(0, 0, 0); font-weight: bold;\\"></p><hr><h4>№35 Вечерний снег</h4><h4><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/55/35.png\\" style=\\"font-size: 12px;\\"></h4><hr><p>№36&nbsp;</p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/56/36.png\\"></p><hr><p>№37 Мы никогда не найдём дорогу домой</p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/57/37.png\\" style=\\"color: rgb(0, 0, 0); font-weight: bold;\\"></p><hr><h4>№38 Под холмом</h4><h4><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/58/38.png\\" style=\\"font-size: 12px;\\"></h4><hr><p>№39 Стерильное небо</p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/59/39.png\\" style=\\"color: rgb(0, 0, 0); font-weight: bold;\\"></p><hr><h4>№40</h4><h4><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/60/40.png\\" style=\\"font-size: 12px; color: rgb(51, 51, 51);\\"></h4><hr><p>№41</p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/61/41.png\\"></p><hr><h4>№42 Весеннее небо</h4><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/62/42.png\\"></p>", "title": "Сорок два вида 57°10'14.2\\"N 65°29'54.0\\"E", "summary": ""}}
18	mood-7	0149.png	2015-04-21	t	t	2015-04-21 04:24:02.72064	2015-04-21 04:24:02.759459	f	{"cz": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/83/0149.png\\" alt=\\"\\"></p>", "title": "Klid a úzkost", "summary": ""}, "en": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/83/0149.png\\"></p>", "title": "Serenity and anxiety", "summary": ""}, "ru": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/83/0149.png\\" alt=\\"\\"></p>", "title": "Спокойствие и тревога", "summary": ""}}
9	the-lost-starlight	0132.png	2014-11-09	t	t	2014-11-09 16:08:18.146379	2014-11-13 14:36:18.657251	f	{"cz": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/69/0132.png\\"></p>", "title": "The Lost Starlight", "summary": ""}, "en": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/69/0132.png\\"></p>", "title": "The Lost Starlight", "summary": ""}, "ru": {"body": "<p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/69/0132.png\\" alt=\\"\\"></p>", "title": "Потерянный звёздный свет", "summary": ""}}
19	ceramics-chess	20150417_132153_948.jpg	2015-05-12	t	t	2015-05-12 07:36:34.038942	2015-05-12 17:56:15.938757	t	{"cz": {"body": "<p>Spolupráce s Annou Volkovou.</p><p>Anna's works:<br><a href=\\"https://vk.com/beadsanna\\">https://vk.com/beadsanna<br></a><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\">https://www.facebook.com/profile.php?id=1000046303...<br><br></a></p><p>Materiál: hlína, engoby, glazury, dřevo, plst, prádlo<br>Technika: ruční modelování, dvojité spalování, pyrography<br><br>Prosím, pro nákupy kontaktujte nás e-mailem -&nbsp;<a href=\\"http://nonpandoras@gmail.com/\\">nonpandoras@gmail.com</a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/96/12.jpg\\" alt=\\"\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/84/1.jpg\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/85/2.jpg\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/86/3.jpg\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/87/4.jpg\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/88/5.jpg\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/89/6.jpg\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/90/7.jpg\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/92/8.jpg\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/93/9.jpg\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/94/10.jpg\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/95/11.jpg\\"></a></p><h3>Working process</h3><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/97/20150417_131256_061.jpg\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/98/20150417_132057_133.jpg\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/99/20150417_132114_300.jpg\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/100/20150417_132153_948.jpg\\"></a></p>", "title": "Keramické šachy \\"Eclogue #1\\"", "summary": ""}, "en": {"body": "<p>Collaboration with Anna Vaskova.</p><p>Anna's works:<br><a href=\\"https://vk.com/beadsanna\\">https://vk.com/beadsanna<br></a><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\">https://www.facebook.com/profile.php?id=1000046303...<br><br></a>Material: clay, engobes, glaze, wood, felt, linen<br>Technique: hand modeling, double firing, pyrography<br><br>For purchases, please, contact us by e-mail -&nbsp;<a href=\\"http://nonpandoras@gmail.com\\">nonpandoras@gmail.com</a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/96/12.jpg\\" alt=\\"\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/84/1.jpg\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/85/2.jpg\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/86/3.jpg\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/87/4.jpg\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/88/5.jpg\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/89/6.jpg\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/90/7.jpg\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/92/8.jpg\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/93/9.jpg\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/94/10.jpg\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/95/11.jpg\\"></a></p><h3>Working process</h3><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/97/20150417_131256_061.jpg\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/98/20150417_132057_133.jpg\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/99/20150417_132114_300.jpg\\"></a></p><p><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\"><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/100/20150417_132153_948.jpg\\"></a></p>", "title": "Ceramic chess \\"Eclogue #1\\"", "summary": ""}, "ru": {"body": "<p>Совместная работа с Анной Васьковой.&nbsp;<br><br>Работы Анны можно увидеть по ссылкам:<br><a href=\\"https://vk.com/beadsanna\\">https://vk.com/beadsanna<br></a><a href=\\"https://www.facebook.com/profile.php?id=100004630394147&fref=hovercard\\">https://www.facebook.com/profile.php?id=1000046303...<br><br></a>Материал: глина, ангоб, глазурь, дерево, фетр, лен&nbsp;<br>Техника: ручная лепка, двойной обжиг, выжигание по дереву<br><br>По вопросам покупки свяжитесь с нами по электронной почте -&nbsp;<a href=\\"http://nonpandoras@gmail.com/\\">nonpandoras@gmail.com</a></p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/96/12.jpg\\" alt=\\"\\"></p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/84/1.jpg\\"></p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/85/2.jpg\\"></p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/86/3.jpg\\"></p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/87/4.jpg\\"></p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/88/5.jpg\\"></p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/89/6.jpg\\"></p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/90/7.jpg\\"></p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/92/8.jpg\\"></p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/93/9.jpg\\"></p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/94/10.jpg\\"></p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/95/11.jpg\\"></p><h3>Немного рабочего процесса</h3><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/97/20150417_131256_061.jpg\\"></p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/98/20150417_132057_133.jpg\\"></p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/99/20150417_132114_300.jpg\\"></p><p><img src=\\"http://assets.nonpandoras.com/uploads/redactor_assets/pictures/100/20150417_132153_948.jpg\\"></p>", "title": "Керамические шахматы \\"Эклога №1\\"", "summary": ""}}
\.


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: scarfacedeb
--

SELECT pg_catalog.setval('posts_id_seq', 19, true);


--
-- Data for Name: rails_admin_histories; Type: TABLE DATA; Schema: public; Owner: scarfacedeb
--

COPY rails_admin_histories (id, message, username, item, "table", month, year, created_at, updated_at) FROM stdin;
\.


--
-- Name: rails_admin_histories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: scarfacedeb
--

SELECT pg_catalog.setval('rails_admin_histories_id_seq', 1, false);


--
-- Data for Name: redactor_assets; Type: TABLE DATA; Schema: public; Owner: scarfacedeb
--

COPY redactor_assets (id, data_file_name, data_content_type, data_file_size, assetable_id, assetable_type, type, width, height, created_at, updated_at) FROM stdin;
1	DSC00234.JPG	image/jpeg	1596579	\N	\N	RedactorRails::Picture	1500	1295	2014-04-28 11:26:28.301134	2014-04-28 11:26:28.301134
2	DSC00234.JPG	image/jpeg	1596579	\N	\N	RedactorRails::Picture	1500	1295	2014-04-28 11:27:42.205634	2014-04-28 11:27:42.205634
3	DSC00234.JPG	image/jpeg	1596579	\N	\N	RedactorRails::Picture	1500	1295	2014-04-28 11:30:15.043702	2014-04-28 11:30:15.043702
4	Fotografie0110.jpg	image/jpeg	387624	\N	\N	RedactorRails::Picture	1280	960	2014-04-28 11:30:34.796569	2014-04-28 11:30:34.796569
5	Fotografie0177.jpg	image/jpeg	336005	\N	\N	RedactorRails::Picture	1280	960	2014-04-28 11:31:00.453039	2014-04-28 11:31:00.453039
6	Fotografie0286.jpg	image/jpeg	468745	\N	\N	RedactorRails::Picture	1280	960	2014-04-28 11:31:40.162651	2014-04-28 11:31:40.162651
7	DSC00234.JPG	image/jpeg	1596579	\N	\N	RedactorRails::Picture	1500	1295	2014-04-28 11:32:48.698784	2014-04-28 11:32:48.698784
8	be8d28d1-efe0-470f-a1d4-65766fb0e72a.jpg	image/jpeg	154398	\N	\N	RedactorRails::Picture	640	640	2014-04-28 12:07:44.562263	2014-04-28 12:07:44.562263
9	paypal-logo.jpg	image/jpeg	18934	\N	\N	RedactorRails::Picture	828	305	2014-05-26 16:47:03.763457	2014-05-26 16:47:03.763457
10	paypal-logo.jpg	image/jpeg	84007	\N	\N	RedactorRails::Picture	725	200	2014-05-29 18:18:41.786199	2014-05-29 18:18:41.786199
11	Credit-Card-Logos-1.gif	image/gif	758118	\N	\N	RedactorRails::Picture	5616	880	2014-05-29 18:26:46.611777	2014-05-29 18:26:46.611777
12	DeliverFile.jpg	image/jpeg	140935	\N	\N	RedactorRails::Picture	600	400	2014-06-03 17:38:20.153793	2014-06-03 17:38:20.153793
13	IMG_0334.png	image/png	9284122	\N	\N	RedactorRails::Picture	2345	2291	2014-06-05 13:31:39.64106	2014-06-05 13:31:39.64106
14	photo.jpg	image/jpeg	4341633	\N	\N	RedactorRails::Picture	2345	2291	2014-06-23 07:59:14.956481	2014-06-23 07:59:14.956481
15	IMG_3054.JPG	image/jpeg	1097680	\N	\N	RedactorRails::Picture	1280	960	2014-08-14 09:15:38.531008	2014-08-14 09:15:38.531008
16	Image-1.jpg	image/jpeg	171939	\N	\N	RedactorRails::Picture	768	1024	2014-09-21 12:52:29.896503	2014-09-21 12:52:29.896503
17	____.JPG	image/jpeg	328970	\N	\N	RedactorRails::Picture	960	852	2014-09-21 13:00:49.435039	2014-09-21 13:00:49.435039
18	01.png	image/png	12934545	\N	\N	RedactorRails::Picture	4582	3503	2014-10-28 14:22:16.50864	2014-10-28 14:22:16.50864
19	02.png	image/png	11675644	\N	\N	RedactorRails::Picture	4602	3496	2014-10-28 14:29:52.797456	2014-10-28 14:29:52.797456
20	03.png	image/png	14951999	\N	\N	RedactorRails::Picture	4629	3487	2014-10-28 14:34:52.433522	2014-10-28 14:34:52.433522
21	01.png	image/png	1182262	\N	\N	RedactorRails::Picture	1366	1044	2014-10-28 14:57:45.075409	2014-10-28 14:57:45.075409
22	02.png	image/png	1062760	\N	\N	RedactorRails::Picture	1366	1038	2014-10-28 14:58:09.121186	2014-10-28 14:58:09.121186
23	03.png	image/png	1327231	\N	\N	RedactorRails::Picture	1366	1029	2014-10-28 14:58:34.339048	2014-10-28 14:58:34.339048
24	04.png	image/png	1308339	\N	\N	RedactorRails::Picture	1366	1048	2014-10-28 14:58:58.141289	2014-10-28 14:58:58.141289
25	05.png	image/png	1337578	\N	\N	RedactorRails::Picture	1366	1051	2014-10-28 14:59:26.396947	2014-10-28 14:59:26.396947
26	06.png	image/png	3444779	\N	\N	RedactorRails::Picture	1366	1049	2014-10-28 15:00:20.751437	2014-10-28 15:00:20.751437
27	07.png	image/png	1308199	\N	\N	RedactorRails::Picture	1366	1042	2014-10-28 15:00:51.018828	2014-10-28 15:00:51.018828
28	08.png	image/png	2014710	\N	\N	RedactorRails::Picture	1300	1696	2014-10-28 15:02:12.945253	2014-10-28 15:02:12.945253
29	09.png	image/png	1356081	\N	\N	RedactorRails::Picture	1366	1048	2014-10-28 15:03:24.931494	2014-10-28 15:03:24.931494
30	10.png	image/png	602761	\N	\N	RedactorRails::Picture	1366	1061	2014-10-28 15:03:37.392734	2014-10-28 15:03:37.392734
31	11.png	image/png	1170113	\N	\N	RedactorRails::Picture	1366	1049	2014-10-28 15:05:00.582376	2014-10-28 15:05:00.582376
32	12.png	image/png	1753869	\N	\N	RedactorRails::Picture	1300	1712	2014-10-28 15:06:04.050367	2014-10-28 15:06:04.050367
33	13.png	image/png	1291967	\N	\N	RedactorRails::Picture	1366	1047	2014-10-28 15:06:40.782089	2014-10-28 15:06:40.782089
34	14.png	image/png	1299276	\N	\N	RedactorRails::Picture	1366	1044	2014-10-28 15:13:12.071259	2014-10-28 15:13:12.071259
35	15.png	image/png	1983067	\N	\N	RedactorRails::Picture	1300	1680	2014-10-28 15:13:54.988411	2014-10-28 15:13:54.988411
36	16.png	image/png	1133688	\N	\N	RedactorRails::Picture	1366	1059	2014-10-28 15:16:17.568623	2014-10-28 15:16:17.568623
37	17.png	image/png	1118806	\N	\N	RedactorRails::Picture	1366	1043	2014-10-28 15:17:02.060211	2014-10-28 15:17:02.060211
38	18.png	image/png	1581078	\N	\N	RedactorRails::Picture	1300	1715	2014-10-28 15:17:24.361663	2014-10-28 15:17:24.361663
39	19.png	image/png	1165202	\N	\N	RedactorRails::Picture	1366	1050	2014-10-28 15:19:29.458623	2014-10-28 15:19:29.458623
40	20.png	image/png	1791110	\N	\N	RedactorRails::Picture	1300	1695	2014-10-28 15:21:00.806873	2014-10-28 15:21:00.806873
41	21.png	image/png	3978751	\N	\N	RedactorRails::Picture	1366	1042	2014-10-28 15:22:31.071298	2014-10-28 15:22:31.071298
42	22.png	image/png	1262176	\N	\N	RedactorRails::Picture	1366	1056	2014-10-28 15:29:02.379271	2014-10-28 15:29:02.379271
43	23.png	image/png	2010477	\N	\N	RedactorRails::Picture	1300	1704	2014-10-28 15:31:36.118437	2014-10-28 15:31:36.118437
44	24.png	image/png	1339409	\N	\N	RedactorRails::Picture	1366	1048	2014-10-28 15:32:35.773786	2014-10-28 15:32:35.773786
45	25.png	image/png	1253448	\N	\N	RedactorRails::Picture	1366	1054	2014-10-28 15:33:52.150012	2014-10-28 15:33:52.150012
46	26.png	image/png	1888573	\N	\N	RedactorRails::Picture	1300	1709	2014-10-28 15:34:41.72396	2014-10-28 15:34:41.72396
47	27.png	image/png	1287214	\N	\N	RedactorRails::Picture	1366	1045	2014-10-28 15:40:42.413285	2014-10-28 15:40:42.413285
48	28.png	image/png	1267481	\N	\N	RedactorRails::Picture	1366	1050	2014-10-28 15:45:05.806445	2014-10-28 15:45:05.806445
49	29.png	image/png	1900097	\N	\N	RedactorRails::Picture	1300	1711	2014-10-28 15:46:22.342469	2014-10-28 15:46:22.342469
50	30.png	image/png	1272104	\N	\N	RedactorRails::Picture	1366	1053	2014-10-28 16:01:59.808942	2014-10-28 16:01:59.808942
51	31.png	image/png	2011781	\N	\N	RedactorRails::Picture	1300	1718	2014-10-28 16:09:05.654486	2014-10-28 16:09:05.654486
52	32.png	image/png	1738967	\N	\N	RedactorRails::Picture	1300	1695	2014-10-28 16:11:17.128495	2014-10-28 16:11:17.128495
53	33.png	image/png	1745010	\N	\N	RedactorRails::Picture	1300	1701	2014-10-28 16:14:05.477766	2014-10-28 16:14:05.477766
54	34.png	image/png	2013975	\N	\N	RedactorRails::Picture	1300	1722	2014-10-28 16:15:13.683268	2014-10-28 16:15:13.683268
55	35.png	image/png	408530	\N	\N	RedactorRails::Picture	1366	1044	2014-10-28 16:15:59.817827	2014-10-28 16:15:59.817827
56	36.png	image/png	1953690	\N	\N	RedactorRails::Picture	1300	1713	2014-10-28 16:17:11.820181	2014-10-28 16:17:11.820181
57	37.png	image/png	1270817	\N	\N	RedactorRails::Picture	1366	1045	2014-10-28 16:18:51.6296	2014-10-28 16:18:51.6296
58	38.png	image/png	1768922	\N	\N	RedactorRails::Picture	1300	1704	2014-10-28 16:24:13.604347	2014-10-28 16:24:13.604347
59	39.png	image/png	1226738	\N	\N	RedactorRails::Picture	1366	1044	2014-10-28 16:25:36.752975	2014-10-28 16:25:36.752975
60	40.png	image/png	1965563	\N	\N	RedactorRails::Picture	1300	1703	2014-10-28 16:26:40.093018	2014-10-28 16:26:40.093018
61	41.png	image/png	1005125	\N	\N	RedactorRails::Picture	1366	1046	2014-10-28 16:27:58.869121	2014-10-28 16:27:58.869121
62	42.png	image/png	3353950	\N	\N	RedactorRails::Picture	1366	1045	2014-10-28 16:29:01.489142	2014-10-28 16:29:01.489142
63	1.png	image/png	2013002	\N	\N	RedactorRails::Picture	1655	1605	2014-10-29 09:17:43.564067	2014-10-29 09:17:43.564067
64	2.png	image/png	2512825	\N	\N	RedactorRails::Picture	1818	1560	2014-10-29 09:18:21.01122	2014-10-29 09:18:21.01122
65	3.png	image/png	2866726	\N	\N	RedactorRails::Picture	1824	1937	2014-10-29 09:19:26.758681	2014-10-29 09:19:26.758681
66	20140929_144257_084.jpg	image/jpeg	146862	\N	\N	RedactorRails::Picture	960	960	2014-10-29 12:07:14.679202	2014-10-29 12:07:14.679202
67	20140929_144257_084.jpg	image/jpeg	235008	\N	\N	RedactorRails::Picture	960	960	2014-10-29 12:09:41.052839	2014-10-29 12:09:41.052839
68	20140929_144257_084.jpg	image/jpeg	240162	\N	\N	RedactorRails::Picture	960	960	2014-10-29 12:11:51.239265	2014-10-29 12:11:51.239265
69	0132.png	image/png	6469084	\N	\N	RedactorRails::Picture	3292	3263	2014-11-09 16:03:41.68093	2014-11-09 16:03:41.68093
70	0133.png	image/png	2302338	\N	\N	RedactorRails::Picture	3576	3559	2014-11-12 17:25:04.610248	2014-11-12 17:25:04.610248
71	0132.png	image/png	1894472	\N	\N	RedactorRails::Picture	1600	1586	2014-11-12 18:45:25.35269	2014-11-12 18:45:25.35269
72	0132.png	image/png	1894472	\N	\N	RedactorRails::Picture	1600	1586	2014-11-12 18:55:14.838157	2014-11-12 18:55:14.838157
73	0134.png	image/png	7991302	\N	\N	RedactorRails::Picture	4110	4304	2014-11-17 21:05:33.600637	2014-11-17 21:05:33.600637
74	0134.png	image/png	2211854	\N	\N	RedactorRails::Picture	2000	2094	2014-11-17 21:06:56.232973	2014-11-17 21:06:56.232973
75	0135.png	image/png	1629778	\N	\N	RedactorRails::Picture	1600	1559	2014-11-27 08:52:04.412041	2014-11-27 08:52:04.412041
76	0136.png	image/png	1549468	\N	\N	RedactorRails::Picture	1600	1504	2014-11-30 17:43:04.165521	2014-11-30 17:43:04.165521
77	0139.png	image/png	1299435	\N	\N	RedactorRails::Picture	1600	1596	2014-12-11 18:46:36.424947	2014-12-11 18:46:36.424947
78	0140.png	image/png	1460164	\N	\N	RedactorRails::Picture	1600	1521	2014-12-22 18:43:42.581024	2014-12-22 18:43:42.581024
79	0141.png	image/png	2099968	\N	\N	RedactorRails::Picture	1600	1609	2015-01-08 18:04:05.597057	2015-01-08 18:04:05.597057
80	____2_________________________________6.jpg	image/jpeg	1487817	\N	\N	RedactorRails::Picture	1856	2392	2015-01-13 08:56:36.987788	2015-01-13 08:56:36.987788
81	81720034.JPG	image/jpeg	632339	\N	\N	RedactorRails::Picture	1544	1024	2015-03-16 20:26:35.401874	2015-03-16 20:26:35.401874
82	81720034.JPG	image/jpeg	632339	\N	\N	RedactorRails::Picture	1544	1024	2015-03-16 20:27:12.266268	2015-03-16 20:27:12.266268
83	0149.png	image/png	1840461	\N	\N	RedactorRails::Picture	1700	1662	2015-04-21 03:38:57.321104	2015-04-21 03:38:57.321104
84	1.jpg	image/jpeg	1492187	\N	\N	RedactorRails::Picture	2560	1920	2015-05-12 06:42:11.097518	2015-05-12 06:42:11.097518
85	2.jpg	image/jpeg	1590213	\N	\N	RedactorRails::Picture	2560	1920	2015-05-12 06:42:55.363054	2015-05-12 06:42:55.363054
86	3.jpg	image/jpeg	1527015	\N	\N	RedactorRails::Picture	2560	1920	2015-05-12 06:46:29.126962	2015-05-12 06:46:29.126962
87	4.jpg	image/jpeg	923662	\N	\N	RedactorRails::Picture	1536	2048	2015-05-12 06:47:45.440118	2015-05-12 06:47:45.440118
88	5.jpg	image/jpeg	778144	\N	\N	RedactorRails::Picture	2560	1920	2015-05-12 06:48:15.5114	2015-05-12 06:48:15.5114
89	6.jpg	image/jpeg	917721	\N	\N	RedactorRails::Picture	2560	1920	2015-05-12 06:48:42.447912	2015-05-12 06:48:42.447912
90	7.jpg	image/jpeg	633130	\N	\N	RedactorRails::Picture	2560	1920	2015-05-12 06:49:39.200546	2015-05-12 06:49:39.200546
91	8.jpg	image/jpeg	653859	\N	\N	RedactorRails::Picture	2560	1920	2015-05-12 06:52:06.017606	2015-05-12 06:52:06.017606
92	8.jpg	image/jpeg	653859	\N	\N	RedactorRails::Picture	2560	1920	2015-05-12 06:54:02.319282	2015-05-12 06:54:02.319282
93	9.jpg	image/jpeg	776851	\N	\N	RedactorRails::Picture	2560	1920	2015-05-12 06:54:49.019397	2015-05-12 06:54:49.019397
94	10.jpg	image/jpeg	1102590	\N	\N	RedactorRails::Picture	1536	2048	2015-05-12 06:55:38.699103	2015-05-12 06:55:38.699103
95	11.jpg	image/jpeg	1212419	\N	\N	RedactorRails::Picture	2560	1920	2015-05-12 06:56:13.649473	2015-05-12 06:56:13.649473
96	12.jpg	image/jpeg	1288272	\N	\N	RedactorRails::Picture	2560	1920	2015-05-12 06:57:00.093172	2015-05-12 06:57:00.093172
97	20150417_131256_061.jpg	image/jpeg	968087	\N	\N	RedactorRails::Picture	2448	2448	2015-05-12 07:26:49.270362	2015-05-12 07:26:49.270362
98	20150417_132057_133.jpg	image/jpeg	941363	\N	\N	RedactorRails::Picture	2448	2448	2015-05-12 07:27:28.065375	2015-05-12 07:27:28.065375
99	20150417_132114_300.jpg	image/jpeg	971581	\N	\N	RedactorRails::Picture	2448	2448	2015-05-12 07:28:26.574034	2015-05-12 07:28:26.574034
100	20150417_132153_948.jpg	image/jpeg	694174	\N	\N	RedactorRails::Picture	2448	2448	2015-05-12 07:28:51.455914	2015-05-12 07:28:51.455914
\.


--
-- Name: redactor_assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: scarfacedeb
--

SELECT pg_catalog.setval('redactor_assets_id_seq', 100, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: scarfacedeb
--

COPY schema_migrations (version) FROM stdin;
20130828165557
20130828165558
20130828193041
20130829014643
20130905115903
20130919082200
20131231000000
20131231120004
20131231120452
20140302085942
20140302121956
20140407160648
20140502105827
20140502130220
20140526152156
20140913082726
20140913084903
20141027085053
20141029070221
20141113115258
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: scarfacedeb
--

COPY users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at) FROM stdin;
3	nonpandoras@gmail.com	$2a$10$.StlhLnCcJ8W7k8B4VXEt.XxGHdfs/vQyJk6lBbsC6h6kRWMKgtt.	\N	\N	2014-11-21 07:50:10.099027	102	2015-05-19 08:55:45.008313	2015-05-14 04:12:44.123406	89.204.18.70	89.204.60.80	2014-05-03 13:35:35.776491	2015-05-19 08:55:45.010661
1	scarfacedeb@yandex.ru	$2a$10$gTUqrmAgpg1LPhl53Ezrh.9pr7sPcqPPNY.TywtCNNUwvd2KzlLZ.	\N	\N	2014-05-03 13:34:42.041379	2	2014-10-29 17:07:37.589833	2014-05-03 13:34:42.047309	188.186.63.219	109.201.154.160	2014-02-18 10:52:05.243579	2014-10-29 17:07:37.591803
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: scarfacedeb
--

SELECT pg_catalog.setval('users_id_seq', 3, true);


--
-- Name: artwork_decoration_translations artwork_decoration_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY artwork_decoration_translations
    ADD CONSTRAINT artwork_decoration_translations_pkey PRIMARY KEY (id);


--
-- Name: artwork_decorations artwork_decorations_pkey; Type: CONSTRAINT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY artwork_decorations
    ADD CONSTRAINT artwork_decorations_pkey PRIMARY KEY (id);


--
-- Name: artwork_translations artwork_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY artwork_translations
    ADD CONSTRAINT artwork_translations_pkey PRIMARY KEY (id);


--
-- Name: artworks artworks_pkey; Type: CONSTRAINT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY artworks
    ADD CONSTRAINT artworks_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: category_translations category_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY category_translations
    ADD CONSTRAINT category_translations_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: page_translations page_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY page_translations
    ADD CONSTRAINT page_translations_pkey PRIMARY KEY (id);


--
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: post_translations post_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY post_translations
    ADD CONSTRAINT post_translations_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: rails_admin_histories rails_admin_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY rails_admin_histories
    ADD CONSTRAINT rails_admin_histories_pkey PRIMARY KEY (id);


--
-- Name: redactor_assets redactor_assets_pkey; Type: CONSTRAINT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY redactor_assets
    ADD CONSTRAINT redactor_assets_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_redactor_assetable; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE INDEX idx_redactor_assetable ON redactor_assets USING btree (assetable_type, assetable_id);


--
-- Name: idx_redactor_assetable_type; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE INDEX idx_redactor_assetable_type ON redactor_assets USING btree (assetable_type, type, assetable_id);


--
-- Name: index_artwork_decoration_translations_on_artwork_decoration_id; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE INDEX index_artwork_decoration_translations_on_artwork_decoration_id ON artwork_decoration_translations USING btree (artwork_decoration_id);


--
-- Name: index_artwork_decoration_translations_on_locale; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE INDEX index_artwork_decoration_translations_on_locale ON artwork_decoration_translations USING btree (locale);


--
-- Name: index_artwork_decorations_on_position; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE INDEX index_artwork_decorations_on_position ON artwork_decorations USING btree ("position");


--
-- Name: index_artwork_decorations_on_type; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE INDEX index_artwork_decorations_on_type ON artwork_decorations USING btree (type);


--
-- Name: index_artwork_translations_on_artwork_id; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE INDEX index_artwork_translations_on_artwork_id ON artwork_translations USING btree (artwork_id);


--
-- Name: index_artwork_translations_on_locale; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE INDEX index_artwork_translations_on_locale ON artwork_translations USING btree (locale);


--
-- Name: index_artworks_on_category_id; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE INDEX index_artworks_on_category_id ON artworks USING btree (category_id);


--
-- Name: index_categories_on_slug; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE UNIQUE INDEX index_categories_on_slug ON categories USING btree (slug);


--
-- Name: index_category_translations_on_category_id; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE INDEX index_category_translations_on_category_id ON category_translations USING btree (category_id);


--
-- Name: index_category_translations_on_locale; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE INDEX index_category_translations_on_locale ON category_translations USING btree (locale);


--
-- Name: index_order_items_on_artwork_id; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE INDEX index_order_items_on_artwork_id ON order_items USING btree (artwork_id);


--
-- Name: index_order_items_on_frame_bg_id; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE INDEX index_order_items_on_frame_bg_id ON order_items USING btree (frame_bg_id);


--
-- Name: index_order_items_on_frame_id; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE INDEX index_order_items_on_frame_id ON order_items USING btree (frame_id);


--
-- Name: index_order_items_on_mat_bg_id; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE INDEX index_order_items_on_mat_bg_id ON order_items USING btree (mat_bg_id);


--
-- Name: index_order_items_on_order_id; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE INDEX index_order_items_on_order_id ON order_items USING btree (order_id);


--
-- Name: index_orders_on_status; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE INDEX index_orders_on_status ON orders USING btree (status);


--
-- Name: index_page_translations_on_locale; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE INDEX index_page_translations_on_locale ON page_translations USING btree (locale);


--
-- Name: index_page_translations_on_page_id; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE INDEX index_page_translations_on_page_id ON page_translations USING btree (page_id);


--
-- Name: index_pages_on_slug; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE UNIQUE INDEX index_pages_on_slug ON pages USING btree (slug);


--
-- Name: index_post_translations_on_locale; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE INDEX index_post_translations_on_locale ON post_translations USING btree (locale);


--
-- Name: index_post_translations_on_post_id; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE INDEX index_post_translations_on_post_id ON post_translations USING btree (post_id);


--
-- Name: index_rails_admin_histories; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE INDEX index_rails_admin_histories ON rails_admin_histories USING btree (item, "table", month, year);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: scarfacedeb
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: artworks category_fk; Type: FK CONSTRAINT; Schema: public; Owner: scarfacedeb
--

ALTER TABLE ONLY artworks
    ADD CONSTRAINT category_fk FOREIGN KEY (category_id) REFERENCES categories(id);


--
-- PostgreSQL database dump complete
--


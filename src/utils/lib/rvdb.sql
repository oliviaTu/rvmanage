

ALTER TABLE insert_lock OWNER TO postgres;
SET search_path = public, pg_catalog;
CREATE TABLE t_abnormal_log (
    id integer NOT NULL,
    net_type integer,
    abnormal_time character varying(20),
    content text
);
ALTER TABLE t_abnormal_log OWNER TO postgres;
CREATE SEQUENCE t_abnormal_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE t_abnormal_log_id_seq OWNER TO postgres;

ALTER SEQUENCE t_abnormal_log_id_seq OWNED BY t_abnormal_log.id;
CREATE TABLE t_monitor_disk (
    id integer NOT NULL,
    server_id character varying(32) NOT NULL,
    disk_id character varying(32) NOT NULL,
    status integer,
    use_percent integer,
    create_time character varying(19),
    update_time character varying(19),
    remark character varying(128)
);

ALTER TABLE t_monitor_disk OWNER TO postgres;
CREATE SEQUENCE t_monitor_disk_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE t_monitor_disk_id_seq OWNER TO postgres;
ALTER SEQUENCE t_monitor_disk_id_seq OWNED BY t_monitor_disk.id;
CREATE TABLE t_monitor_server (
    id integer NOT NULL,
    server_id character varying(32) NOT NULL,
    online integer,
    cpu double precision,
    memory double precision,
    disk_read integer,
    disk_write integer,
    disk_busy double precision,
    create_time character varying(19),
    update_time character varying(19),
    remark character varying(128)
);
ALTER TABLE t_monitor_server OWNER TO postgres;
CREATE SEQUENCE t_monitor_server_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE t_monitor_server_id_seq OWNER TO postgres;
ALTER SEQUENCE t_monitor_server_id_seq OWNED BY t_monitor_server.id;
CREATE TABLE t_monitor_streaming (
    id integer NOT NULL,
    server_id character varying(32) NOT NULL,
    channel_id character varying(36) NOT NULL,
    status integer,
    create_time character varying(19),
    update_time character varying(19),
    remark character varying(128)
);
ALTER TABLE t_monitor_streaming OWNER TO postgres;
CREATE SEQUENCE t_monitor_streaming_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE t_monitor_streaming_id_seq OWNER TO postgres;
ALTER SEQUENCE t_monitor_streaming_id_seq OWNED BY t_monitor_streaming.id;
CREATE TABLE t_program_state (
    id integer NOT NULL,
    program_id integer NOT NULL,
    upload_state integer NOT NULL,
    upload_url character varying(200),
    notify_state integer NOT NULL,
    notify_url character varying(200),
    revod_nums integer,
    rvlss_nums integer,
    remark character varying(500),
    update_time character varying(19)
);
ALTER TABLE t_program_state OWNER TO postgres;
CREATE SEQUENCE t_program_state_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE t_program_state_id_seq OWNER TO postgres;
ALTER SEQUENCE t_program_state_id_seq OWNED BY t_program_state.id;
CREATE TABLE t_record_disk (
    id integer NOT NULL,
    disk_id character varying(36) NOT NULL,
    disk_name character varying(100),
    disk_product character varying(100) NOT NULL,
    disk_size integer,
    record_path character varying(200),
    status integer,
    disk_mem integer,
    create_time character varying(19),
    update_time character varying(19),
    remark character varying(128)
);
ALTER TABLE t_record_disk OWNER TO postgres;
CREATE SEQUENCE t_record_disk_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE t_record_disk_id_seq OWNER TO postgres;
ALTER SEQUENCE t_record_disk_id_seq OWNED BY t_record_disk.id;
CREATE TABLE t_record_epg (
    id integer NOT NULL,
    epg_key character varying(36) NOT NULL,
    epg_name character varying(100) NOT NULL,
    epg_ip character varying(15),
    epg_port integer,
    create_time character varying(19),
    update_time character varying(19),
    remark character varying(128)
);
ALTER TABLE t_record_epg OWNER TO postgres;
CREATE SEQUENCE t_record_epg_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE t_record_epg_id_seq OWNER TO postgres;
ALTER SEQUENCE t_record_epg_id_seq OWNED BY t_record_epg.id;
CREATE TABLE t_record_program (
    id integer NOT NULL,
    program_name character varying(200) NOT NULL,
    serial integer NOT NULL,
    channel_id character varying(36) NOT NULL,
    channel_name character varying(200) NOT NULL,
    program_code character varying(36) NOT NULL,
    date character varying(10) NOT NULL,
    range character varying(11) NOT NULL,
    asset_id character varying(36),
    program_duration integer NOT NULL,
    record_duration integer NOT NULL,
    download_url character varying(256),
    file_size bigint,
    file_path character varying(200),
    file_name character varying(200),
    md5 character varying(32),
    record_state integer NOT NULL,
    transcode_state integer NOT NULL,
    create_time character varying(19),
    update_time character varying(19),
    remark character varying(128)
);
ALTER TABLE t_record_program OWNER TO postgres;
CREATE SEQUENCE t_record_program_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE t_record_program_id_seq OWNER TO postgres;
ALTER SEQUENCE t_record_program_id_seq OWNED BY t_record_program.id;
CREATE TABLE t_record_server (
    id integer NOT NULL,
    server_id character varying(36) NOT NULL,
    server_name character varying(100) NOT NULL,
    server_ip character varying(15) NOT NULL,
    server_port character varying(10),
    network_up_bandwidth integer,
    network_down_bandwidth integer,
    cpu integer,
    memory integer,
    conf_content character varying(2048) NOT NULL,
    create_time character varying(19),
    update_time character varying(19),
    remark character varying(128)
);
ALTER TABLE t_record_server OWNER TO postgres;
CREATE SEQUENCE t_record_server_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE t_record_server_id_seq OWNER TO postgres;
ALTER SEQUENCE t_record_server_id_seq OWNED BY t_record_server.id;
CREATE TABLE t_record_streaming (
    id integer NOT NULL,
    channel_id character varying(36) NOT NULL,
    channel_name character varying(100) NOT NULL,
    provider character varying(32) NOT NULL,
    cms_channel_id character varying(36) NOT NULL,
    lang character varying(40) NOT NULL,
    stream_app character varying(36) NOT NULL,
    notify_url character varying(200) NOT NULL,
    storage_day integer NOT NULL,
    bit_rate_type double precision,
    record_flag integer NOT NULL,
    upload_flag integer NOT NULL,
    protocol character varying(10) NOT NULL,
    transcode_flag integer NOT NULL,
    vcodec character varying(36) NOT NULL,
    create_time character varying(19),
    update_time character varying(19),
    remark character varying(128)
);
ALTER TABLE t_record_streaming OWNER TO postgres;
CREATE SEQUENCE t_record_streaming_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE t_record_streaming_id_seq OWNER TO postgres;
ALTER SEQUENCE t_record_streaming_id_seq OWNED BY t_record_streaming.id;
CREATE TABLE t_record_upload (
    id integer NOT NULL,
    upload_id character varying(36) NOT NULL,
    upload_name character varying(100) NOT NULL,
    upload_url character varying(200) NOT NULL,
    ingest_num integer NOT NULL,
    create_time character varying(19),
    update_time character varying(19),
    remark character varying(128)
);

ALTER TABLE t_record_upload OWNER TO postgres;
CREATE SEQUENCE t_record_upload_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE t_record_upload_id_seq OWNER TO postgres;
ALTER SEQUENCE t_record_upload_id_seq OWNED BY t_record_upload.id;
CREATE TABLE t_server_disk (
    id integer NOT NULL,
    server_id character varying(36) NOT NULL,
    disk_id character varying(32),
    remark character varying(128)
);
ALTER TABLE t_server_disk OWNER TO postgres;

CREATE SEQUENCE t_server_disk_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE t_server_disk_id_seq OWNER TO postgres;
ALTER SEQUENCE t_server_disk_id_seq OWNED BY t_server_disk.id;
CREATE TABLE t_streaming_epg (
    id integer NOT NULL,
    channel_id character varying(36) NOT NULL,
    epg_key character varying(32),
    remark character varying(128)
);
ALTER TABLE t_streaming_epg OWNER TO postgres;


CREATE SEQUENCE t_streaming_epg_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE t_streaming_epg_id_seq OWNER TO postgres;
ALTER SEQUENCE t_streaming_epg_id_seq OWNED BY t_streaming_epg.id;
CREATE TABLE t_streaming_server (
    id integer NOT NULL,
    channel_id character varying(36) NOT NULL,
    server_id character varying(20),
    remark character varying(128)
);
ALTER TABLE t_streaming_server OWNER TO postgres;
CREATE SEQUENCE t_streaming_server_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE t_streaming_server_id_seq OWNER TO postgres;
ALTER SEQUENCE t_streaming_server_id_seq OWNED BY t_streaming_server.id;
CREATE TABLE t_streaming_upload (
    id integer NOT NULL,
    channel_id character varying(36) NOT NULL,
    upload_id character varying(32),
    remark character varying(128)
);
ALTER TABLE t_streaming_upload OWNER TO postgres;
CREATE SEQUENCE t_streaming_upload_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER TABLE t_streaming_upload_id_seq OWNER TO postgres;
ALTER SEQUENCE t_streaming_upload_id_seq OWNED BY t_streaming_upload.id;
ALTER TABLE ONLY t_abnormal_log ALTER COLUMN id SET DEFAULT nextval('t_abnormal_log_id_seq'::regclass);
ALTER TABLE ONLY t_monitor_disk ALTER COLUMN id SET DEFAULT nextval('t_monitor_disk_id_seq'::regclass);
ALTER TABLE ONLY t_monitor_server ALTER COLUMN id SET DEFAULT nextval('t_monitor_server_id_seq'::regclass);
ALTER TABLE ONLY t_monitor_streaming ALTER COLUMN id SET DEFAULT nextval('t_monitor_streaming_id_seq'::regclass);
ALTER TABLE ONLY t_program_state ALTER COLUMN id SET DEFAULT nextval('t_program_state_id_seq'::regclass);
ALTER TABLE ONLY t_record_disk ALTER COLUMN id SET DEFAULT nextval('t_record_disk_id_seq'::regclass);
ALTER TABLE ONLY t_record_epg ALTER COLUMN id SET DEFAULT nextval('t_record_epg_id_seq'::regclass);
ALTER TABLE ONLY t_record_program ALTER COLUMN id SET DEFAULT nextval('t_record_program_id_seq'::regclass);
ALTER TABLE ONLY t_record_server ALTER COLUMN id SET DEFAULT nextval('t_record_server_id_seq'::regclass);
ALTER TABLE ONLY t_record_streaming ALTER COLUMN id SET DEFAULT nextval('t_record_streaming_id_seq'::regclass);
ALTER TABLE ONLY t_record_upload ALTER COLUMN id SET DEFAULT nextval('t_record_upload_id_seq'::regclass);
ALTER TABLE ONLY t_server_disk ALTER COLUMN id SET DEFAULT nextval('t_server_disk_id_seq'::regclass);
ALTER TABLE ONLY t_streaming_epg ALTER COLUMN id SET DEFAULT nextval('t_streaming_epg_id_seq'::regclass);
ALTER TABLE ONLY t_streaming_server ALTER COLUMN id SET DEFAULT nextval('t_streaming_server_id_seq'::regclass);
ALTER TABLE ONLY t_streaming_upload ALTER COLUMN id SET DEFAULT nextval('t_streaming_upload_id_seq'::regclass);

ALTER TABLE ONLY insert_lock
    ADD CONSTRAINT insert_lock_pkey PRIMARY KEY (reloid);


SET search_path = public, pg_catalog;


ALTER TABLE ONLY t_abnormal_log
    ADD CONSTRAINT t_abnormal_log_pkey PRIMARY KEY (id);



ALTER TABLE ONLY t_monitor_disk
    ADD CONSTRAINT t_monitor_disk_pkey PRIMARY KEY (id);



ALTER TABLE ONLY t_monitor_disk
    ADD CONSTRAINT t_monitor_disk_server_id_disk_id_key UNIQUE (server_id, disk_id);



ALTER TABLE ONLY t_monitor_server
    ADD CONSTRAINT t_monitor_server_pkey PRIMARY KEY (id);



ALTER TABLE ONLY t_monitor_streaming
    ADD CONSTRAINT t_monitor_streaming_pkey PRIMARY KEY (id);



ALTER TABLE ONLY t_monitor_streaming
    ADD CONSTRAINT t_monitor_streaming_server_id_channel_id_key UNIQUE (server_id, channel_id);



ALTER TABLE ONLY t_program_state
    ADD CONSTRAINT t_program_state_pkey PRIMARY KEY (id);



ALTER TABLE ONLY t_program_state
    ADD CONSTRAINT t_program_state_program_id_key UNIQUE (program_id);



ALTER TABLE ONLY t_record_disk
    ADD CONSTRAINT t_record_disk_disk_id_key UNIQUE (disk_id);



ALTER TABLE ONLY t_record_disk
    ADD CONSTRAINT t_record_disk_pkey PRIMARY KEY (id);



ALTER TABLE ONLY t_record_epg
    ADD CONSTRAINT t_record_epg_epg_key_key UNIQUE (epg_key);



ALTER TABLE ONLY t_record_epg
    ADD CONSTRAINT t_record_epg_epg_name_key UNIQUE (epg_name);



ALTER TABLE ONLY t_record_epg
    ADD CONSTRAINT t_record_epg_pkey PRIMARY KEY (id);



ALTER TABLE ONLY t_record_program
    ADD CONSTRAINT t_record_program_pkey PRIMARY KEY (id);



ALTER TABLE ONLY t_record_program
    ADD CONSTRAINT t_record_program_serial_channel_id_date_key UNIQUE (serial, channel_id, date);

ALTER TABLE ONLY t_record_server
    ADD CONSTRAINT t_record_server_pkey PRIMARY KEY (id);

ALTER TABLE ONLY t_record_server
    ADD CONSTRAINT t_record_server_server_id_key UNIQUE (server_id);



ALTER TABLE ONLY t_record_server
    ADD CONSTRAINT t_record_server_server_ip_key UNIQUE (server_ip);



ALTER TABLE ONLY t_record_server
    ADD CONSTRAINT t_record_server_server_name_key UNIQUE (server_name);



ALTER TABLE ONLY t_record_streaming
    ADD CONSTRAINT t_record_streaming_channel_id_key UNIQUE (channel_id);



ALTER TABLE ONLY t_record_streaming
    ADD CONSTRAINT t_record_streaming_pkey PRIMARY KEY (id);



ALTER TABLE ONLY t_record_upload
    ADD CONSTRAINT t_record_upload_pkey PRIMARY KEY (id);



ALTER TABLE ONLY t_record_upload
    ADD CONSTRAINT t_record_upload_upload_id_key UNIQUE (upload_id);



ALTER TABLE ONLY t_record_upload
    ADD CONSTRAINT t_record_upload_upload_name_key UNIQUE (upload_name);



ALTER TABLE ONLY t_server_disk
    ADD CONSTRAINT t_server_disk_pkey PRIMARY KEY (id);



ALTER TABLE ONLY t_streaming_epg
    ADD CONSTRAINT t_streaming_epg_pkey PRIMARY KEY (id);



ALTER TABLE ONLY t_streaming_server
    ADD CONSTRAINT t_streaming_server_pkey PRIMARY KEY (id);



ALTER TABLE ONLY t_streaming_upload
    ADD CONSTRAINT t_streaming_upload_pkey PRIMARY KEY (id);



CREATE INDEX idx_channel_epg ON t_streaming_epg USING btree (channel_id);



CREATE INDEX idx_channel_id ON t_record_streaming USING btree (channel_id);



CREATE INDEX idx_channel_name ON t_record_streaming USING btree (channel_name);



CREATE INDEX idx_channel_server ON t_streaming_server USING btree (channel_id);



CREATE INDEX idx_channel_upload ON t_streaming_upload USING btree (channel_id);



CREATE INDEX idx_disk_create_time ON t_record_disk USING btree (create_time);



CREATE INDEX idx_disk_id ON t_record_disk USING btree (disk_id);



CREATE INDEX idx_disk_update_time ON t_record_disk USING btree (update_time);



CREATE INDEX idx_epg_key ON t_record_epg USING btree (epg_key);



CREATE INDEX idx_epg_name ON t_record_epg USING btree (epg_name);



CREATE UNIQUE INDEX idx_monitor_server_disk_id ON t_monitor_disk USING btree (server_id, disk_id);



CREATE INDEX idx_monitor_server_id ON t_monitor_server USING btree (server_id);



CREATE UNIQUE INDEX idx_monitor_server_streaming_id ON t_monitor_streaming USING btree (server_id, channel_id);



CREATE UNIQUE INDEX idx_program_code ON t_record_program USING btree (program_code);



CREATE INDEX idx_server_disk ON t_server_disk USING btree (server_id);



CREATE INDEX idx_server_id ON t_record_server USING btree (server_id);



CREATE INDEX idx_server_ip ON t_record_server USING btree (server_ip);



CREATE INDEX idx_server_name ON t_record_server USING btree (server_name);



CREATE INDEX idx_stream_create_time ON t_record_streaming USING btree (create_time);



CREATE INDEX idx_stream_update_time ON t_record_streaming USING btree (update_time);



CREATE UNIQUE INDEX idx_union_program ON t_record_program USING btree (serial, channel_id, date);



CREATE INDEX idx_upload_id ON t_record_upload USING btree (upload_id);



CREATE INDEX idx_upload_name ON t_record_upload USING btree (upload_name);

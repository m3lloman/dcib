drop table IF EXISTS msg;
drop table IF EXISTS df_schedule;
drop table IF EXISTS msgtype;
drop table IF EXISTS channel;
drop table IF EXISTS location;
create table location
(
        locationid SERIAL,
        track TEXT,
        room TEXT,
        CONSTRAINT location_pk PRIMARY KEY(locationid)
);

create table channel
(
        channel VARCHAR(200),
        CONSTRAINT channel_pk PRIMARY KEY(channel)
);

create table msgtype
(
	msgtype VARCHAR(200),
	fontcolor TEXT,
	fontstyle TEXT,
	CONSTRAINT msgtype_pk PRIMARY KEY(msgtype)
);

create table df_schedule
(
        indexsch SERIAL,
        locationid bigint unsigned,
	channel VARCHAR(200),
        date date,
        time_begin time,
        time_end time,
        who TEXT,
	link TEXT,
        title TEXT,
	submitter TEXT,
	comment TEXT,
	msgtype VARCHAR(200),
	demo BOOLEAN,
	tool BOOLEAN,
	exploit BOOLEAN,
        CONSTRAINT df_schedule_pk PRIMARY KEY(indexsch),
        CONSTRAINT df_schedule_locationid_fk Foreign Key(locationid) REFERENCES location(locationid),
        CONSTRAINT df_schedule_channel_fk Foreign Key(channel) REFERENCES channel(channel),
        CONSTRAINT df_schedule_msgtype_fk Foreign Key(msgtype) REFERENCES msgtype(msgtype)
);


create table msg
(
	indexmsg	SERIAL,
	msgtype	VARCHAR(200),
	timeadd	TIMESTAMP,
	timeexpire	TIMESTAMP,
	contact	TEXT,
	msg	TEXT,
	CONSTRAINT msg_pk PRIMARY KEY(indexmsg),
	CONSTRAINT msg_mt_fk FOREIGN KEY(msgtype) REFERENCES msgtype(msgtype)
);

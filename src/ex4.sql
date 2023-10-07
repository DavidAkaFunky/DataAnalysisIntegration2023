SET NAMES utf8;

DROP DATABASE IF EXISTS energy;

CREATE DATABASE IF NOT EXISTS energy DEFAULT CHARACTER SET utf8;

USE energy;

DROP TABLE IF EXISTS energy_consumption;
DROP TABLE IF EXISTS time;
DROP TABLE IF EXISTS location;
DROP TABLE IF EXISTS voltage;

CREATE TABLE time (
    time_id INTEGER PRIMARY KEY,
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    UNIQUE(year, month)
);

CREATE TABLE location (
    location_id INTEGER PRIMARY KEY,
    district VARCHAR(16) NOT NULL,
    municipality VARCHAR(27) NOT NULL,
    parish VARCHAR(30) NOT NULL,
    UNIQUE(district, municipality, parish)
);

CREATE TABLE voltage (
    voltage_id INTEGER PRIMARY KEY,
    level VARCHAR(32) NOT NULL UNIQUE
);

CREATE TABLE energy_consumption (
    id SERIAL,
    time_id INTEGER NOT NULL REFERENCES time(time_id),
    location_id INTEGER NOT NULL REFERENCES location(location_id),
    voltage_id INTEGER NOT NULL REFERENCES voltage(voltage_id),
    consumption NUMERIC(12, 3) NOT NULL,
    UNIQUE(time_id, location_id, voltage_id)
);
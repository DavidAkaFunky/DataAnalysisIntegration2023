
DROP DATABASE IF EXISTS energy_consumption_dw;

CREATE DATABASE energy_consumption_dw;

USE energy_consumption_dw;

DROP TABLE IF EXISTS dim_time, dim_location, dim_voltage, fact_consumption;

CREATE TABLE dim_time (
    TIME_ID INT NOT NULL,
    YEAR_ID INT NOT NULL,
    MONTH_ID INT NOT NULL,
    PRIMARY KEY (TIME_ID),
    UNIQUE KEY (YEAR_ID, MONTH_ID)
);

CREATE TABLE dim_location (
    LOCATION_ID INT NOT NULL,
    DISTRICT VARCHAR(16) NOT NULL,
    MUNICIPALITY VARCHAR(27) NOT NULL,
    PARISH VARCHAR(30) NOT NULL,
    PRIMARY KEY (LOCATION_ID),
    UNIQUE KEY (DISTRICT, MUNICIPALITY, PARISH)
);

CREATE TABLE dim_voltage (
    VOLTAGE_ID INT NOT NULL,
    LEVEL VARCHAR(32) NOT NULL,
    PRIMARY KEY (VOLTAGE_ID),
    UNIQUE KEY (LEVEL)
);

CREATE TABLE fact_consumption (
    ID SERIAL,
    CONSUMPTION NUMERIC(12, 3) NOT NULL,
    TIME_ID INT NOT NULL,
    LOCATION_ID INT NOT NULL,
    VOLTAGE_ID INT NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (TIME_ID) REFERENCES dim_time (TIME_ID),
    FOREIGN KEY (LOCATION_ID) REFERENCES dim_location (LOCATION_ID),
    FOREIGN KEY (VOLTAGE_ID) REFERENCES dim_voltage (VOLTAGE_ID),
    UNIQUE KEY (TIME_ID, LOCATION_ID, VOLTAGE_ID)
);
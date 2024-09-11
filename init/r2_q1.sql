CREATE DATABASE r2_q1;
USE r2_q1;
-- 生産
CREATE TABLE 生産 (
    生産番号 INT PRIMARY KEY,
    生産完了予定日時 DATETIME,
    生産完了日時 DATETIME
);

-- 生産明細
CREATE TABLE 生産明細 (
    生産番号 INT,
    生産数量 INT,
    PRIMARY KEY (生産番号),
    FOREIGN KEY (生産番号) REFERENCES 生産(生産番号)
);

-- 配送
CREATE TABLE 配送 (
    配送番号 INT PRIMARY KEY,
    配送完了予定日時 DATETIME
);

-- 配送明細
CREATE TABLE 配送明細 (
    配送番号 INT,
    配送数量 INT,
    店舗受領日時 DATETIME,
    店舗受領担当者 VARCHAR(100),
    PRIMARY KEY (配送番号),
    FOREIGN KEY (配送番号) REFERENCES 配送(配送番号)
);
